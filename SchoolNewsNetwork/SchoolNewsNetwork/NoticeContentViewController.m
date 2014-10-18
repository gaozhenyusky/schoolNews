//
//  NoticeContentViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-25.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "NoticeContentViewController.h"
#import "UIImageView+WebCache.h"
@interface NoticeContentViewController ()<UIWebViewDelegate>

@end

@implementation NoticeContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.title = title;
    [self setNavigationLeftBg:@"ssdk_back_arr.png"];
    [self setTheTitle:@"通知内容"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self setWebViewFrame];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}

//-(void)_back
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

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

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setTheTitle:title];
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
