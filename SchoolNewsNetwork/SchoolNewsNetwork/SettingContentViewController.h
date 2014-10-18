//
//  SettingContentViewController.h
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-13.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingContentViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy)NSString *sendUrl;
@end
