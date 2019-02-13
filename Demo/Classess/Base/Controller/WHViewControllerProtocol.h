
//
//  WHViewControllerProtocol.h
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol WHViewModelProtocol;

@protocol WHViewControllerProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <WHViewModelProtocol>)viewModel;

/**
 *  绑定 viewModel
 */
- (void)wh_bindViewModel;

/**
 *  添加子控件
 */
- (void)wh_addSubviews;

/**
 *  设置 navation
 */
- (void)wh_layoutNavigation;

/**
 *  初次获取数据
 */
- (void)wh_getNewData;


@end
