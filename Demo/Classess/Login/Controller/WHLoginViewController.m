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

// Others
#import <JKCountDownButton/JKCountDownButton.h>

@interface WHLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

@property (weak, nonatomic) IBOutlet UITextField *smscodeTextField;

@property (weak, nonatomic) IBOutlet JKCountDownButton *smsCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong) WHLoginViewModel* loginViewModel;

@end

@implementation WHLoginViewController

#pragma mark - life cycles methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
}

#pragma mark - private methods

- (void)wh_addSubviews
{
    [_smsCodeButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [sender startCountDownWithSecond:60];

        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%lus", (unsigned long)second];
            return title;
        }];
        
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            self.loginViewModel.sending = NO;
            return @"点击重新获取";
        }];
    }];
    
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
  
    [self.loginViewModel.loginEnableSignal subscribeNext:^(id _Nullable x) {
        STRONG
        self.loginButton.enabled = [x boolValue];
        self.loginButton.backgroundColor = [x boolValue] ? [UIColor orangeColor] : [UIColor lightGrayColor];
    }];
    
    [self.loginViewModel.clickCodeCmd.executionSignals subscribeNext:^(RACSignal *execution) {
        [[[execution dematerialize] deliverOn:[RACScheduler mainThreadScheduler]] subscribeError:^(NSError *error) {
            [self.smsCodeButton stopCountDown];
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
