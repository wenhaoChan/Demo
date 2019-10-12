//
//  NSString+Date.m
//  DianBao
//
//  Created by zero on 2019/3/23.
//  Copyright © 2019 zero. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

- (NSString *)getDateStringWithFormat:(NSString *)format
{
    NSTimeInterval time = [self doubleValue];
    
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format ?: @"yyyy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detailDate];
    
    return currentDateStr;
}

//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format ?: @"YYYY-MM-dd"];
    NSDate *tempDate = [dateFormatter dateFromString:self];
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];
    return timeStr;
}


//传入 秒  得到  xx分钟xx秒
- (NSString *)getMMSS
{
    NSInteger seconds = [self integerValue];
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", seconds / 60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld", seconds % 60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
    
    return format_time;
}


@end
