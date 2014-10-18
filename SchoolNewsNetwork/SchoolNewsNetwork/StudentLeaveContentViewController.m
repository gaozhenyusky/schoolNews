//
//  StudentLeaveContentViewController.m
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-13.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "StudentLeaveContentViewController.h"

@interface StudentLeaveContentViewController ()

@end

@implementation StudentLeaveContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTitle:@"请假内容"];
    [self setNavigationLeftBg:@"ssdk_back_arr.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_sendUrl]];
    [self setWebViewFrame];
    [self.webView loadRequest:request];
}

- (void)setWebViewFrame
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.webView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.bounds.size.height-44);
    }
    else{
        self.webView.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.bounds.size.height-44);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
