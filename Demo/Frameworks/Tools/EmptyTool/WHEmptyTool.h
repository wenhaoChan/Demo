//
//  WHEmptyTool.h
//  Class1
//
//  Created by zero on 2019/5/19.
//  Copyright © 2019 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSUInteger, WHEmptyType) {
    WHEmptyTypeNone,
    WHEmptyTypeNormal, // 没有数据
    WHEmptyTypeNetwork, // 没有网络
};

@interface WHEmptyTool : NSObject

/**
 重新加載 block
 */
@property (nonatomic, copy) void (^WDLReloadBlock) (void);

/**
 初始化 工具

 @param scrollView scrollView
 @param type 佔位類型
 @return 實例
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView emptyTypeP:(WHEmptyType)type;

/**
 刷新
 */
- (void)reloadEmptyView;

/**
 用類型刷新佔位類型

 @param state 佔位類型
 */
- (void)reloadEmptyViewWithState:(WHEmptyType)state;

@end

NS_ASSUME_NONNULL_END
