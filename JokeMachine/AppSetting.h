//
//  AppSetting.h
//  FetionSchool
//
//  Created by 蔡建海 on 12-12-20.
//  Copyright (c) 2012年 蔡建海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSetting : NSObject


// 存取版本号，用于判断是否显示新手引导
+ (NSString *)getAppVersionCurrent;
+ (NSString *)getAppVersionSaved;
+ (void)saveAppVersion;



@end
