//
//  AppSetting+Setting.m
//  Giveit100
//
//  Created by Ginger on 14-3-31.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "AppSetting+Setting.h"

@implementation AppSetting (Setting)

// 保存自动播放设置
/*
 0：仅在wifi自动播放 - 默认
 1：始终自动播放
 2：从不自动播放
 */
+ (void)saveAutoPlaySettingNum:(int)autoPlayNum {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:autoPlayNum forKey:@"autoPlayNum"];
    [defaults synchronize];
    
    [self saveAutoPlayStatus];
}

// 获取自动播放设置
+ (int)getAutoPlaySettingNum {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int autoPlayNum = [defaults integerForKey:@"autoPlayNum"];
    return autoPlayNum;//默认返回0
}

// status 当前网络 0://无网络 1://GPRS 2://WIFI
+ (void)saveCurrentNetStatus:(int)netStatus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:netStatus forKey:@"currentNetStatus"];
    [defaults synchronize];
    
    [self saveAutoPlayStatus];
}

+ (int)getCurrentNetStatus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int autoPlayNum = [defaults integerForKey:@"currentNetStatus"];
    return autoPlayNum;//默认返回0
}



// 保存 当前网络环境下 播放情况
+ (void)saveAutoPlayStatus {
    // status 当前网络 0://无网络 1://GPRS 2://WIFI
    // playNum  0：仅在wifi自动播放 - 默认 1：始终自动播放 2：从不自动播放
    int playNum = [self getAutoPlaySettingNum];
    int status = [self getCurrentNetStatus];
    
    BOOL autoPlay = NO;
    
    if (status == 0) {
        autoPlay = NO;
        
    } else if (status == 1) {
    
        if (playNum == 0 || playNum == 2) {
            autoPlay = NO;
        } else {
            autoPlay = YES;
        }
        
    } else if (status == 2) {
        
        if (playNum == 2) {
            autoPlay = NO;
        } else {
            autoPlay = YES;
        }
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:autoPlay forKey:@"autoPlayStaus"];
    [defaults synchronize];
}

+ (BOOL)getAutoPlayStatus {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL b = [defaults boolForKey:@"autoPlayStaus"];
    return b;
}



// 禁止匿名发布
+ (void)saveBanAnonymousStatus:(BOOL)flag
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:flag forKey:@"BanAnonymousStatus"];
    [defaults synchronize];
}

//
+ (BOOL)getBanAnonymousStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:@"BanAnonymousStatus"];
}

//
+ (void)removeBanAnonymousStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"BanAnonymousStatus"];
}


@end
