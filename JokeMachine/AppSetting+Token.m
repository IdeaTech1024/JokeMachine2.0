//
//  AppSetting+Token.m
//  Giveit100
//
//  Created by 蔡建海 on 14-3-14.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "AppSetting+Token.h"

@implementation AppSetting (Token)

/*
 
// 新浪微博的token有效
+ (BOOL)isValidSinaToken
{
    NSString *token = [self getSinaToken];
    
    if (token && ![token isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


// 保存Token
+ (void)saveSinaToken:(NSString *)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"sinaToken"];
    [defaults synchronize];
}

// 获取Token
+ (NSString *)getSinaToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"sinaToken"];
}
// 删除Token状态
+ (void)removeSinaToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"sinaToken"];
}



#pragma mark - myToken
// 保存我的Token
+ (void)saveToken:(NSString *)token
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"myToken"];
    [defaults synchronize];
}
// 获取我的Token
+ (NSString *)getToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"myToken"];
}

// 删除我的Token
+ (void)removeToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"myToken"];
}

// 保存飞信的Token
+ (void)saveFetionToken:(FetionTokenModel *)token
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:token];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"fetionToken"];
    [defaults synchronize];
}
// 获取飞信的Token
+ (FetionTokenModel *)getFetionToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"fetionToken"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
// 删除飞信的Token
+ (void)removeFetionToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"fetionToken"];
}

// 是否登录
+ (BOOL)isLogin
{
    NSString *userID = [AppSetting getUserID];
    
    if ([userID isEqualToString:@""] ||userID == nil) {
        return NO;
    }
    return YES;
}

//token 是否过期
+ (BOOL)isValidFetionToken
{
    FetionTokenModel *tokenModel = [AppSetting getFetionToken];
    
    if (tokenModel == nil) {
        return NO;
    }
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long timeInterval = (long)interval;
    
    if (tokenModel.expiresTime > (timeInterval - tokenModel.expiresBaseTime)) {
        
        return YES;
    }else
    {
        return NO;
    }
}

//token 是否在一天之内过期
+ (BOOL)isValidFetionTokenInOneDay
{
    FetionTokenModel *tokenModel = [AppSetting getFetionToken];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    long timeInterval = (long)interval;
    
    // 有效期还剩下一天了
    if (tokenModel.expiresTime - (timeInterval - tokenModel.expiresBaseTime) <= TOKEN_TIMELEFT) {
        
        return YES;
    }else
    {
        return NO;
    }
}
 
 */

@end
