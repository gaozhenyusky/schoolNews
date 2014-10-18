//
//  QueryCenterViewController.h
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-4.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView/ImagePlayerView.h"

@interface QueryCenterViewController : UIViewController
@property (strong, nonatomic) IBOutlet ImagePlayerView *topScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *noticeSumDot;
@property (strong, nonatomic) IBOutlet UIImageView *homeWorkSumDot;
@property (strong, nonatomic) IBOutlet UIImageView *dutyStudentSumDot;
@property (strong, nonatomic) IBOutlet UIImageView *studentScoreSumDot;
@property (strong, nonatomic) IBOutlet UIImageView *noticeStudentSumDot;
@property (strong, nonatomic) IBOutlet UIImageView *studentLeaveUnreadSumDot;
- (IBAction)btnAction:(UIButton *)sender;
@end
