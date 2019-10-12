//
//  WHCacheTool.h
//  Demo
//
//  Created by zero on 2019/10/12.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WHImageCacheCalculateSizeBlock)(NSString* totalSize);

typedef void(^WHCacheToolSuccessBlock)(void);

@interface WHCacheTool : NSObject

+ (void)calculateSize:(nullable WHImageCacheCalculateSizeBlock)block;

+ (void)clearCacheOnCompletion:(nullable WHCacheToolSuccessBlock)completion;

@end

NS_ASSUME_NONNULL_END
