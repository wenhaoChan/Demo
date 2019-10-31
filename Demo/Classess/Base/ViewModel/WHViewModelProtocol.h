//
//  WHViewModelProtocol.h
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WHHeaderRefresh_HasMoreData = 1,
    WHHeaderRefresh_HasNoMoreData,
    WHFooterRefresh_HasMoreData,
    WHFooterRefresh_HasNoMoreData,
    WHRefreshError,
    WHRefreshUI,
} WHRefreshDataStatus;

@protocol WHViewModelProtocol <NSObject>

@optional

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)wh_initialize;

@end
