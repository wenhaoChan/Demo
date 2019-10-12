//
//  WHUserManager.m
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHUserManager.h"

@interface WHUserManager()

@property (nonatomic, readwrite, getter=isLogin, assign) BOOL login;

@end

@implementation WHUserManager

static id _manager = nil;

+ (void)destroyInstance
{
    _manager = nil;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _manager;
}

#pragma mark - 清除本地数据

- (void)clearUserData
{
    _user = [WHUser new];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kAppUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getter

- (BOOL)isLogin
{
    return WHStringIsNotEmpty(_user.token);
}

@end
