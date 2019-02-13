
//
//  WHViewProtocol.h
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WHViewModelProtocol;

@protocol WHViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <WHViewModelProtocol>)viewModel;

- (void)wh_bindViewModel;

- (void)wh_setupViews;

@end
