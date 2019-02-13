//
//  WHTabBarViewController.m
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHTabBarViewController.h"

// Models

// Views

// ViewModels

// Controllers
#import "ViewController.h"
#import "WHNavigationViewController.h"
// Others

@interface WHTabBarViewController ()

@end

@implementation WHTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar.tintColor = ColorFromRGB(0x767676);
    
    [UITabBar appearance].backgroundColor = [UIColor whiteColor];
    
    [UITabBar appearance].translucent = NO;
    
    self.tabBar.shadowImage = [UIImage new];
    
    [self setupSubControllers];
    // Do any additional setup after loading the view.
}


- (void)setupSubControllers
{
    WHNavigationViewController* rvc = [self addChildVC:[ViewController new] withTitle:@"匹配" image:@"tab1" selectedImage:@"tab1-selected"];
    
    WHNavigationViewController* mvc = [self addChildVC:[ViewController new] withTitle:@"红包" image:@"tab22" selectedImage:@"tab22-selected"];
    
    WHNavigationViewController* cvc = [self addChildVC:[ViewController new] withTitle:@"聊天" image:@"tab3" selectedImage:@"tab3-selected"];

    self.viewControllers = @[rvc, mvc, cvc];
}


- (WHNavigationViewController *)addChildVC:(UIViewController *)childVC withTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    WHNavigationViewController *nvc = [[WHNavigationViewController alloc] initWithRootViewController:childVC];
    return nvc;
}


@end
