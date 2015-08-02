//
//  AppSetting+Setting.h
//  Giveit100
//
//  Created by Ginger on 14-3-31.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "AppSetting.h"

@interface AppSetting (Setting)

// 保存自动播放设置
+ (void)saveAutoPlaySettingNum:(int)autoPlayNum;
// 获取自动播放设置
+ (int)getAutoPlaySettingNum;


// status 当前网络 0://无网络 1://GPRS 2://WIFI
+ (void)saveCurrentNetStatus:(int)netStatus;
+ (int)getCurrentNetStatus;


// 当前网络环境下是否请允许自动播放
+ (void)saveAutoPlayStatus;
// 当前网络环境下是否请允许自动播放
+ (BOOL)getAutoPlayStatus;


// 禁止匿名发布
+ (void)saveBanAnonymousStatus:(BOOL)flag;
//
+ (BOOL)getBanAnonymousStatus;

//
+ (void)removeBanAnonymousStatus;



@end

