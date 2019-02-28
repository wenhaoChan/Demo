//
//  WHWebViewController.h
//  Demo
//
//  Created by zero on 2019/2/25.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHBaseViewController.h"

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

@interface WHWebViewController : WHBaseViewController

@property (nonatomic, copy) NSString* webUrl;

@property (nonatomic, copy) NSString* webTitle;

@end

NS_ASSUME_NONNULL_END
