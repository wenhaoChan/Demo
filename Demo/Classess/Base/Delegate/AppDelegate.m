//
//  AppDelegate.m
//  Demo
//
//  Created by zero on 2018/12/4.
//  Copyright © 2018 zero. All rights reserved.
//

#import "AppDelegate.h"

// Models

// Views

// ViewModels

// Controllers
#import "WHLoginViewController.h"
#import "WHTabBarViewController.h"

// Others
#import "AppDelegate+Config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 获取appDelegate

+ (AppDelegate *)sharedDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setupTabBarController];
    
    [self.window makeKeyAndVisible];
    
    [self configThridService:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

#pragma mark - 初始化登录界面

- (void)setupLoginController
{
    WHLoginViewController* vc = [[WHLoginViewController alloc] init];
    self.window.rootViewController = vc;
}

#pragma mark - 初始化 TabBarController

- (void)setupTabBarController
{
    WHTabBarViewController* vc = [[WHTabBarViewController alloc] init];
    self.window.rootViewController = vc;
}










- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    NSLog(@"openURL %@", url);
    BOOL result = NO;
    result =  [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    return result;
}






- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
