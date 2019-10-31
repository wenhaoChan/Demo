//
//  WHLoginViewModel.m
//  Demo
//
//  Created by zero on 2019/2/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHLoginViewModel.h"

#import "WHUser.h"
#import <YYModel/YYModel.h>
#import <UMShare/UMShare.h>

@implementation WHLoginViewModel

- (void)wh_initialize
{
    self.mobile = @"";
    self.smsCode = @"";
    
    // 获取验证码
    _codeEnableSignal = [RACObserve(self, mobile) map:^id _Nullable(NSString *  _Nullable value) {
        return @(value.length >= 11 && !self.sending);
    }];
   
    _clickCodeCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id input) {
        return [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            self.sending = YES;
            
            [XMCenter sendRequest:^(XMRequest * _Nonnull request) {
                request.api = @"";
                request.parameters = @{@"mobile": self.mobile};
            } onSuccess:^(id _Nullable responseObject) {
                [MBProgressHUD showMessage:@"短信已发送，请注意查收"];
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } onFailure:^(NSError * _Nullable error) {
                self.sending = NO;
                [MBProgressHUD showMessage:error.localizedDescription];
                [subscriber sendError:error];
            }];
            
            return [RACDisposable disposableWithBlock:^{}];
        }] replayLast] materialize] delay:1];
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
        [UserManager setUser:x];
        [MBProgressHUD showMessage:@"登录成功"];
    }];
    
    _platformLoginCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber* input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:input.integerValue currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    [MBProgressHUD showMessage:error.localizedDescription];
                    [subscriber sendError:error];
                    return;
                }
                
                UMSocialUserInfoResponse *resp = result;
                // 第三方登录数据(为空表示平台未提供)
                // 授权数据
                NSLog(@" uid: %@", resp.uid);
                NSLog(@" openid: %@", resp.openid);
                NSLog(@" accessToken: %@", resp.accessToken);
                NSLog(@" refreshToken: %@", resp.refreshToken);
                NSLog(@" expiration: %@", resp.expiration);
                // 用户数据
                NSLog(@" name: %@", resp.name);
                NSLog(@" iconurl: %@", resp.iconurl);
                NSLog(@" gender: %@", resp.unionGender);
                // 第三方平台SDK原始数据
                NSLog(@" originalResponse: %@", resp.originalResponse);
                
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }];
            return [RACDisposable disposableWithBlock:^{}];
        }];
    }];
}

@end
