//
//  QueryCenterViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-4.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "QueryCenterViewController.h"
#import "ASIHTTPRequest.h"
#import "UIImageView+AddText.h"
#import "SBJson.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "LoginUser.h"

#import "Items.h"
#import "TabBar.h"

#import "CustomTabBarController.h"

static NSString * _kUrl = @"http://api.xxtwl.com/Interface/IdexService.ashx?action=GetNavigationUnread&SchoolCode=%@&StuId=%@";

@interface QueryCenterViewController ()<ImagePlayerViewDelegate>
{
    ASIHTTPRequest *request;
    NSMutableArray *imageURLs;
    MBProgressHUD *HUD;
    NSInteger selectTag;
    
    CustomTabBarController *controller;
}
@end

@implementation QueryCenterViewController

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
    if (HUD ==nil) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    HUD.labelText = @"加载中...";
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    self.title = @"主页";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
   
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [HUD show:YES];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *urlStr= [NSString stringWithFormat:_kUrl,[[NSUserDefaults standardUserDefaults]stringForKey:@"SchoolCode"],[[NSUserDefaults standardUserDefaults]stringForKey:@"loginID"]];
    NSLog(@"%@",urlStr);
    
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    request.timeOutSeconds = 30;
    [request setDidFinishSelector:@selector(_finishSelector)];
    [request setDidFailSelector:@selector(_failSelector)];
    [request startAsynchronous];
}

-(void)_failSelector
{
    NSLog(@"fail");
    [HUD hide:YES];
}

-(void)_finishSelector
{
    SBJsonParser *parse = [[SBJsonParser alloc]init];

    NSDictionary *dic = [parse objectWithString:request.responseString];
   
    NSArray *numDic = [dic objectForKey:@"Items"];
    NSDictionary *aa = numDic[0];
    NSArray *uDic = aa[@"AdvertisingList"];
    NSArray *urlDic = uDic[0][@"Items"];
    if (imageURLs ==nil) {
        imageURLs = [[NSMutableArray alloc]init];
    }
//    [imageURLs removeAllObjects];
    if (imageURLs.count==0) {
        [urlDic enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"%@",obj[@"ImgUrl"]);
            NSString *cc = obj[@"ImgUrl"];
            [imageURLs addObject:cc];
        }];
        [self.topScrollView clearsContextBeforeDrawing];
        [self.topScrollView initWithCount:imageURLs.count delegate:self];
        self.topScrollView.scrollInterval = 5.0f;
        
        // adjust pageControl position
        self.topScrollView.pageControlPosition = ICPageControlPosition_BottomLeft;
        
        // hide pageControl or not
        self.topScrollView.hidePageControl = NO;
        

    }
    
 
    
    
    [self _setDot:aa];
    
    
    
    [HUD hide:YES];
}

- (IBAction)btnAction:(UIButton *)sender {
    selectTag = sender.tag-1;
    [self performSegueWithIdentifier :@"center_items" sender:self];
}

-(void)_setDot:(NSDictionary *)numDic
{
    NSString *noticeNum = [NSString stringWithFormat:@"%@.png",[numDic objectForKey:@"NoticeSum"]];
    NSString *homeWorkSum = [NSString stringWithFormat:@"%@.png",[numDic objectForKey:@"HomeWorkSum"]];
    NSString *dutyStudentSum = [NSString stringWithFormat:@"%@.png",[numDic objectForKey:@"DutyStudentSum"]];
    NSString *studentScoreSum = [NSString stringWithFormat:@"%@.png",[numDic objectForKey:@"StudentScoreSum"]];
    NSString *noticeStudentSum = [NSString stringWithFormat:@"%@.png",[numDic objectForKey:@"NoticeStudentSum"]];
    NSString *studentLeaveUnreadSum = [NSString stringWithFormat:@"%@.png",[numDic objectForKey:@"StudentLeaveUnreadSum"]];
    if (![noticeNum isEqualToString:@"0.png"]) {
        [self.noticeSumDot setImage:[UIImage imageNamed:noticeNum]];
        self.noticeSumDot.hidden =NO;
    }else{
        self.noticeSumDot.hidden = YES;
    }
    if (![homeWorkSum isEqualToString:@"0.png"]) {
        [self.homeWorkSumDot setImage:[UIImage imageNamed:homeWorkSum]];
        self.homeWorkSumDot.hidden = NO;
    }else{
        self.homeWorkSumDot.hidden =YES;
    }
    if (![dutyStudentSum isEqualToString:@"0.png"]) {
        [self.dutyStudentSumDot setImage:[UIImage imageNamed:dutyStudentSum]];
        self.dutyStudentSumDot.hidden = NO;
    }else{
        self.dutyStudentSumDot.hidden =YES;
    }
    if (![studentScoreSum isEqualToString:@"0.png"]) {
        [self.studentScoreSumDot setImage:[UIImage imageNamed:studentScoreSum]];
        self.studentScoreSumDot.hidden = NO;
    }else{
        self.studentScoreSumDot.hidden=YES;
    }
    if (![noticeStudentSum isEqualToString:@"0.png"]) {
        [self.noticeStudentSumDot setImage:[UIImage imageNamed:noticeStudentSum]];
        self.noticeStudentSumDot.hidden = NO;
    }else{
        self.noticeStudentSumDot.hidden = YES;
    }
    if (![studentLeaveUnreadSum isEqualToString:@"0.png"]) {
        [self.studentLeaveUnreadSumDot setImage:[UIImage imageNamed:studentLeaveUnreadSum]];
        self.studentLeaveUnreadSumDot.hidden = NO;
    }else{
        self.studentLeaveUnreadSumDot.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    controller = segue.destinationViewController;
    controller.moreNavigationController.navigationBarHidden = YES;
    
//    controller.currentIndex = selectTag;
}

- (void)viewWillDisappear:(BOOL)animated
{
    controller.currentIndex = selectTag;
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

#pragma mark - ImagePlayerViewDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    
//    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[imageURLs objectAtIndex:index]]];
  
    [imageView setImageWithURL:[NSURL URLWithString:imageURLs[index]] placeholderImage:[UIImage imageNamed:@"banner.png"]];
//    imageView.image = [UIImage imageNamed:@"banner.png"];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}



@end
