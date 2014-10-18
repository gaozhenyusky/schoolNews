//
//  ViewController.m
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-4.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import "LoginViewController.h"
#import "ASTextField.h"
#import "ASIFormDataRequest.h"
#import "LoginUser.h"
#import "SBJson.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "GetPassWordViewController.h"

static NSString *TheURL = @"http://api.xxtwl.com/Interface/IdexService.ashx?action=Studylogin&iphone=%@&password=%@";
static NSString *getPassWord =@"http://m.xxtwl.com/apps/getpassword.html＼";

@interface LoginViewController ()
{
    ASIFormDataRequest *request;
    MBProgressHUD *HUD;
}



@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (HUD ==nil) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
    }
    HUD.labelText = @"登陆中...";
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    [self.userName setupTextFieldWithIconName:@"user_name_icon"];
    [self.passWord setupTextFieldWithIconName:@"password_icon"];
    self.userName.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"loginID"];
    self.passWord.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"pass"];
    self.userName.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.passWord.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.userName.layer.borderWidth = 1.0f;
    self.passWord.layer.borderWidth = 1.0f;
    [self.passWord setSecureTextEntry:YES];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"savePassWord"]) {
        self.savePassWord.selected = YES;
    }else{
        self.savePassWord.selected = NO;
    }
//    [self.savePassWord setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
//    [self.savePassWord setImage:[UIImage imageNamed:@"checkbox2.png"] forState:UIControlStateSelected];
//

    [self go];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
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
        request.timeOutSeconds = 20;
        [request setDelegate:self];
        
        [request setDidFinishSelector:@selector(_finishSelector)];
        [request setDidFailSelector:@selector(_failSelector)];
        [request startAsynchronous];
//        [HUD show:YES];
    }
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if ([[NSUserDefaults standardUserDefaults]stringForKey:@"loginID"].length>0)
//    {
//        NSString *loginID = [[NSUserDefaults standardUserDefaults] stringForKey:@"loginID"];
//        NSString *pass = [[NSUserDefaults standardUserDefaults] stringForKey:@"pass"];
//        NSString *urlStr = [NSString stringWithFormat:TheURL,loginID,pass];
//        NSURL *url = [NSURL URLWithString:urlStr];
//        request = [ASIFormDataRequest requestWithURL:url];
//        request.timeOutSeconds = 20;
//        [request setDelegate:self];
//        
//        [request setDidFinishSelector:@selector(_didPass)];
//        [request setDidFailSelector:@selector(_failSelector)];
//        [request startAsynchronous];
//    }
//    [HUD show:YES];
//}

//- (void)_didPass
//{
////    [self performSegueWithIdentifier:@"login_index" sender:self];
//}

- (IBAction)textDidEndOnExit:(ASTextField *)sender
{
    [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self registerForKeyboardNotifications];
}

#pragma mark-键盘上推通知注册
- (void)registerForKeyboardNotifications

{
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)keyboardWasShown:(NSNotification *)sender
{
    self.view.frame = CGRectMake(0, -150, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)keyboardWillBeHidden:(NSNotification *)sender
{
    self.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
}

-(void)login
{
    NSString *loginID = self.userName.text;
    NSString *pass = self.passWord.text;
    if ([loginID isEqualToString:@""] ||[pass isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名和密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:loginID forKey:@"loginID"];
        [[NSUserDefaults standardUserDefaults]setObject:pass forKey:@"pass"];
        NSString *urlStr = [NSString stringWithFormat:TheURL,loginID,pass];
        NSURL *url = [NSURL URLWithString:urlStr];
        request = [ASIFormDataRequest requestWithURL:url];
        request.timeOutSeconds = 60;
        [request setDelegate:self];
        
        [request setDidFinishSelector:@selector(_finishSelector)];
        [request setDidFailSelector:@selector(_failSelector)];
        [request startAsynchronous];
    }
    [HUD show:YES];
}

#pragma mark-忘记密码（还是保存密码的名字）
- (IBAction)savePassWord:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"savePassWord"];
//    }else{
//        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"savePassWord"];
//        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"pass"];
//    }
    
    GetPassWordViewController *getPasswordVC = [[GetPassWordViewController alloc]init];
    getPasswordVC.sendUrl = getPassWord;
    [self presentViewController:getPasswordVC animated:YES completion:nil];
}

-(void)_finishSelector
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
        [self performSegueWithIdentifier:@"login_index" sender:self];
        [[NSUserDefaults standardUserDefaults]setObject:[userInfo objectForKey:@"SchoolCode"] forKey:@"SchoolCode"];
    }else{
        NSString *error = [dic objectForKey:@"Description"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    [HUD hide:YES];
}

-(void)_failSelector
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不稳定，请重试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    [HUD hide:YES];
}
@end
