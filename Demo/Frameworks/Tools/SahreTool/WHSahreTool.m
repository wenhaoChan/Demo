//
//  WHSahreTool.m
//  Demo
//
//  Created by zero on 2019/10/11.
//  Copyright © 2019 zero. All rights reserved.
//

#import "WHSahreTool.h"

#import <UShareUI/UShareUI.h>

@implementation WHSahreTool

+ (void)shareWebPageWithUrl:(NSString *)url
                      title:(NSString *)title
                      descr:(NSString *)descr
                      image:(id)image
                  platforms:(NSArray *)platform
{
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        //创建网页内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title
                                                                                 descr:descr
                                                                             thumImage:image ?: Image(@"logo")];
        //设置网页地址
        shareObject.webpageUrl = url;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
            } else {
                NSLog(@"response data is %@",data);
            }
        }];
    }];
}

@end
