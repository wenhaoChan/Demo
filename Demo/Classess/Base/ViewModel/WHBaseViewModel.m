//
//  WHBaseViewModel.m
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHBaseViewModel.h"

@implementation WHBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    WHBaseViewModel* viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel wh_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)wh_initialize {}

@end
