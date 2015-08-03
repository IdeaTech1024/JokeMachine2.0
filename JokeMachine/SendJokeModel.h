//
//  SendJokeModel.h
//  JokeMachine
//
//  Created by 郝锋 on 15/8/2.
//  Copyright (c) 2015年 李永亮. All rights reserved.
//

#import <Foundation/Foundation.h>

enum JokeType{
    funnyJoke = 1,
    embarrassedJoke = 2,
    coldJoke = 3,
    yellowJoke = 4,
    othersJoke = 5

};

@interface SendJokeModel : NSObject

@property (nonatomic) enum JokeType jokeType;
@property (nonatomic,strong) NSString *jokeName;
@property (nonatomic) int length;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *jokeDataStr;



@end
