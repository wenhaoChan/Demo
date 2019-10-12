//
//  WHLoginViewController.m
//  Demo
//
//  Created by zero on 2019/2/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHLoginViewController.h"

// ViewModels
#import "WHLoginViewModel.h"

// Controllers
#import "WHTabBarViewController.h"

@interface WHLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

@property (weak, nonatomic) IBOutlet UITextField *smscodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *smsCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) WHLoginViewModel* loginViewModel;

@end

@implementation WHLoginViewController

#pragma mark - life cycles methods

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark - private methods

- (void)wh_addSubviews
{
    WEAK
    [[_smsCodeButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
       STRONG
        [self.loginViewModel.clickCodeCmd execute:nil];
    }];
    
    [[_loginButton rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        STRONG
        [self.loginViewModel.clickLoginCmd execute:nil];
    }];

}

- (void)wh_bindViewModel
{
    self.loginViewModel = [[WHLoginViewModel alloc] init];
    
    RAC(self.loginViewModel, mobile) = _mobileTextField.rac_textSignal;
    RAC(self.loginViewModel, smsCode) = _smscodeTextField.rac_textSignal;
    
    WEAK
    [self.loginViewModel.codeEnableSignal subscribeNext:^(id _Nullable x) {
        STRONG
        self.smsCodeButton.enabled = [x boolValue];
        self.smsCodeButton.backgroundColor = [x boolValue] ? [UIColor orangeColor] : [UIColor lightGrayColor];
    }];
  
    [self.loginViewModel.loginEnableSignal subscribeNext:^(id  _Nullable x) {
        STRONG
        self.loginButton.enabled = [x boolValue];
        self.loginButton.backgroundColor = [x boolValue] ? [UIColor orangeColor] : [UIColor lightGrayColor];
    }];
    
    [self.loginViewModel.clickCodeCmd.executionSignals.switchToLatest subscribeNext:^(NSDictionary* x) {
        STRONG
        [MBProgressHUD showMessage:@"短信已发送，请注意查收"];
        [self countdown];
    }];
}

- (void)countdown
{
    self.mobileTextField.userInteractionEnabled = NO;
    self.smsCodeButton.userInteractionEnabled = NO;

    __block NSInteger number = 60;
    
    WEAK
    RACSignal* timerSignal = [[[RACSignal interval:1.0f onScheduler:[RACScheduler mainThreadScheduler]] map:^id(NSDate *date){
        --number;
        if (number <= 0) {
            return @"获取验证码";
        }else{
            return [NSString stringWithFormat:@"%lds", (long)number];
        }
    }] takeUntilBlock:^BOOL(id x){
        STRONG
        if (number < 0) {
            self.mobileTextField.userInteractionEnabled = YES;
            self.smsCodeButton.userInteractionEnabled = YES;
            return YES;
        }
        return NO;
    }];
    
    [timerSignal subscribeNext:^(NSString* x) {
        STRONG
        [UIView performWithoutAnimation:^{
            [self.smsCodeButton setTitle:x forState:UIControlStateNormal];
            [self.smsCodeButton layoutIfNeeded];
        }];
    }];
}


#pragma mark - network methods




#pragma mark - public methods



#pragma mark - Event Response methods



#pragma mark - <#UITableView#> Delegate



#pragma mark - <#UITableView#> Datasource



#pragma mark - Custom Delegate



#pragma mark - getter



#pragma mark - setter

@end
