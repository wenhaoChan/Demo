//
//  AppDelegate+Config.m
//  Demo
//
//  Created by zero on 2019/10/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import "AppDelegate+Config.h"

#import <UMCommon/UMConfigure.h>
#import <UShareUI/UMSocialShareUIConfig.h>

#import <XMNetworking/XMNetworking.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

#ifdef DEBUG
    #import <UMCommonLog/UMCommonLogHeaders.h>
#endif

@implementation AppDelegate (Config)

- (void)configThridService:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self wh_initNetworking];
    
    [self wh_setupUMC];
    
    [self wh_setKeyBord];
    
    [self wh_networkMonitoring];
}

#pragma mark - 网络请求配置

- (void)wh_initNetworking
{
    [XMCenter setupConfig:^(XMConfig *config) {
        // 公共服务端地址
        config.generalServer = api_server;
        // 公共请求头
//        NSString* token = User.token ? : @"";
//        config.generalHeaders = @{@"X-Auth-token": token};
        // 公共请求参数
        config.generalParameters = @{
            @"platform": @"iOS"
        };
        // 公共用户信息
        config.generalUserInfo = nil;
        // 请求的回调 Block 执行的 dispatch 队列（线程），如果为 NULL（默认），那么会在一个私有的并发队列（子线程）中执行回调 Block。
        config.callbackQueue = dispatch_get_main_queue();
        // 底层请求的引擎，默认为 [XMEngine sharedEngine] 单例对象
        config.engine = [XMEngine sharedEngine];
#ifdef DEBUG
        config.consoleLog = YES;
#endif
    }];
    
    // 自定义请求预处理逻辑
    [XMCenter setRequestProcessBlock:^(XMRequest *request) {
    }];
    
    // 对全局请求统一做业务错误码判断、数据模型转换、网络缓存等操作
    [XMCenter setResponseProcessBlock:^id(XMRequest *request, id responseObject, NSError *__autoreleasing *error) {
        
        BOOL err = !responseObject || ![responseObject isKindOfClass:[NSDictionary class]];
        if (err) {
            *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:5555 userInfo:nil];
            return nil;
        }
        
        NSInteger code = [responseObject[@"c"] integerValue];
        
        if (code != 0) {
  
            NSString* errMsg = responseObject[@"m"];
            if (WHStringIsEmpty(errMsg)) {
                errMsg = @"未知错误";
            }
            
            *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                         code:code
                                     userInfo:@{@"message" : errMsg}];
            return nil;
        }
        
        return responseObject[@"d"]; // or return a new object to reset value for responseObject
    }];
    
    // 错误信息统一过滤
    [XMCenter setErrorProcessBlock:^(XMRequest *request, NSError *__autoreleasing * error) {
        // 比如对不同的错误码统一错误提示等
        if (error) {
            // [MBProgressHUD showMessage:@"服务器开小差了，程序员小哥正在努力抢修"];
        }
    }];
}

#pragma mark - 配置友盟

- (void)wh_setupUMC
{
    [UMConfigure setEncryptEnabled:YES];   //打开加密传输
#ifdef DEBUG
    [UMCommonLogManager setUpUMCommonLogManager];
    [UMConfigure setLogEnabled:YES];//设置打开日志
#endif
    
    [UMConfigure initWithAppkey:kUMAppkey channel:nil];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:kWXAppkey
                                       appSecret:@""
                                     redirectURL:@""];
    
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),
                                                                                @(UMSocialPlatformType_WechatTimeLine)]];
    
//    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.isShow = NO;
//    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.isShow = NO;
}

#pragma mark - 键盘回收相关

- (void)wh_setKeyBord
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

#pragma mark - 监听网络

- (void)wh_networkMonitoring
{
    AFNetworkReachabilityManager* manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [MBProgressHUD showMessage:@"未知网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showMessage:@"当前无网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                break;
        }
    }];
    [manager startMonitoring];
}


@end
