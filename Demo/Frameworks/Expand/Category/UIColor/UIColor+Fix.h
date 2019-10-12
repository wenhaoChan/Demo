//
//  UIColor+Fix.h
//  Class1
//
//  Created by zero on 2019/9/23.
//  Copyright © 2019 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Fix)

//+ (UIColor *)wh_fixTextColor;

+ (UIColor *)wh_fixBgWhiteColor;

+ (UIColor *)wh_fixBgBlackColor;

//+ (UIColor *)wh_fixCellBgColor;

//+ (UIColor *)wh_fixInputBgColor;

+ (UIColor *)wh_fixContentViewBgColor;

+ (UIColor *)wh_fixColor:(UIColor *)color toColor:(UIColor *)toColor;

@end

NS_ASSUME_NONNULL_END
