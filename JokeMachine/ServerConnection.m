//
//  ServerConnection.m
//  Giveit100
//
//  Created by ytb on 14-3-20.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "ServerConnection.h"

@interface ServerConnection()

@property (nonatomic, strong)AFHTTPRequestOperationManager *manager;

@property (nonatomic, assign)BOOL needReLogin;
@end

@implementation ServerConnection
@synthesize timeoutInt,delegate,hasError,errorDetail,errorMessage;
@synthesize showNetErrToast = _showNetErrToast;
@synthesize dict = _dict;
@synthesize arr = _arr;
@synthesize objectData = _objectData;
@synthesize statusCode = _statusCode;

@synthesize strJson = _strJson;


@synthesize needReLogin = _needReLogin;



/**********是否为注册接口，等weiwei过来联调, 图片参数和上传视频的图片参数不一致***************/
@synthesize isAPIRegister;
/***********************************************************************************/




- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction {
	
    return [self initWithDelegate:aDelegate action:anAction action:nil];
}

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction action:(SEL)actionProgress
{
    self = [super init];
	if (self) {
		self.delegate = aDelegate;
		action = anAction;
        _actionProgress = actionProgress;
        
        //超时：WIFI 20s | GPRS 30s | 上传图片 120s(单独设置)
        timeoutInt = [AppSetting getCurrentNetStatus]==2?TIMEOUT_INTERVAL_WIFI:TIMEOUT_INTERVAL_GPRS;
        _showNetErrToast = YES;
	}
	return self;
}
#pragma mark - get
//
- (AFHTTPRequestOperationManager *)manager
{
    if (!_manager) {
        
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

//
- (NSMutableDictionary *)dict
{
    if (!_dict) {
        _dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

//
- (NSMutableArray *)arr
{
    if (!_arr) {
        
        _arr = [NSMutableArray array];
    }
    return _arr;
}

#pragma mark - private
//
- (void)defaultInit
{
    [self.arr removeAllObjects];
    [self.dict removeAllObjects];
    _needReLogin = NO;
    self.errorMessage = nil;
    self.strJson = nil;
    self.objectData = nil;
}

// 成功解析 GET
- (void)parseGetJsonSucess:(AFHTTPRequestOperation *)operation reponseObj:(id)reponseObject
{
    if ([operation responseData] == nil) {
        NSLog("operation responseData = nil -特殊错误处理");
        self.hasError = YES;
        errorMessage = NSLocalizedString(@"NetErrorTryLater", nil);
        
    } else {
        
        NSError *err = nil;
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&err];
        if (obj!=nil&&err==nil) {
            //                NSLog(@"get data and to json OK");
        }
        
        self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        
        NSDictionary *dicts = (NSDictionary *)obj;
        
        [self parseSuccessJsonData:[dicts objectForKey:@"data"]];
        
        self.statusCode = [[dicts objectForKey:@"resultcode"] integerValue];
        
        switch (self.statusCode) {
            case 200:
                self.hasError = NO;
                break;
            case 201:
                self.hasError = YES;
                _needReLogin = YES;
                NSLog(@"201 无效的用户");
                break;
            case 202:
                NSLog(@"202 名称已存在");
                break;
            case 203:
                NSLog(@"203 无效的参数");
                self.hasError = YES;
                errorMessage = @"无效的参数";
                break;
            case 206:
                NSLog(@"206 操作频度太快");
                break;
            case 207:
                NSLog(@"207 操作的数据不存在");
                break;
            case 208:
                NSLog(@"208 含敏感词");
                self.hasError = YES;
                errorMessage = NSLocalizedString(@"SensitiveWords", nil);
                break;
            case 209:
                NSLog(@"209 没有权限");
                break;
            case 210:
                NSLog(@"210 ???");
                break;
            case 211:
                NSLog(@"211 用户被封禁");//只在登录时出现，所有的登录失败都提示“登录失败”
                break;
            case 215:
                NSLog(@"215 用户不存在(不存在或者被删除)");
                break;
            case 214:
                NSLog(@"214 达到配额限制");
                break;
            case 500:
                self.hasError = YES;
                errorMessage = NetNotInService;
                NSLog(@"500 服务器内部错误");
                break;
            case 501:
                self.hasError = YES;
                errorMessage = NetNotInService;
                NSLog(@"501 服务器操作失败");
                break;
            case 502:
                self.hasError = YES;
                errorMessage = NetNotInService;
                NSLog(@"502 数据库操作失败");
                break;
            case 503:
                self.hasError = YES;
                errorMessage = NetNotInService;
                NSLog(@"503 服务器缓存错误");
                break;
            case 504:
                self.hasError = YES;
                errorMessage = NetNotInService;
                NSLog(@"504 服务器处理超时");
                break;
            default:
                break;
        }
    }
    
}

//
- (void)parseSuccessJsonData:(NSObject *)object
{
    // 返回为数组
    if ([object isKindOfClass:NSArray.class]) {
        
        NSArray *array = (NSArray *)object;
        [self.arr addObjectsFromArray:array];
    }
    // 返回为对象
    else if ([object isKindOfClass:NSDictionary.class])
    {
        NSDictionary *dictionary = (NSDictionary *)object;
        [self.dict addEntriesFromDictionary:dictionary];
    }
    else if ([object isKindOfClass:NSNull.class])
    {
        NSLog(@"error: 返回数据为NSNull");
    }
    else if([object isKindOfClass:NSObject.class])
    {
        NSObject *objectD = (NSObject *)object;
        self.objectData = objectD;
    }else
    {
        
    }
}


#pragma mark - custom

- (void) asyncPost:(NSString *)url
            params:(NSMutableDictionary *)params
{
    [self defaultInit];
    
    pathUrl = url;
    url = [BASE_URL stringByAppendingString:url];
    
    AFHTTPRequestSerializer *serilalizer = [AFHTTPRequestSerializer serializer];
    self.manager.requestSerializer = serilalizer;
    
    [serilalizer setValue:CURRENT_SCREEN forHTTPHeaderField:HEADER_INFO_RESOLUTION];
    [serilalizer setValue:CURRENT_PLATFORM forHTTPHeaderField:HEADER_INFO_SYSTEM];
    //    [serilalizer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [serilalizer setValue:[AppSetting getAppVersionCurrent] forHTTPHeaderField:HEADER_INFO_APPVERSION];
    
    id object = self.delegate; // 队列中函数执行完，会释放SEL所在的对象，先强引用一下，等待函数返回结果。暂时如此
    __typeof (&*self) __weak weakSelf = self;
    
    _currentOperation = [self.manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 暂时， 后期删除
        NSError *err;
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&err];
        // 暂时， 后期删除
        
        [weakSelf parseGetJsonSucess:operation reponseObj:responseObject];
        
        if (self.showNetErrToast && self.hasError) {
            if (_needReLogin == YES) {
                if ([SVProgressHUD isVisible]) {
                    [SVProgressHUD dismiss];
                }
                if ([AppSetting isLogin]) {
                    UIViewController *vc = (UIViewController *)object;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#pragma clang diagnostic pop
                    if ([vc respondsToSelector:@selector(dismissVCWhenTokenInvalid)]) {
                        [vc performSelector:@selector(dismissVCWhenTokenInvalid) withObject:nil afterDelay:0];
                    }
                    [self performSelector:@selector(tokenInvalidToLoginDelay) withObject:nil afterDelay:0.5];
                }
                
            } else {
                
                // 服务器开小差不提示
                if ([self.errorMessage isEqualToString:NetNotInService])
                {
                    if ([SVProgressHUD isVisible]) {
                        [SVProgressHUD dismiss];
                    }
                }
                else
                {
                    [SVProgressHUD showNetErrorWithStatus:self.errorMessage];
                }
            }
        }
        
        if ([object respondsToSelector:action]) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [object performSelector:action withObject:self withObject:obj];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        self.hasError = YES;
        
        if (self.showNetErrToast) {
            
            if (error.code == -999) {
                NSLog(@"请求取消");//不提示网络异常
                
            } else if (error.code == -1001) {
                NSLog(@"请求超时");
                //                [SVProgressHUD showWithOnlyStatus:NSLocalizedString(@"NetLinkTimeout", nil)];
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];//超时也提示网络问题
                
            } else {
                NSLog(@"其他请求错误");
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];
            }
        }
        
        if ([object respondsToSelector:action]) {
            [object performSelector:action withObject:self withObject:nil];
        }
    }];
}

// 上传不带流
- (void) asyncPost1:(NSString *)url
            params:(NSMutableDictionary *)params
{
    [self defaultInit];
    
    pathUrl = url;
    url = [BASE_URL stringByAppendingString:url];
    
    AFJSONRequestSerializer *serilalizer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer = serilalizer;
    
    [serilalizer setValue:CURRENT_SCREEN forHTTPHeaderField:HEADER_INFO_RESOLUTION];
    [serilalizer setValue:CURRENT_PLATFORM forHTTPHeaderField:HEADER_INFO_SYSTEM];
    //    [serilalizer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [serilalizer setValue:[AppSetting getAppVersionCurrent] forHTTPHeaderField:HEADER_INFO_APPVERSION];
    
    id object = self.delegate; // 队列中函数执行完，会释放SEL所在的对象，先强引用一下，等待函数返回结果。暂时如此
    __typeof (&*self) __weak weakSelf = self;
    
    _currentOperation = [self.manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 暂时， 后期删除
        NSError *err;
        NSObject *obj = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&err];
        // 暂时， 后期删除
        
        [weakSelf parseGetJsonSucess:operation reponseObj:responseObject];
        
        if (self.showNetErrToast && self.hasError) {
            if (_needReLogin == YES) {
                if ([SVProgressHUD isVisible]) {
                    [SVProgressHUD dismiss];
                }
                if ([AppSetting isLogin]) {
                    UIViewController *vc = (UIViewController *)object;
                    if ([vc respondsToSelector:@selector(dismissVCWhenTokenInvalid)]) {
                        [vc performSelector:@selector(dismissVCWhenTokenInvalid) withObject:nil afterDelay:0];
                    }
                    [self performSelector:@selector(tokenInvalidToLoginDelay) withObject:nil afterDelay:0.5];
                }
                
            } else {
                
                // 服务器开小差不提示
                if ([self.errorMessage isEqualToString:NetNotInService])
                {
                    if ([SVProgressHUD isVisible]) {
                        [SVProgressHUD dismiss];
                    }
                }
                else
                {
                    [SVProgressHUD showNetErrorWithStatus:self.errorMessage];
                }
            }
        }
        
        if ([object respondsToSelector:action]) {
            [object performSelector:action withObject:self withObject:obj];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        self.hasError = YES;
        
        if (self.showNetErrToast) {
            
            if (error.code == -999) {
                NSLog(@"请求取消");//不提示网络异常
                
            } else if (error.code == -1001) {
                NSLog(@"请求超时");
                //                [SVProgressHUD showWithOnlyStatus:NSLocalizedString(@"NetLinkTimeout", nil)];
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];//超时也提示网络问题
                
            } else {
                NSLog(@"其他请求错误");
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];
            }
        }
        
        if ([object respondsToSelector:action]) {
            [object performSelector:action withObject:self withObject:nil];
        }
    }];
}


//
- (void) asyncGet:(NSString *)url
           params:(NSDictionary *)params
{
    [self defaultInit];
    
    pathUrl = url;
    url = [BASE_URL stringByAppendingString:url];
    
    AFJSONRequestSerializer *serilalizer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer = serilalizer;
    
    [serilalizer setValue:CURRENT_SCREEN forHTTPHeaderField:HEADER_INFO_RESOLUTION];
    [serilalizer setValue:CURRENT_PLATFORM forHTTPHeaderField:HEADER_INFO_SYSTEM];
    //    [serilalizer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [serilalizer setValue:[AppSetting getAppVersionCurrent] forHTTPHeaderField:HEADER_INFO_APPVERSION];
    
    id object = self.delegate; // 队列中函数执行完，会释放SEL所在的对象，先强引用一下，等待函数返回结果。暂时如此
    __typeof (&*self) __weak weakSelf = self;
    
    _currentOperation = [self.manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([operation responseData] != nil) {
        
            // 暂时， 后期删除
            NSError *err;
            NSObject *obj = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&err];
            // 暂时， 后期删除
            
            [weakSelf parseGetJsonSucess:operation reponseObj:responseObject];
            
            if (self.showNetErrToast && self.hasError) {
                if (_needReLogin == YES) {
                    if ([SVProgressHUD isVisible]) {
                        [SVProgressHUD dismiss];
                    }
                    if ([AppSetting isLogin]) {
                        UIViewController *vc = (UIViewController *)object;
                        if ([vc respondsToSelector:@selector(dismissVCWhenTokenInvalid)]) {
                            [vc performSelector:@selector(dismissVCWhenTokenInvalid) withObject:nil afterDelay:0];
                        }
                        [self performSelector:@selector(tokenInvalidToLoginDelay) withObject:nil afterDelay:0.5];
                    }
                    
                } else {
                    // 服务器开小差不提示
                    if ([self.errorMessage isEqualToString:NetNotInService])
                    {
                        if ([SVProgressHUD isVisible]) {
                            [SVProgressHUD dismiss];
                        }
                    }
                    else
                    {
                        [SVProgressHUD showNetErrorWithStatus:self.errorMessage];
                    }
                }
            }
            
            if ([object respondsToSelector:action]) {
                [object performSelector:action withObject:self withObject:obj];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        self.hasError = YES;
        
        if (self.showNetErrToast) {
            
            if (error.code == -999) {
                NSLog(@"请求取消");//不提示网络异常
                
            } else if (error.code == -1001) {
                NSLog(@"请求超时");
                //                [SVProgressHUD showWithOnlyStatus:NSLocalizedString(@"NetLinkTimeout", nil)];
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];//超时也提示网络问题
                
            } else {
                NSLog(@"其他请求错误");
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];
            }
        }
        
        if ([object respondsToSelector:action]) {
            [object performSelector:action withObject:self withObject:nil];
        }
    }];
}

- (void)tokenInvalidToLoginDelay {

    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTokenInvalidToLoginVC object:nil];
}

// 上传带流 图片流 视频流
- (void) asyncPost:(NSString *)relativeUrl
     withDataImage:(NSData *)dataImage
         dataVideo:(NSData*)dataVideo
            params:(NSMutableDictionary *)params
{
    NSMutableArray *marrayDataImage = [[NSMutableArray alloc]initWithCapacity:2];
    if (dataImage) {
        [marrayDataImage addObject:dataImage];
    }
    NSMutableArray *marrayDataVideo = [[NSMutableArray alloc]initWithCapacity:2];
    if (dataVideo) {
        [marrayDataVideo addObject:dataVideo];
    }
    
    [self asyncPost:relativeUrl withDataImages:marrayDataImage dataVideos:marrayDataVideo params:params];
}

// 上传带流
- (void) asyncPost:(NSString *)relativeUrl
    withDataImages:(NSMutableArray *)dataImages
        dataVideos:(NSMutableArray*)dataVideos
            params:(NSMutableDictionary *)params
{
    
    [self defaultInit];
    
    pathUrl = relativeUrl;
    relativeUrl = [BASE_URL stringByAppendingString:relativeUrl];
    
    AFJSONRequestSerializer *serilalizer = [AFJSONRequestSerializer serializer];
    self.manager.requestSerializer = serilalizer;
    
    [serilalizer setValue:CURRENT_SCREEN forHTTPHeaderField:HEADER_INFO_RESOLUTION];
    [serilalizer setValue:CURRENT_PLATFORM forHTTPHeaderField:HEADER_INFO_SYSTEM];
    [serilalizer setValue:[AppSetting getAppVersionCurrent] forHTTPHeaderField:HEADER_INFO_APPVERSION];
    
    id object = self.delegate; // 队列中函数执行完，会释放SEL所在的对象，先强引用一下，等待函数返回结果。暂时如此
    
    NSError *error;
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST"
                                                                           URLString:relativeUrl
                                                                          parameters:params
                                                           constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        
                                        for (int i = 0; i<dataImages.count; ++i) {
                                            
                                            NSData *data = [dataImages objectAtIndex:i];
                                            NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i ];
                                            
                                            NSString *strName = (self.isAPIRegister == YES) ? @"1_1" : @"thumb";
                                            
                                            // fileName 名字要求任意的，服务要求有，不能为空
                                            [formData appendPartWithFileData:data name:strName fileName:fileName mimeType:@""];
                                        }
                                        
                                        for (int i = 0; i<dataVideos.count; ++i) {
                                            
                                            NSData *data = [dataVideos objectAtIndex:i];
                                            NSString *fileName = [NSString stringWithFormat:@"%d.mp4",i ];
                                            // fileName 名字要求任意的，服务要求有，不能为空
                                            [formData appendPartWithFileData:data name:@"video" fileName:fileName mimeType:@""];
                                        }
                                        
                                    } error:&error];
    
    
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSObject *obj = nil;
        if ([operation responseData] != nil) {
            
            NSError *err = nil;
            obj = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&err];
            
            //            NSString *strObj = [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
            self.strJson = [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
            
            NSDictionary *dicts = (NSDictionary *)obj;
            self.statusCode = [[dicts objectForKey:@"resultcode"] integerValue];
            [self parseSuccessJsonData:[dicts objectForKey:@"data"]];
            
            NSString *publicToast = @"";
            switch (self.statusCode) {
                case 208:
                    NSLog(@"208 含敏感词");
                    self.hasError = YES;
                    publicToast = NSLocalizedString(@"SensitiveWords", nil);
                    [SVProgressHUD showWithOnlyStatus:publicToast];
                    break;
                default:
                    break;
            }
        }// 这里如果有错误数据，回调之后处理
        
        if ([self.delegate respondsToSelector:action]) {
            [self.delegate performSelector:action withObject:self withObject:obj];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"[HTTPClient Error]: %@", error);
        
        self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        
        self.hasError = YES;
        if (self.showNetErrToast) {
            
            if (error.code == -999) {
                NSLog(@"请求取消");//不提示网络异常
                
            } else if (error.code == -1001) {
                NSLog(@"请求超时");
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetLinkTimeout", nil)];
                
            } else {
                NSLog(@"其他请求错误");
                [SVProgressHUD showNetErrorWithStatus:NSLocalizedString(@"NetErrorTryLater", nil)];
            }
        }
        if ([self.delegate respondsToSelector:action]) {
            [self.delegate performSelector:action withObject:self withObject:nil];
        }
    }];
    
    
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithLongLong:totalBytesWritten], UploadTotalByteWritten,
                             [NSNumber numberWithLongLong:totalBytesExpectedToWrite], UploadTotalBytesExpectedToWrite,
                             [NSNumber numberWithInteger:bytesWritten], @"bytesWritten", nil];
        
        //        NSLog(@"总字节数：%lld", totalBytesExpectedToWrite);
        NSLog(@"已上传字节数：%lld", totalBytesWritten);
        if ([object respondsToSelector:_actionProgress]) {
            [object performSelector:_actionProgress withObject:self withObject:dic];
        }
        
    }];
    
    _currentOperation = operation;
    
    [operation start];
}

// 上传带流 json格式字符串
- (void) asyncPost:(NSString *)relativeUrl
      withJsonData:(NSData *)jsonData
            params:(NSMutableDictionary *)params
{
    pathUrl = relativeUrl;
    relativeUrl = [BASE_URL stringByAppendingString:relativeUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:relativeUrl]];
    [request setTimeoutInterval:20.f];
    [request setHTTPMethod:@"POST"];

    NSString *msgLength = [NSString stringWithFormat:@"%d", [jsonData length]];
    [request setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsonData];
    AFHTTPRequestOperation *operation =[[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    _currentOperation = operation;
    
    id object = self.delegate; // 队列中函数执行完，会释放SEL所在的对象，先强引用一下，等待函数返回结果。暂时如此

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSObject *obj = nil;
         
         if ([operation responseData] != nil) {
             
             NSError *err = nil;
             obj = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:NSJSONReadingAllowFragments error:&err];
             NSDictionary *dicts = (NSDictionary *)obj;
             
             self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
             self.statusCode = [[dicts objectForKey:@"resultcode"] integerValue];
             [self parseSuccessJsonData:[operation responseData]];
             
             
         }// 这里如果有错误数据，回调之后处理
         
         if ([object respondsToSelector:action]) {
             [object performSelector:action withObject:self withObject:obj];
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

         self.strJson = [[NSString alloc]initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
         self.hasError = YES;
         
         if ([object respondsToSelector:action]) {
             [object performSelector:action withObject:self withObject:nil];
         }
     }];
    
    [operation start];}


- (void)cancel
{
    [_currentOperation cancel];
}

@end