//
//  AppSetting.m
//  FetionSchool
//
//  Created by 蔡建海 on 12-12-20.
//  Copyright (c) 2012年 蔡建海. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting

// 存取版本号，用于判断是否显示新手引导
+ (NSString *)getAppVersionCurrent {
    NSString *strVersion = @"";
    strVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    return strVersion;
}

+ (NSString *)getAppVersionSaved {
    
	NSString *strVersion = @"";
    strVersion = [[NSUserDefaults standardUserDefaults] stringForKey:APP_VERSION_SAVED];
    
	return strVersion;
}

+ (void)saveAppVersion {
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:APP_VERSION_SAVED];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
