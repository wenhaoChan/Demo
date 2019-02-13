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
    if (delay > 0) {
        [hud hideAnimated:YES afterDelay:delay];
    }
    
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:.5];
    
    hud.label.numberOfLines = 0;
    hud.label.text = message ? : @"数据加载中";
    hud.label.font = [UIFont systemFontOfSize:14.f];
    
    return hud;
}


//+ (MBProgressHUD *)showHUDByMessage:(NSString *)message displayTime:(NSTimeInterval)delay
//{
//    if (!message) {
//        message = @"";
//    }
////    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:YES];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        MBProgressHUD* hud = [self hud:[[UIApplication sharedApplication] keyWindow] message:message displayTime:<#(NSTimeInterval)#>];
//
////        hud.bezelView.color = [UIColor blackColor];
////        hud.contentColor = [UIColor whiteColor];
////        hud.label.text = message;
////        hud.label.numberOfLines = 0;
//////        hud.detailsLabel.text = message;
////        hud.label.font = [UIFont systemFontOfSize:14.f];
////        hud.mode = MBProgressHUDModeCustomView;
////        hud.removeFromSuperViewOnHide = YES;
////        hud.square = YES;
////        CGFloat margin = 92 ;  // 距离底部的距离
////        CGFloat offSetY = SCREEN_HEIGHT / 2 - margin;
////        hud.offset = CGPointMake(0, offSetY);
////        hud.centerX = SCREEN_WIDTH * .5;
//
//    });
//     return hud;
//}

+ (void)showMessage:(NSString *)message
{
    dispatch_async_on_main_queue(^{
        MBProgressHUD* hud = [self hud:nil message:message ?: @"" displayTime:1.5];
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
        
        if (delay > 0) {
            [hud hideAnimated:YES afterDelay:delay];
        }
        
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
    
//    dispatch_async_on_main_queue(^{
//        [self hud:view message:message ?: @"数据加载中" displayTime:0];
//    });
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



@end

