//
//  ViewController.h
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-4.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ASTextField;

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet ASTextField *userName;
@property (strong, nonatomic) IBOutlet ASTextField *passWord;
@property (strong, nonatomic) IBOutlet UIButton *savePassWord;

- (IBAction)textDidEndOnExit:(ASTextField *)sender;
- (IBAction)login;
- (IBAction)savePassWord:(UIButton *)sender;

@end
