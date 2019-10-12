//
//  NSString+Extension.h
//  Class1
//
//  Created by zero on 2019/9/27.
//  Copyright © 2019 wonder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/**
 获取url的所有参数
 */
- (NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
