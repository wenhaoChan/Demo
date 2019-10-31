//
//  WHUserManager.h
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WHUser;

NS_ASSUME_NONNULL_BEGIN

@interface WHUserManager : NSObject

@property (nonatomic, readonly, getter=isLogin, assign) BOOL login;

@property (nonatomic, readonly, strong) WHUser* user;

+ (instancetype)manager;

+ (void)destroyInstance;

- (void)setUser:(WHUser * _Nonnull)user;

/**
 清除本地数据
 */
- (void)clearUserData;


@end

NS_ASSUME_NONNULL_END
