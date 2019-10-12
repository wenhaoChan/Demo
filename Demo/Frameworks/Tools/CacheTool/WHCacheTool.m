//
//  WHCacheTool.m
//  Demo
//
//  Created by zero on 2019/10/12.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHCacheTool.h"

#import <SDWebImage/SDImageCache.h>

@implementation WHCacheTool

+ (void)calculateSize:(WHImageCacheCalculateSizeBlock)block
{
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        if (block) {
            CGFloat imgCache = totalSize  / 1000 / 1000.0;
            NSString* cache = [NSString stringWithFormat:@"%.1f M", imgCache];
            block(cache);
        }
    }];
}

+ (void)clearCacheOnCompletion:(nullable WHCacheToolSuccessBlock)completion
{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

//    dispatch_group_async(group, queue, ^{
//
//    });
    
//    dispatch_group_async(group, queue, ^{
//         [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:(SDImageCacheTypeMemory) completion:^{
//
//         }];
//    });
    
    dispatch_group_async(group, queue, ^{
         [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:(SDImageCacheTypeDisk) completion:^{
                    
         }];
    });
    
    dispatch_barrier_async(queue, ^{
        if (completion) {
            completion();
        }
    });
}

@end
