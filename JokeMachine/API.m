//
//  API.m
//  Giveit100
//
//  Created by ytb on 14-3-10.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "API.h"

@implementation API

// 下面是接口实现：

//// 上传 (model 含有本地图片和视频的路径)
//- (void)api_fileUpload:(PostModel *)model
//{
//    NSData *dataVideo = [NSData dataWithContentsOfFile:model.videoFilterUrl];
//    
//    NSData *dataImage = [NSData dataWithContentsOfFile:model.localImagePath];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
//    
//    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
//    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
//    
//    [super asyncPost:@"api/v3/video/fileupload" withDataImage:dataImage dataVideo:dataVideo params:params];
//}

@end