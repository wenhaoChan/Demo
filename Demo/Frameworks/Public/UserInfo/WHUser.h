//
//  WHUser.h
//  Demo
//
//  Created by zero on 2019/2/2.
//  Copyright © 2019 zero. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHUser : NSObject

@property (nonatomic, copy) NSString* user_id;

@property (nonatomic, copy) NSString* token;

@property (nonatomic, copy) NSString* name;

@property (nonatomic, copy) NSString* avatar;

@property (nonatomic, copy) NSString* mobile;

@end

NS_ASSUME_NONNULL_END
