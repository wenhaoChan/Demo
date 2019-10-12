//
//  MBProgressHUD+Tip.m
//  jobStudentiOS
//
//  Created by CGC on 2017/4/17.
//  Copyright © 2017年 clitics. All rights reserved.
//

#import "MBProgressHUD+Tip.h"

@implementation MBProgressHUD (Tip)

+ (MBProgressHUD *)hud:(id)view message:(NSString *)message displayTime:(NSTimeInterval)delay
{
    if (!view) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    [hud showAnimated:YES];
    [view bringSubviewToFront:hud];
    
    hud.removeFromSuperViewOnHide = YES;
    
    if (delay != 999) {
       [hud hideAnimated:YES afterDelay:delay > 0 ? delay : 30];
    }
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    
    hud.minShowTime = 1;
    hud.label.numberOfLines = 0;
    hud.label.text = message ? : @"数据加载中";
    hud.label.font = [UIFont systemFontOfSize:14.f];
    
    return hud;
}

+ (void)showMessage:(NSString *)message after:(NSTimeInterval)sec
{
    dispatch_after(dispatch_time_delay(sec), dispatch_get_main_queue(), ^{
        MBProgressHUD* hud = [self hud:nil message:message ?: @"" displayTime:sec];
        hud.mode = MBProgressHUDModeText;
    });
}

+ (void)showMessage:(NSString *)message
{
    dispatch_async_on_main_queue(^{
        MBProgressHUD* hud = [self hud:nil message:message ?: @"" displayTime:1.5];
        hud.mode = MBProgressHUDModeText;
    });
}

+ (void)showMessage:(NSString *)message stayTime:(NSTimeInterval)time
{
    dispatch_async_on_main_queue(^{
        MBProgressHUD* hud = [self hud:nil message:message ?: @"" displayTime:1];
        hud.minShowTime = time;
        hud.mode = MBProgressHUDModeText;
    });
}

+ (void)showMessage:(NSString *)message image:(UIImage *)image displayTime:(NSTimeInterval)delay inView:(UIView *)view
{
    if (!view) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    dispatch_async_on_main_queue(^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor blackColor];
        hud.bezelView.alpha = .8;
        hud.minSize = CGSizeMake(136, 136);
        hud.label.text = message ?: @"正在努力加载";
        hud.label.textColor = [UIColor whiteColor];
        hud.label.font = [UIFont systemFontOfSize:14.f];
        hud.contentColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.layer.cornerRadius = 12.0;
        hud.square = YES;
        
         [hud hideAnimated:YES afterDelay:delay > 0 ? delay : 30];
        
        UIImageView* imageView = [[UIImageView alloc] initWithImage:image ?: Image(@"logo")];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(0, 0, 80, 80);
        
        hud.customView = imageView;
    });
}

+ (void)showSuccessMessage:(NSString *)message
{
//    [self showMessage:message image:Image(@"creation_savesucceed") displayTime:1.f];
}


+ (void)showErrorMessage:(NSString *)message
{
//     [self showMessage:message image:Image(@"creation_ico_savefailed") displayTime:1.f];
}

#pragma mark - 加载等待提示

+ (void)showLoading:(NSString *)message onView:(UIView *)view
{
    dispatch_async_on_main_queue(^{
        [self hud:view message:message ?: @"数据加载中" displayTime:0];
    });
}

+ (void)showLoadingOnWindowWithMessage:(NSString *)message
{
    dispatch_async_on_main_queue(^{
        [self hud:nil message:message ?: @"数据加载中" displayTime:999];
    });
}

+ (void)hideMBProgressHUD:(UIView *)view
{
    if (!view) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    dispatch_async_on_main_queue(^{
        [self hideHUDForView:view animated:YES];
    });
}

+ (MBProgressHUD *)db_showProgressToView:(UIView *)view
                                 message:(NSString *)message
                             configBlock:(WHHUDConfigBlock)configBlock
{
    if (!view) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.contentColor = WHTopicColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = message ? : @"上传中...";
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    if (configBlock) {
        configBlock(hud);
    }
    return hud;
}

@end

