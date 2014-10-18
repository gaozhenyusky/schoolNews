//
//  StudentLeaveUnreadViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "StudentLeaveUnreadViewController.h"
#import "StudentLeaveContentViewController.h"

static NSString *kStudentLeaveUrl = @"http://m.xxtwl.com/apps/leave.html?iphone=%@&password=%@";
static NSString *kAddLeaveUrl = @"http://m.xxtwl.com/weixin/leave_content.html";
@interface StudentLeaveUnreadViewController ()<UIWebViewDelegate>
{
    NSString *sendUrl;
}
@end

@implementation StudentLeaveUnreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTheTitle:@"在线请假"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginID"];
    NSString *password = [[NSUserDefaults standardUserDefaults ]objectForKey:@"pass"];
    NSString *urlStr= [NSString stringWithFormat:kStudentLeaveUrl,userID,password];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.frame = CGRectMake(0, 46, self.view.frame.size.width, self.view.bounds.size.height-49);
    self.webView.delegate = self;
    [self setWebViewFrame];
    [self.webView loadRequest:request];

     UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"add_tobtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addLeave:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);
    
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // Do any additional setup after loading the view.
}

- (void)addLeave:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:kAddLeaveUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
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


-(void)_back
{
    UIViewController *contVC= [self.storyboard instantiateViewControllerWithIdentifier:@"navigation"];
    contVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:contVC animated:YES completion:nil];
//    self.tabBarController.selectedIndex = 0;
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark webView Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSString *protocol = @"leave_view";
    NSLog(@"%@",requestString);
    if ([requestString rangeOfString:protocol].location != NSNotFound) {
        sendUrl = requestString;
        [self performSegueWithIdentifier:@"studentLeave_content" sender:self];
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    StudentLeaveContentViewController* view = segue.destinationViewController;
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
