//
//  UIColor+Fix.m
//  Class1
//
//  Created by zero on 2019/9/23.
//  Copyright © 2019 wonder. All rights reserved.
//

#import "UIColor+Fix.h"


@implementation UIColor (Fix)

//+ (UIColor *)wh_fixTextColor
//{
//    return [self wh_fixColor:COTextColor toColor:[UIColor whiteColor]];
//}

+ (UIColor *)wh_fixBgWhiteColor
{
    return [self wh_fixColor:[UIColor whiteColor] toColor:[UIColor blackColor]];
}

+ (UIColor *)wh_fixBgBlackColor
{
    return [self wh_fixColor:[UIColor blackColor] toColor:[UIColor whiteColor]];
}

//+ (UIColor *)wh_fixCellBgColor
//{
//    return [self wh_fixColor:COGrayBgColor toColor:COSeparatorColor];
//}

//+ (UIColor *)wh_fixInputBgColor
//{
//    return [self wh_fixColor:COGrayBgColor toColor:COTextColor];
//}

+ (UIColor *)wh_fixContentViewBgColor
{
    return [self wh_fixColor:[UIColor whiteColor] toColor:RGB(28, 28, 30)];
}

+ (UIColor *)wh_fixColor:(UIColor *)color toColor:(UIColor *)toColor
{
    UIColor* normalColor = color;
        
    if (@available(iOS 13.0, *)) {
        normalColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
            if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return toColor;
            } else {
                return color;
            }
        }];
    }
    return normalColor;
}

@end
