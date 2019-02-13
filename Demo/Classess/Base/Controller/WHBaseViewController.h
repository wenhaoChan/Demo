//
//  WHBaseViewController.h
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHBaseViewController : UIViewController<WHViewControllerProtocol>

/**
 * 功能： 布局导航栏界面
 * 参数：（1）导航栏背景：backGroundImage
 *      （2）导航栏标题颜色：titleColor
 *      （3）导航栏标题字体：titleFont
 *      （4）导航栏左侧按钮：leftItem
 *      （5）导航栏右侧按钮：rightItem
 */
-(void)layoutNavigationBar:(UIImage*)backGroundImage
                titleColor:(UIColor*)titleColor
                 titleFont:(UIFont*)titleFont
         leftBarButtonItem:(UIBarButtonItem*)leftItem
        rightBarButtonItem:(UIBarButtonItem*)rightItem;

@end

NS_ASSUME_NONNULL_END
