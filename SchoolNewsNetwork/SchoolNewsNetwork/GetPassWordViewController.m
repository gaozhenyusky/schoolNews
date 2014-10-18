//
//  GetPassWordViewController.m
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-13.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "GetPassWordViewController.h"

@interface GetPassWordViewController ()<UIWebViewDelegate>

@end

@implementation GetPassWordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setWebViewFrame];
    [self setNavigationLeftBg:@"icon_back_1"];
    [self setTheTitle:@"找回密码"];
    _webView.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor grayColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_sendUrl]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    [self.view addSubview:_webView];
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

-(void)_back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"132");
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
