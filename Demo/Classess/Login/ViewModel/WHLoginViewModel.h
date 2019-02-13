//
//  WHLoginViewModel.h
//  Demo
//
//  Created by zero on 2019/2/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHLoginViewModel : WHBaseViewModel

@property (nonatomic, copy) NSString* mobile;

@property (nonatomic, copy) NSString* smsCode;

@property (nonatomic, readonly, strong) RACSignal* codeEnableSignal;

@property (nonatomic, readonly, strong) RACCommand* clickCodeCmd;

@property (nonatomic, readonly, strong) RACSignal* loginEnableSignal;

@property (nonatomic, readonly, strong) RACCommand* clickLoginCmd;

@end

NS_ASSUME_NONNULL_END
