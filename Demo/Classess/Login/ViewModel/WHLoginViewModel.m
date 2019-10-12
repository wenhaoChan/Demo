//
//  WHLoginViewModel.m
//  Demo
//
//  Created by zero on 2019/2/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHLoginViewModel.h"

@implementation WHLoginViewModel

- (void)wh_initialize
{
    self.mobile = @"";
    self.smsCode = @"";
    
    // 获取验证码
    _codeEnableSignal = [RACObserve(self, mobile) map:^id _Nullable(NSString *  _Nullable value) {
        return @(value.length >= 11);
    }];
   
    _clickCodeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                request.api = @"";
                request.parameters = @{@"mobile": self.mobile};
            } onSuccess:^(id _Nullable responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } onFailure:^(NSError * _Nullable error) {
                [subscriber sendError:error];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    
     // 登录按钮
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, mobile), RACObserve(self, smsCode)] reduce:^id(NSString* mobile, NSString* smsCode){
        return @(mobile.length >= 11 && smsCode.length >= 4);
    }];
    
    _clickLoginCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                request.api = @"";
                request.parameters = @{
                    @"mobile" : self.mobile,
                    @"code" : self.smsCode
                };
            } onSuccess:^(id _Nullable responseObject) {
                [subscriber sendNext:[WHUser yy_modelWithJSON:responseObject]];
                [subscriber sendCompleted];
            } onFailure:^(NSError * _Nullable error) {
                [subscriber sendError:error];
            }];
            
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
    }];
    
    [[_clickLoginCmd.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            [MBProgressHUD showLoading:@"正在登录..." onView:nil];
        } else {
            [MBProgressHUD hideMBProgressHUD:nil];
        }
    }];
    
    [_clickLoginCmd.executionSignals.switchToLatest subscribeNext:^(WHUser* _Nullable x) {
        UserManager.user = x;
        [MBProgressHUD showMessage:@"登录成功"];
    } error:^(NSError * _Nullable error) {
        
    } completed:^{
        [MBProgressHUD hideMBProgressHUD:nil];
    }];
}



@end
