//
//  UIAlertController+Customer.m
//  Class1
//
//  Created by zero on 2019/5/22.
//  Copyright © 2019 wonder. All rights reserved.
//

#import "UIAlertController+Customer.h"


@implementation UIAlertController (Customer)

+ (UIAlertController *)creatAlertControllerWithTitle:(NSString *)title
                                             message:(NSString *)message
                                         confirmText:(NSString *)confirmText
                                         cancelText:(NSString *)cancelText
                                        confirmBlock:(void(^)(void))confirmBlock
                                         cancelBlock:(void(^)(void))cancelBlock
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:confirmText?:@"確認" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        confirmBlock ? confirmBlock() : nil;
    }];
    [okAction setValue:WHTopicColor forKey:@"titleTextColor"];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancelText?:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock ? cancelBlock() : nil;
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    return alert;
}


+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          confirmText:(NSString *)confirmText
           cancelText:(NSString *)cancelText
         confirmBlock:(void(^)(void))confirmBlock
          cancelBlock:(void(^)(void))cancelBlock
{
    dispatch_async_on_main_queue(^{
        UIAlertController* alert = [self creatAlertControllerWithTitle:title
                                                           message:message
                                                       confirmText:confirmText
                                                        cancelText:cancelText
                                                      confirmBlock:confirmBlock cancelBlock:cancelBlock];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
          confirmText:(NSString *)confirmText
           cancelText:(NSString *)cancelText
         confirmBlock:(void(^)(void))confirmBlock
          cancelBlock:(void(^)(void))cancelBlock
         inController:(UIViewController *)vc
{
    dispatch_async_on_main_queue(^{
        UIAlertController* alert = [self creatAlertControllerWithTitle:title
                                                               message:message
                                                           confirmText:confirmText
                                                            cancelText:cancelText
                                                          confirmBlock:confirmBlock
                                                           cancelBlock:cancelBlock];
        [vc presentViewController:alert animated:YES completion:nil];
    });
}

@end
