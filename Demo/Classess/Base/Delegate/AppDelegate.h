//
//  AppDelegate.h
//  Demo
//
//  Created by zero on 2018/12/4.
//  Copyright © 2018 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 获取AppDelegate
 
 @return AppDelegate
 */
+ (AppDelegate *)sharedDelegate;


/**
 初始化登录界面
 */
- (void)setupLoginController;


/**
 初始化 TabBarController
 */
- (void)setupTabBarController;


@end

