//
//  WHStartApp.m
//  Demo
//
//  Created by zero on 2019/2/1.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHStartApp.h"

#import "WHBaseModel.h"

#import <XMNetworking/XMNetworking.h>

@implementation WHStartApp

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] wh_initPersonData];
        [[self class] wh_initNetworking];
    });
}


#pragma mark - 初始化个人数据

+ (void)wh_initPersonData
{
    WHUserManager* manager = [WHUserManager manager];
    [manager loadUserDataFromDB];
    
}


#pragma mark - 初始网络请求配置

+ (void)wh_initNetworking
{
    [XMCenter setupConfig:^(XMConfig *config) {
        // 公共服务端地址
        config.generalServer = API_Server;
        // 公共请求头
//        config.generalHeaders = @{@"general-header": @"general header value"};
        // 公共请求参数
//        config.generalParameters = @{@"general-parameter": @"generalparametervalue"};
        // 公共用户信息
        config.generalUserInfo = nil;
        // 请求的回调 Block 执行的 dispatch 队列（线程），如果为 NULL（默认），那么会在一个私有的并发队列（子线程）中执行回调 Block。
        config.callbackQueue = dispatch_get_main_queue();
        // 底层请求的引擎，默认为 [XMEngine sharedEngine] 单例对象
        config.engine = [XMEngine sharedEngine];
#ifdef DEBUG
        config.consoleLog = YES;
#endif
    }];
    
    // 自定义请求预处理逻辑
    [XMCenter setRequestProcessBlock:^(XMRequest *request) {
        request.httpMethod = kXMHTTPMethodGET;
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:request.parameters];
        [self commonParams:params];
        NSString* sign = [self signature:params];
        params[@"sign"] = sign;
        request.parameters = [params copy];
    }];
    
    
    // 对全局请求统一做业务错误码判断、数据模型转换、网络缓存等操作
    [XMCenter setResponseProcessBlock:^id(XMRequest *request, id responseObject, NSError *__autoreleasing *error) {
        
        BOOL err = !responseObject || ![responseObject isKindOfClass:[NSDictionary class]];
        if (err) {
            [MBProgressHUD showMessage:@"服务器响应错误"];
            *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:10000 userInfo:nil];
            return nil;
        }
        
        NSInteger code = [responseObject[@"code"] integerValue];
        
        if (code != 0) {
            // 自定义响应结果处理逻辑，如果 `*error` 被赋值，则接下来会执行 failure block。
            NSString* errMsg = responseObject[@"message"] ? : @"未知错误";
            [MBProgressHUD showMessage:errMsg];
            *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                         code:code
                                     userInfo:@{@"message" : errMsg}];
            return nil;
        }
        
        return responseObject[@"data"]; // or return a new object to reset value for responseObject
    }];
    
    // 错误信息统一过滤
    [XMCenter setErrorProcessBlock:^(XMRequest *request, NSError *__autoreleasing * error) {
        // 比如对不同的错误码统一错误提示等
        if (error) {
            [MBProgressHUD showMessage:@"服务器开小差了，程序员小哥正在努力抢修"];
        }
    }];
}


#pragma mark - 公共参数

+ (void)commonParams:(NSMutableDictionary *)params
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    NSString* user_id = [[NSUserDefaults standardUserDefaults] objectForKey:kAppUserIdKey];
    
    params[@"t"] = timeString;
    params[@"user_id"] = user_id;
    params[@"v"] = API_VERSION;
}


#pragma mark - 计算签名算法

/**
 传过来的所有参数（包括url里的和post过来的，除了sign参数本身外），
 按照key首字母正序排序拼接起来再拼接token后md5加密，再转成小写字母。
 */
+ (NSString *)signature:(NSDictionary *)params
{
//    NSArray *keyArray = [params allKeys];
    // 参数升序排序
    NSArray *sortArray = [params allKeysSorted];
    
    NSMutableArray *signArray = [NSMutableArray array];
    
    // 参数拼接
    [sortArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@", obj, params[obj]];
        [signArray addObject:keyValueStr];
    }];
    
    NSString *sign = [signArray componentsJoinedByString:@"&"];
    
    WHUserManager* userInfo = [WHUserManager manager];
    // 拼接 token 在末尾
    sign = [sign stringByAppendingString:userInfo.user.token ? : @""];
    // 拼接结果并 md5 加密
    NSString* signature = [sign md5String];

    return signature;
}


@end
