//
//  CALayer+DBXibBorderColor.m
//  DianBao
//
//  Created by zero on 2019/3/9.
//  Copyright © 2019 zero. All rights reserved.
//

#import "CALayer+DBXibBorderColor.h"

#import <UIKit/UIKit.h>

@implementation CALayer (DBXibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
