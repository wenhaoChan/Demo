//
//  WHUserManager.m
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHUserManager.h"

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
    dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _manager;
}


#pragma mark - 读取出本地数据

- (void)loadUserDataFromDB
{
    NSString* userId = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserIdKey];
    if (WHStringIsNotEmpty(userId)) {
        NSArray* array = [WHCSqlite query:[WHUser class] where:[NSString stringWithFormat:@"user_id = %@", userId]];
        if (array.count) {
            _user = [array lastObject];
            _isLogined = YES;
        } else {
            // 用户删除了应用 或 清除了缓存  需要重新进行登录
            [self clearUserDataFromDB];
        }
    }
}


#pragma mark - 清除本地数据

- (void)clearUserDataFromDB
{
    _user = [WHUser new];
    [WHCSqlite removeModel:[WHUser class]];
    
    _isLogined = NO;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kAppUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [[AppDelegate sharedDelegate] setupLoginController];
}


#pragma mark - 更新本地数据

- (BOOL)updateUserDataToDB:(WHUser *)user
{
    BOOL ok = NO;
    
    NSString* user_id = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserIdKey];
    
    if ([user.user_id isEqualToString:user_id]) { // 同一用户直接更新
        ok = [WHCSqlite update:user where:[NSString stringWithFormat:@"user_id = %@", user.user_id]];
    }
    
    if (!ok) { // 更新失败 重新插入
        [WHCSqlite removeModel:[WHUser class]];
        ok = [WHCSqlite insert:user];
        
        [[NSUserDefaults standardUserDefaults] setObject:user.user_id forKey:kAppUserIdKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return ok;
}



@end
