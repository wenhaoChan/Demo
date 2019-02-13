//
//  WHBaseView.h
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHBaseView : UIView<WHViewProtocol>

- (instancetype)initWithViewModel:(id<WHViewModelProtocol>)viewModel;

@end

NS_ASSUME_NONNULL_END
