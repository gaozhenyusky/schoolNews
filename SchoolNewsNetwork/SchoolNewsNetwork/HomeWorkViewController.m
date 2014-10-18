//
//  HomeWorkViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "HomeWorkViewController.h"
#import "HomeContentViewController.h"

static NSString *kHomeWorkUrl = @"http://m.xxtwl.com/apps/homeworks.html?iphone=%@&password=%@";
@interface HomeWorkViewController ()<UIWebViewDelegate>
{
    NSString *sendUrl;
}
@end

@implementation HomeWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTitle:@"作业查询"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginID"];
    NSString *password = [[NSUserDefaults standardUserDefaults ]objectForKey:@"pass"];
    NSString *urlStr= [NSString stringWithFormat:kHomeWorkUrl,userID,password];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self setWebViewFrame];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.webView loadRequest:request];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sousuo:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);
    
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // Do any additional setup after loading the view.
}

- (void)sousuo:(UIButton *)sender
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"seach_click();"];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    //    NSInteger selectIndex = ((CustomTabBarController *)self.tabBarController).currentIndex;
    //    self.tabBarController.selectedIndex = selectIndex;
}


-(void)_back
{
    UIViewController *contVC= [self.storyboard instantiateViewControllerWithIdentifier:@"navigation"];
    contVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:contVC animated:YES completion:nil];
    //    self.tabBarController.selectedIndex = 0;
    //    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSString *protocol = @"homeworks_content";
    NSLog(@"%@",requestString);
    if ([requestString rangeOfString:protocol].location != NSNotFound) {
        sendUrl = requestString;
        [self performSegueWithIdentifier:@"home_content" sender:self];
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HomeContentViewController* view = segue.destinationViewController;
    view.sendUrl =sendUrl;
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
