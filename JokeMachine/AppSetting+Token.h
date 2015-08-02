//
//  AppSetting+Token.h
//  Giveit100
//
//  Created by 蔡建海 on 14-3-14.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "AppSetting.h"

@class FetionTokenModel;

@interface AppSetting (Token)

// 新浪微博的token有效
+ (BOOL)isValidSinaToken;


// 保存Token
+ (void)saveSinaToken:(NSString *)token;
// 获取
+ (NSString *)getSinaToken;
// 删除Token状态
+ (void)removeSinaToken;


// 保存我的Token
+ (void)saveToken:(NSString *)token;
// 获取我的Token
+ (NSString *)getToken;
// 删除我的Token
+ (void)removeToken;

// 保存飞信的Token
+ (void)saveFetionToken:(FetionTokenModel *)token;
// 获取飞信的Token
+ (FetionTokenModel *)getFetionToken;
// 删除飞信的Token
+ (void)removeFetionToken;

// 是否登录
+ (BOOL)isLogin;

//token 是否过期
+ (BOOL)isValidFetionToken;

//token 是否在一天之内过期
+ (BOOL)isValidFetionTokenInOneDay;

@end
