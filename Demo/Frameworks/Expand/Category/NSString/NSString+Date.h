//
//  NSString+Date.h
//  DianBao
//
//  Created by zero on 2019/3/23.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

/**
 时间戳转字符串

 @param format 时间格式 默认 yyyy-MM-dd HH:mm
 @return 时间
 */
- (NSString *)getDateStringWithFormat:(NSString *)format;

/**
 字符串转时间戳

 @param format 时间格式 默认 YYYY-MM
 @return 时间戳
 */
- (NSString *)getTimeStrWithFormat:(NSString *)format;

/**
 传入 秒 得到 xx:xx

 @return xx:xx
 */
- (NSString *)getMMSS;

@end
