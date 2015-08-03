//
//  API.h
//  Giveit100
//
//  Created by ytb on 14-3-10.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConnection.h"

@class SendJokeModel;

#define SAFE_SETOBJECT(dict,val, key) {if((val)!=nil) [dict setObject:(val) forKey:key]; else NSLog(@"Param is nil.");}

#define TOKEN [AppSetting getToken]

@interface API : ServerConnection


#pragma mark - Server-Interfaces
//下面是接口

// 上传段子
- (void)uploadJoke:(SendJokeModel *)sendJokeModel;



@end
