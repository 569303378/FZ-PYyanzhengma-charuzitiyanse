//
//  ViewController.m
//  MFTextView
//
//  Created by lanouhn on 16/4/29.
//  Copyright © 2016年 Mifiste. All rights reserved.
//

#import "ViewController.h"
#import "AuthcodeView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) AuthcodeView *authcodeView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //显示验证码界面
    self.authcodeView = [[AuthcodeView alloc] initWithFrame:CGRectMake((kWidth - 100) / 2, 20, 100, 30)];
    [self.view addSubview:self.authcodeView];
    
    
    //提示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kWidth - 100) / 2, 60, 100, 30)];
    label.text = @"点击切换验证码";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor grayColor];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAuthcode)];
    [label addGestureRecognizer:tap];
    [self.view addSubview:label];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake((kWidth - 100) / 2, 100, 100, 30)];
    self.textField.placeholder = @"区分大小写";
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.isAccessibilityElement = YES;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    //字体颜色
    [self PYzitibianse];

    
}
#pragma mark ======== 字体变色
- (void)PYzitibianse {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.textField.frame) + 100, self.view.frame.size.width - 20, 30)];
    [self.view addSubview:self.label];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"迪士尼干扰手势"];
    
    [attriString addAttribute:NSForegroundColorAttributeName
     
                        value:[UIColor redColor]
     
                        range:[@"迪士尼干扰手势" rangeOfString:@"干扰"]];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:[@"迪士尼干扰手势" rangeOfString:@"迪士"]];
    self.label.attributedText= attriString;

}
#pragma mark ======== 手势
- (void)changeAuthcode {
    [self.authcodeView getAuthcode];
    [self.authcodeView setNeedsDisplay];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:self.authcodeView.authcodeString]) {
        UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"验证码正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alview show];
    } else {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20,@20,@-20];
        [self.textField.layer addAnimation:anim forKey:nil];
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        self.textField.text = @"";
        [self.textField resignFirstResponder];
    }
}

@end
