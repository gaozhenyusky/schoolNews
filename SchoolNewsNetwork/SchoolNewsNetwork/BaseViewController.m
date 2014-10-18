//
//  BaseViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
//    UINavigationItem *navigationItem;
//    UINavigationBar *navigationBar;
    UIButton *btn;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _myNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    }else{
        _myNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    }
    //    [self.webView setFrame:CGRectMake(0, navigationBar.frame.size.height-20, self.view.frame.size.width, self.view.frame.size.height-navigationBar.frame.size.height-29)];
    
//    [navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back_1"] style:UIBarButtonItemStylePlain target:self action:@selector(_back)]];
    _myNavigationItem = [[UINavigationItem alloc] init];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"ishome.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(_back) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 25, 25);
    
    _myNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [_myNavigationBar pushNavigationItem:_myNavigationItem animated:NO];
//    navigationBar.backgroundColor = [UIColor clearColor];
    _myNavigationBar.barTintColor = [UIColor colorWithRed:103/255.0 green:153/255.0 blue:234/255.0 alpha:1];
//    [self.view addSubview:navigationBar];
    // Do any additional setup after loading the view.
}


//- (void)viewDidAppear:(BOOL)animated
//{
//    [self.view addSubview:navigationBar];
//}

- (void)viewDidLayoutSubviews
{
    [self.view addSubview:_myNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)_back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTheTitle:(NSString *)title{
    _myNavigationItem.title =title;
}

- (void)setNavigationLeftBg:(NSString *)leftImg
{
    [btn setImage:[UIImage imageNamed:leftImg] forState:UIControlStateNormal];
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
