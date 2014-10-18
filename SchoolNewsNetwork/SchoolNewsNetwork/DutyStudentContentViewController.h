//
//  DutyStudentContentViewController.h
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "BaseViewController.h"

@interface DutyStudentContentViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,copy)NSString *sendUrl;
@end
