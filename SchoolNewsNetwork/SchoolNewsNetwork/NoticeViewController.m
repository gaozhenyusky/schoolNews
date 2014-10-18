//
//  NoticeViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-15.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//
static NSString  *kNoticeUrl = @"http://m.xxtwl.com/apps/notices.html?iphone=%@&password=%@";

#import "NoticeViewController.h"
#import "NoticeContentViewController.h"
#import "CustomTabBarController.h"

@interface NoticeViewController ()<UIWebViewDelegate>
{
    NSString *sendUrl;
}
@end

@implementation NoticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    UINavigationBar *navigationBar;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 66)];
//    }else{
//        navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    }
////    [self.webView setFrame:CGRectMake(0, navigationBar.frame.size.height-20, self.view.frame.size.width, self.view.frame.size.height-navigationBar.frame.size.height-29)];
//    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"通知查询"];
//    [navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(_back)] ];
//    [navigationBar pushNavigationItem:navigationItem animated:NO];
//    [self.view addSubview:navigationBar];
    
    [self setTheTitle:@"正在加载"];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginID"];
    NSString *password = [[NSUserDefaults standardUserDefaults ]objectForKey:@"pass"];
    NSString *urlStr= [NSString stringWithFormat:kNoticeUrl,userID,password];
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

- (void)sousuo:(UIButton *)sender
{
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"seach_click();"];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
//    NSInteger selectIndex = ((CustomTabBarController *)self.tabBarController).currentIndex;
//    self.tabBarController.selectedIndex = selectIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self setTheTitle:@"通知查询"];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSString *protocol = @"content";
    NSLog(@"%@",requestString);
    if ([requestString rangeOfString:protocol].location != NSNotFound) {
        
        sendUrl = requestString;
        [self performSegueWithIdentifier:@"notice_content" sender:self];
        return NO;
    }
        return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NoticeContentViewController* view = segue.destinationViewController;
    view.url =sendUrl;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
