//
//  LoginUser.h
//  SchoolNewsNetwork
//
//  Created by heyuqing on 14-9-9.
//  Copyright (c) 2014年 heyuqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
@interface LoginUser : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *Photoimg;
@property(nonatomic,strong)NSString *schoolCode;
@property(nonatomic,strong)NSString *userID;
DEFINE_SINGLETON_FOR_HEADER(LoginUser);
@end
