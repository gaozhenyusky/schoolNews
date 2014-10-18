//
//  StudentScoreViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "StudentScoreViewController.h"
#import "StudentScoreContentViewController.h"

static NSString *kStudentScoreUrl = @"http://m.xxtwl.com/apps/results.html?iphone=%@&password=%@";
@interface StudentScoreViewController ()<UIWebViewDelegate>
{
    NSString *sendUrl;
}
@end

@implementation StudentScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTitle:@"成绩查询"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginID"];
    NSString *password = [[NSUserDefaults standardUserDefaults ]objectForKey:@"pass"];
    NSString *urlStr= [NSString stringWithFormat:kStudentScoreUrl,userID,password];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self setWebViewFrame];
    [self.webView loadRequest:request];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addLeave:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);
    
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // Do any additional setup after loading the view.
}

-(void)_back
{
    UIViewController *contVC= [self.storyboard instantiateViewControllerWithIdentifier:@"navigation"];
    contVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:contVC animated:YES completion:nil];
    //    self.tabBarController.selectedIndex = 0;
    //    [self.navigationController popViewControllerAnimated:YES];
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

- (void)addLeave:(UIButton *)sender
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"seach_click();"];
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSString *protocol = @"content";
    NSLog(@"%@",requestString);
    if ([requestString rangeOfString:protocol].location != NSNotFound) {
        
        sendUrl = requestString;
        [self performSegueWithIdentifier:@"studentScore_content" sender:self];
        return NO;
    }
    return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    StudentScoreContentViewController* view = segue.destinationViewController;
    view.sendUrl = sendUrl;
    
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
