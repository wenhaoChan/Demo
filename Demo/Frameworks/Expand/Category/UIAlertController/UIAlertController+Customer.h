//
//  UIAlertController+Customer.h
//  Class1
//
//  Created by zero on 2019/5/22.
//  Copyright © 2019 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Customer)

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          confirmText:(nullable NSString *)confirmText
           cancelText:(nullable NSString *)cancelText
         confirmBlock:(nullable void(^)(void))confirmBlock
          cancelBlock:(nullable void(^)(void))cancelBlock;

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          confirmText:(nullable NSString *)confirmText
           cancelText:(nullable NSString *)cancelText
         confirmBlock:(nullable void(^)(void))confirmBlock
          cancelBlock:(nullable void(^)(void))cancelBlock
         inController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
