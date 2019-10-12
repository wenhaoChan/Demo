//
//  WHSahreTool.h
//  Demo
//
//  Created by zero on 2019/10/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHSahreTool : NSObject

/**
 分享一个网页

 @param url url
 @param title 标题
 @param descr 描述
 @param image 图片
 @param platform 平台 
 */
+ (void)shareWebPageWithUrl:(NSString *)url
                      title:(NSString *)title
                      descr:(NSString *)descr
                      image:(id _Nullable)image
                  platforms:(NSArray * _Nullable)platform;

@end

NS_ASSUME_NONNULL_END
