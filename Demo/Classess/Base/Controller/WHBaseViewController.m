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
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController wh_layoutNavigation];
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


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
////    [self layoutNavigationBar:Image(@"navigationBarBG@2x.png") titleColor:[UIColor whiteColor] titleFont:FONT_YAHEI(18) leftBarButtonItem:nil rightBarButtonItem:nil];
//    
////    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
////        [self setAutomaticallyAdjustsScrollViewInsets:NO];
////    }
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//}

#pragma mark - system

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor && titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}


#pragma mark - RAC

- (void)wh_addSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)wh_bindViewModel {}


- (void)wh_layoutNavigation {}


- (void)wh_getNewData {}



@end
