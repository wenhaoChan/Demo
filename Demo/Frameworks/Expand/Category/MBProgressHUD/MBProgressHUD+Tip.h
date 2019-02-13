//
//  MBProgressHUD+Tip.h
//  jobStudentiOS
//
//  Created by CGC on 2017/4/17.
//  Copyright © 2017年 clitics. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Tip)


/**
 返回一个自定义HUD

 @param view 所在容器
 @param message 内容信息
 @param delay 自动消失时间
 @return HUD
 */
+ (MBProgressHUD *)hud:(id)view message:(NSString *)message displayTime:(NSTimeInterval)delay;


/**
 只有信息的HUD

 @param message 内容
 */
+ (void)showMessage:(NSString *)message;


/**
 弹出一个带成功图标的HUD

 @param message 成功信息
 */
+ (void)showSuccessMessage:(NSString *)message;


/**
 弹出一个带错误图标的HUD

 @param message 错误信息
 */
+ (void)showErrorMessage:(NSString *)message;


/**
 自定义带图片 HUD

 @param message 提示信息
 @param image 图片 当 nil 时默认为logo
 @param delay 多久后消自动失 为 0 时不消失
 @param view 当 nil 时为加载w keywindow 上
 */
+ (void)showMessage:(NSString *)message image:(UIImage *)image displayTime:(NSTimeInterval)delay inView:(UIView *)view;


/**
 加载提示

 @param message 信息
 @param view view
 */
+ (void)showLoading:(NSString *)message onView:(UIView *)view;


/**
 隐藏 MBProgressHUD

 @param view 所在view
 */
+ (void)hideMBProgressHUD:(UIView *)view;



@end