//
//  WHThirdService.m
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHThirdService.h"

#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation WHThirdService

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] wh_setupUMC];
        [[self class] wh_setupBugly];
        [[self class] wh_setKeyBord];
        [[self class] wh_testReachableStaus];
    });
}


#pragma mark - 配置友盟

+ (void)wh_setupUMC
{
//    [UMConfigure setEncryptEnabled:YES];   //打开加密传输
//    //    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK
//    //    NSString * deviceID = [UMConfigure deviceIDForIntegration];
//    //    NSLog(@"集成测试的deviceID:%@", deviceID);
//    [MobClick setScenarioType:E_UM_NORMAL];
    
#ifdef DEBUG
//    [UMConfigure setLogEnabled:YES];//设置打开日志
#endif
    
    //#ifdef DEBUG
    //    [UMConfigure initWithAppkey:kUMCTestAppkey channel:nil];
    //#else
//    [UMConfigure initWithAppkey:kUMAppkey channel:nil];
    //#endif
    
//    //设置微信的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWXAppkey appSecret:kWXAppSecret redirectURL:DDRedirectURL];
//
//    [WXApi registerApp:kWXAppkey];
    
    //设置分享到QQ互联的appKey和appSecret
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQAppkey  appSecret:kQQAppSecret redirectURL:DDRedirectURL];
    //    //设置新浪的appKey和appSecret
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppkey  appSecret:kSinaAppSecret redirectURL:DDRedirectURL];
    /*   分享  end  */
}


#pragma mark - 配置 Bugly

+ (void)wh_setupBugly
{
//    [Bugly startWithAppId:kBuglyAppKey];
}


#pragma mark - 键盘回收相关

+ (void)wh_setKeyBord
{
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}


#pragma mark － 检测网络相关

+ (void)wh_testReachableStaus
{
    
}

@end
