//
//  API.m
//  Giveit100
//
//  Created by ytb on 14-3-10.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "API.h"
#import "SendJokeModel.h"

@implementation API


// 上传段子
- (void)uploadJoke:(SendJokeModel *)sendJokeModel{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *jokeLength = [NSString stringWithFormat:@"%d",sendJokeModel.length];
    NSString *jokeType = [NSString stringWithFormat:@"%d",sendJokeModel.jokeType];
    
    SAFE_SETOBJECT(params, @"jokeName", sendJokeModel.jokeName);
    SAFE_SETOBJECT(params, @"length", jokeLength);
    SAFE_SETOBJECT(params, @"jokeType",jokeType);
    SAFE_SETOBJECT(params, @"userId", sendJokeModel.userId);
    SAFE_SETOBJECT(params, @"jokeData",sendJokeModel.jokeDataStr);
    
    [super asyncPost:@"" params:params];
}

@end