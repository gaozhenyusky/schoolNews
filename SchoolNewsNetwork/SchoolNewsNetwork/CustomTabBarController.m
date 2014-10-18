//
//  CustomViewController.m
//  SchoolNewsNetwork
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "CustomTabBarController.h"

#import "Items.h"
#import "TabBar.h"

@interface CustomTabBarController ()<TabBarDelegate>
{
    BOOL _enter;
}
@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.selectedIndex = _currentIndex;
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)viewDidAppear:(BOOL)animated
{
//    _currentIndex = self.selectedIndex;
    self.selectedIndex = _currentIndex;
}


- (void)viewDidLayoutSubviews
{
    if (!_enter)
    {
        [self.tabBar addSubview:[self createMyTabBar]];
    }
}

- (UIView *)createMyTabBar
{
    NSArray *titleArray=@[@"查询中心",
                          @"通知查询",
                          @"作业查询",
                          @"考勤查询",
                          @"成绩查询",
                          @"评语查询",
                          @"在线请假",
                          @"个人设置"
                          ];
    NSMutableArray *itemsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<8; i++)
    {
        //        UIImage *image=[UIImage imageNamed:imageArray[i]];
        Items *item=[[Items alloc]initWithImage:nil title:titleArray[i]];
        //        item.selectImage=[UIImage imageNamed:@"TabBarHomeBackgroundSelected.png"];
        [itemsArray addObject:item];
    }
    TabBar *tabBar=[[TabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.itemArray=itemsArray;
    //    tabBar.bgImage=[UIImage imageNamed:@"RecommandationViewTitleBackground"];
    
    tabBar.delegate=self;
    return tabBar;
}

#pragma mark -tabBarDelegate
- (void)tabBar:(TabBar *)tabBar didTag:(NSInteger)tag
{
    self.selectedIndex = tag-1;
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
