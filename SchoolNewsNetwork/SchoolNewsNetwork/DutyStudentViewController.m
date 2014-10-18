//
//  DutyStudentViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//
#import "CustomTabBarController.h"
#import "DutyStudentViewController.h"
#import "DutyStudentContentViewController.h"
static NSString *kDutyUrl = @"http://m.xxtwl.com/apps/check.html?iphone=%@&password=%@";
@interface DutyStudentViewController ()<UIWebViewDelegate>
{
    NSString *sendUrl;
}
@end

@implementation DutyStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTitle:@"考勤查询"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginID"];
    NSString *password = [[NSUserDefaults standardUserDefaults ]objectForKey:@"pass"];
    NSString *urlStr= [NSString stringWithFormat:kDutyUrl,userID,password];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.frame = CGRectMake(0, 66, self.view.frame.size.width, self.view.bounds.size.height-66-49);
    self.webView.delegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self setWebViewFrame];
    [self.webView loadRequest:request];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addLeave:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);
    
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // Do any additional setup after loading the view.
}

- (void)addLeave:(UIButton *)sender
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

-(void)_back
{
    UIViewController *contVC= [self.storyboard instantiateViewControllerWithIdentifier:@"navigation"];
    contVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:contVC animated:YES completion:nil];    //    self.tabBarController.selectedIndex = 0;
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
    NSString *protocol = @"_content";
    NSLog(@"%@",requestString);
    if ([requestString rangeOfString:protocol].location != NSNotFound) {
        sendUrl = requestString;
        [self performSegueWithIdentifier:@"dutyStudent_content" sender:self];
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DutyStudentContentViewController *view = segue.destinationViewController;
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
