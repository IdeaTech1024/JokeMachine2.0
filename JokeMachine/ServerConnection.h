//
//  ServerConnection.h
//  Giveit100
//
//  Created by ytb on 14-3-20.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../AFNetworking/AFNetworking.h"

#define HEADER_INFO_RESOLUTION @"screen"
#define HEADER_INFO_SYSTEM @"clienttype"
#define HEADER_INFO_APPVERSION @"version"

@interface ServerConnection : NSObject
{
    NSString *pathUrl;
	NSInteger _statusCode;
    SEL action;
    SEL _actionProgress; // 上传有进度条的方法
    
	BOOL        hasError;
    NSString*   errorMessage;
    NSString*   errorDetail;
    
    BOOL _showNetErrToast;//是否提示网络连接失败，默认是YES，即提示  （消息轮询不需要提示）
    
    AFHTTPRequestOperation *_currentOperation;
}



/**********是否为注册接口，等weiwei过来联调***************/
@property (nonatomic, assign) BOOL isAPIRegister;
/*****************************************************/



@property (nonatomic, strong)NSString *strJson; // 开发调试用

@property (nonatomic, weak) id delegate;

@property(nonatomic, assign) BOOL hasError;
@property(nonatomic, copy) NSString* errorMessage;
@property(nonatomic, copy) NSString* errorDetail;
@property (nonatomic, assign)NSInteger statusCode;

@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSObject *objectData; // 特殊的类型，比如数字

@property (nonatomic, assign) NSTimeInterval timeoutInt;

@property(nonatomic, assign) BOOL showNetErrToast;

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction;

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction action:(SEL)actionProgress;

- (void)cancel;

- (void) asyncGet:(NSString *)url
           params:(NSDictionary *)params;

// 上传不带流
- (void) asyncPost:(NSString *)url
            params:(NSMutableDictionary *)params;

// 上传带流
- (void) asyncPost:(NSString *)relativeUrl
    withDataImages:(NSMutableArray *)dataImages
        dataVideos:(NSMutableArray*)dataVideos
            params:(NSMutableDictionary *)params;

// 上传带流 图片流 视频流
- (void) asyncPost:(NSString *)relativeUrl
     withDataImage:(NSData *)dataImage
         dataVideo:(NSData*)dataVideo
            params:(NSMutableDictionary *)params;



// 上传带流 json格式字符串
- (void) asyncPost:(NSString *)relativeUrl
     withJsonData:(NSData *)jsonData
            params:(NSMutableDictionary *)params;


@end
