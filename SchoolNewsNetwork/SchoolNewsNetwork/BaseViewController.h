//
//  BaseViewController.h
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-28.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic,strong) UINavigationItem *myNavigationItem;
@property(nonatomic,strong) UINavigationBar *myNavigationBar;
- (void)setTheTitle:(NSString *)title;
- (void)setNavigationLeftBg:(NSString *)leftImg;

@end
