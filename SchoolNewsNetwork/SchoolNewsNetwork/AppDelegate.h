//
//  AppDelegate.h
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-4.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPush.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,BPushDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *channelId;
@property (strong, nonatomic) NSString *userId;


@end
