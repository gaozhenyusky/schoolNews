//
//  LaunchViewController.m
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-14.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "LaunchViewController.h"
#import "LoginViewController.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "LoginUser.h"
static NSString *TheURL = @"http://api.xxtwl.com/Interface/IdexService.ashx?action=Studylogin&iphone=%@&password=%@";
@interface LaunchViewController ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    ASIFormDataRequest *request;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end
NSInteger sumPage =6;
@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"action.jpg"]];
    imgView.frame = self.view.bounds;
    [self.view addSubview:imgView];
//    [self createScr];
}

- (void)viewDidAppear:(BOOL)animated
{
    BOOL b = [[NSUserDefaults standardUserDefaults]boolForKey:@"first"];
    if (!b)
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"first"];
        [self createScr];
    }
    else
    {
        [self go];
//        [self performSegueWithIdentifier:@"toLogin" sender:self];
    }
}

- (void)go
{
    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"loginID"].length>0)
    {
        NSString *loginID = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginID"];
        NSString *pass = [[NSUserDefaults standardUserDefaults] stringForKey:@"pass"];
        NSString *urlStr = [NSString stringWithFormat:TheURL,loginID,pass];
        NSURL *url = [NSURL URLWithString:urlStr];
        request = [ASIFormDataRequest requestWithURL:url];
        request.timeOutSeconds = 10;
        [request setDelegate:self];
        
        [request setDidFinishSelector:@selector(_finishSelector)];
        [request setDidFailSelector:@selector(_failSelector)];
        [request startAsynchronous];
        //        [HUD show:YES];
    }
}

- (void)_finishSelector
{
    SBJsonParser *parser = [[SBJsonParser alloc]init];
    NSDictionary *dic = [parser objectWithString:request.responseString];
    NSString *result = [dic objectForKey:@"ErrCode"];
    if ([result isEqualToString:@"1"]) {
        LoginUser *user= [LoginUser sharedLoginUser];
        NSArray *arr = [dic objectForKey:@"Items"];
        NSDictionary *userInfo = arr[0];
        user.name = [userInfo objectForKey:@"Name"];
        user.Photoimg = [userInfo objectForKey:@"Photoimg"];
        user.schoolCode = [userInfo objectForKey:@"SchoolCode"];
        user.userID = [userInfo objectForKey:@"ID"];
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"navigation"] animated:NO completion:nil];
        [[NSUserDefaults standardUserDefaults]setObject:[userInfo objectForKey:@"SchoolCode"] forKey:@"SchoolCode"];
    }else{
        [self performSegueWithIdentifier:@"toLogin" sender:self];
    }

}

- (void)_failSelector
{
    [self performSegueWithIdentifier:@"toLogin" sender:self];
}

- (void)createScr
{
    _scrollView.frame = self.view.bounds;
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*sumPage, self.view.bounds.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<sumPage; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                switch (i)
                {
                    case 0:
                        imageView.image = [UIImage imageNamed:@"yi.jpg"];
                        break;
                    case 1:
                        imageView.image = [UIImage imageNamed:@"er.jpg"];
                        break;
                    case 2:
                        imageView.image = [UIImage imageNamed:@"san.jpg"];
                        break;
                    case 3:
                        imageView.image = [UIImage imageNamed:@"si.jpg"];
                        break;
                    case 4:
                        imageView.image = [UIImage imageNamed:@"wu.jpg"];
                        break;
                    case 5:
                        imageView.image = [UIImage imageNamed:@"liu.jpg"];
                        break;
        
                    default:
                        break;
                }
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:_scrollView];
    
//    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height-30,100, 10)];
//    pageControl.numberOfPages = sumPage;
//    [self.view addSubview:pageControl];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      
{
    CGPoint point = scrollView.contentOffset;
    NSInteger currentPage = point.x/self.view.bounds.size.width;
    pageControl.currentPage = currentPage;
    if (currentPage == sumPage-1)
    {
        [self performSegueWithIdentifier:@"toLogin" sender:self];
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
