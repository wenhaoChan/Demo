//
//  WHRefreshTool.h
//  Demo
//
//  Created by zero on 2019/2/27.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,WHRefreshType) {
    WHRefreshTypeDropDown = 0,  //只支持下拉
    WHRefreshTypeUpDrop = 1,    //只支持上拉
    WHRefreshTypeDouble = 2,    //支持上拉和下拉
};

NS_ASSUME_NONNULL_BEGIN

@interface WHRefreshTool : NSObject

/**
 上下拉刷新

 @param scrollerView scrollerView
 @param refreshType 刷新类型
 @param firstRefresh 是否立即执行一次刷新
 @param timeLabHidden 是否隐藏时间
 @param stateLabHidden 是否刷新状态
 @param dropDownBlock 下拉回调
 @param upDropBlock 上拉回调
 */
- (void)normalModelRefresh:(UIScrollView *)scrollerView
               refreshType:(WHRefreshType)refreshType
              firstRefresh:(BOOL)firstRefresh
             timeLabHidden:(BOOL)timeLabHidden
            stateLabHidden:(BOOL)stateLabHidden
             dropDownBlock:(void(^)(void))dropDownBlock
               upDropBlock:(void(^)(void))upDropBlock;

/**
  开始刷新
 */
- (void)beginRefreshing;

/**
 结束刷新
 */
- (void)endRefresh;

/**
 底部加载完成文案
 */
- (void)nomoreDataWithTitle:(NSString *)title;

/**
 沒有更多數據并结束刷新
 */
- (void)endRefreshingWithNoMoreData;

@end

NS_ASSUME_NONNULL_END
