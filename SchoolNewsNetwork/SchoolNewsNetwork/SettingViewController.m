//
//  SettingViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingContentViewController.h"
static NSString *kSettingUrl = @"http://m.xxtwl.com/apps/settings.html?iphone=%@&password=%@";

@interface SettingViewController ()<UIWebViewDelegate>
{
    NSString *sendUrl;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTheTitle:@"个人设置"];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginID"];
    NSString *password = [[NSUserDefaults standardUserDefaults ]objectForKey:@"pass"];
    NSString *urlStr= [NSString stringWithFormat:kSettingUrl,userID,password];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self setWebViewFrame];
    self.webView.delegate = self;
    [self.webView loadRequest:request];

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
    NSString *protocol = @"check";
    NSString *protocol2 = @"contacts";
    NSLog(@"%@",requestString);
    if ([requestString rangeOfString:protocol].location != NSNotFound||[requestString rangeOfString:protocol2].location != NSNotFound) {
        sendUrl = requestString;
        [self performSegueWithIdentifier:@"setting_content" sender:self];
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SettingContentViewController *view = segue.destinationViewController;
    view.sendUrl =sendUrl;
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
