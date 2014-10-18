//
//  StudentScoreContentViewController.m
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-13.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "StudentScoreContentViewController.h"

@interface StudentScoreContentViewController ()<UIWebViewDelegate>

@end

@implementation StudentScoreContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTitle:@"成绩内容"];
    [self setNavigationLeftBg:@"ssdk_back_arr.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_sendUrl]];
    self.webView.delegate =self;
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

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setTheTitle:title];
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
