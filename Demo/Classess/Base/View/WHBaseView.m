//
//  WHBaseView.m
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHBaseView.h"

@implementation WHBaseView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self wh_setupViews];
        [self wh_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<WHViewModelProtocol>)viewModel
{
    self = [super init];
    if (self) {
        [self wh_setupViews];
        [self wh_bindViewModel];
    }
    return self;
}

- (void)wh_bindViewModel{}


- (void)wh_setupViews {}

@end
