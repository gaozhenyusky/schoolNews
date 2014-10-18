//
//  NoticeContentViewController.h
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-25.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface NoticeContentViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy)NSString *url;
@end
