
//
//  WHMacros.h
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#ifndef WHMacros_h
#define WHMacros_h

#define UserManager [WHUserManager manager]

/// 弱引用
#define WEAK @weakify(self);

/// 强引用
#define STRONG @strongify(self);

/// 引用判断
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))

/// 去掉空格回车
#define StringTrimming(_ref) [[_ref stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

/// 是否为空对象
#define WHObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

/// 字符串为空
#define WHStringIsEmpty(__string) ((__string.length == 0) || WHObjectIsNil(__string))

/// 字符串不为空
#define WHStringIsNotEmpty(__string)  (!WHStringIsEmpty(__string))

/// 设备类型
#define WH_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define WH_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define WH_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/// 是否为 ios x 以上
#define isiOSX(x) ([UIDevice currentDevice].systemVersion.floatValue >= x)

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

/// 屏幕尺寸
#define SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define AUTOLAYOUT(h) h * (SCREEN_HEIGHT / 667)

// 是否为 iPhone X 以上机型
#define IsiPhoneXSerious ({\
BOOL isiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = [UIApplication sharedApplication].delegate.window;\
if (window.safeAreaInsets.bottom > 0.0) {\
isiPhoneX = YES;\
}\
}\
isiPhoneX;\
})

/// 导航条高度
#define WH_APPLICATION_TOP_BAR_HEIGHT (IsiPhoneXSerious?88.0f:64.0f)

// tabBar高度
#define WH_APPLICATION_TAB_BAR_HEIGHT (IsiPhoneXSerious?83.0f:49.0f)

/// 状态栏高度
#define APPLICATION_STATUS_BAR_HEIGHT (IsiPhoneXSerious?44:20.0f)

/// statusbar 高度
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define NAVIGATIONBAR_HIGHT self.navigationController.navigationBar.frame.size.height

#define TABBAR_HEIGHT self.tabBarController.tabBar.frame.size.height

#define STATUSBAR_NAVIGATIONBAR_HEIGHT STATUSBAR_HEIGHT + NAVIGATIONBAR_HIGHT

/// AppDelegate
#define WHSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// bundle Identifier
#define BUNDLEIDENTIFIER [[NSBundle mainBundle] bundleIdentifier]

/// app 版本
#define VERSION_NUM [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/// 颜色
#define ColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)a]
#define ColorFromRGB(rgbValue) ColorFromRGBA(rgbValue, 1.0)

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r, g, b, 1.0f)

#define WHTopicColor RGB(234, 85, 0)

/// 图片
#define Image(fileName) [UIImage imageNamed:fileName]

/// 字体大小(常规/粗体)
#define FONT_BOLDSYSTEM(FONTSIZE)   [UIFont boldSystemFontOfSize:FONTSIZE]
#define FONT_SYSTEM(FONTSIZE)       [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]
// 微软雅黑
#define FONT_YAHEI(FONTSIZE) [UIFont fontWithName:@"MicrosoftYaHei" size:(FONTSIZE)]
// 英文 和 数字
#define FONT_ENGLISH(FONTSIZE) [UIFont fontWithName:@"Helvetica Light" size:(FONTSIZE)]

/// AppCaches 文件夹路径
#define WHCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

/// App DocumentDirectory 文件夹路径
#define WHDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]


/// 适配iPhone X + iOS 11
#define WHAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

/// 销毁打印
#define WHDealloc NSLog(@"\n =========+++ %@  销毁了 +++======== \n", [self class])

/// 输出
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* WHMacros_h */
