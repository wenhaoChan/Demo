//
//  DemoTests.m
//  DemoTests
//
//  Created by zero on 2018/12/4.
//  Copyright © 2018 zero. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <YYModel.h>

@interface DemoTests : XCTestCase

@end

@implementation DemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    
    NSDictionary* dic = @{@"app_name": @"shuangshuang",
                          @"general-parameter" : @"general parameter value"
                          };
    NSString* json = [dic yy_modelToJSONString];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
