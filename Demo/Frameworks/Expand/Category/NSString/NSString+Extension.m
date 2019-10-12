//
//  NSString+Extension.m
//  Class1
//
//  Created by zero on 2019/9/27.
//  Copyright © 2019 wonder. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSDictionary *)parameters
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    // 传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self];
    
    // 回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [params setObject:obj.value forKey:obj.name];
    }];
    
    return params;
}

@end
