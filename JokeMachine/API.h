//
//  API.h
//  Giveit100
//
//  Created by ytb on 14-3-10.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConnection.h"

@class PostModel;
@class FetionUserInfo;
@class VideoModel;
@class LoginModel;

#define SAFE_SETOBJECT(dict,val, key) {if((val)!=nil) [dict setObject:(val) forKey:key]; else NSLog(@"Param is nil.");}

#define TOKEN [AppSetting getToken]

@interface API : ServerConnection


#pragma mark - Server-Interfaces
//下面是接口

// 上传视频
//- (void)api_postUploadVideoFiles:(PostModel *)model;


@end
