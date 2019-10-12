//
//  WHNavigationViewController.m
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHNavigationViewController.h"

@interface WHNavigationViewController ()

@end

@implementation WHNavigationViewController

+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    // 设置导航栏背景颜色
    [navigationBar setBarTintColor:[UIColor whiteColor]];
    // 设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSFontAttributeName : [UIFont systemFontOfSize:17]};
    // 设置 NavigationBarItem 文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationBar.translucent = NO;
//    self.navigationBar.shadowImage = [UIImage new];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 全部修改返回按钮,但是会失去右滑返回的手势
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >=1) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [super popToRootViewControllerAnimated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

- (void)pop
{
    [self popViewControllerAnimated:YES];
}

- (UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
}

@end
