//
//  WHUserManager.h
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WHUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHUserManager : NSObject

@property (nonatomic, readonly, assign) BOOL isLogined;

@property (nonatomic, readonly, strong) WHUser* user;


+ (instancetype)manager;


+ (void)destroyInstance;


/**
 读取出本地数据
 */
- (void)loadUserDataFromDB;


/**
 更新本地用户数据

 @return 是否成功
 */
- (BOOL)updateUserDataToDB:(WHUser *)user;


/**
 清除本地数据
 */
- (void)clearUserDataFromDB;


@end

NS_ASSUME_NONNULL_END
