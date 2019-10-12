//
//  WHBaseViewController.m
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHBaseViewController.h"

@interface WHBaseViewController ()

@end

@implementation WHBaseViewController

- (void)dealloc
{
    WHDealloc;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    WHBaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController wh_addSubviews];
        [viewController wh_bindViewModel];
        [viewController wh_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<WHViewModelProtocol>)viewModel
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - system


#pragma mark - RAC

- (void)wh_addSubviews
{}

- (void)wh_bindViewModel {}

- (void)wh_layoutNavigation {}

- (void)wh_getNewData {}

@end
