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

// 上传 (model 含有本地图片和视频的路径)
- (void)api_fileUpload:(PostModel *)model
{
    NSData *dataVideo = [NSData dataWithContentsOfFile:model.videoFilterUrl];
    
    NSData *dataImage = [NSData dataWithContentsOfFile:model.localImagePath];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncPost:@"api/v3/video/fileupload" withDataImage:dataImage dataVideo:dataVideo params:params];
}

// 发布 (model 含有图片和视频的已生成的url)
- (void)api_postVideoInfo:(PostModel *)model
{
    
    NSData *dataVideo = [NSData dataWithContentsOfFile:model.videoFilterUrl];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }
    
    NSString *strByteNum = [NSString stringWithFormat:@"%lu", (unsigned long)dataVideo.length];
    
    NSString *strPixelw = [NSString stringWithFormat:@"%i", model.videoModel.videoPixelW];
    NSString *strPixelh = [NSString stringWithFormat:@"%i", model.videoModel.videoPixelH];
    NSString *strLength = [NSString stringWithFormat:@"%i", (int)model.videoModel.videoLength];
    
    NSString *strShareToBesides = [NSString stringWithFormat:@"%i", model.isShareToBesides];
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    
    if (![model.videoModel.projectID isValidString]) {
        model.videoModel.projectID = @"0";
    }
    
    SAFE_SETOBJECT(params, model.videoModel.projectID, @"projectid");
    
    
    NSString *labelID = @"0";
    if (model.videoModel.labelModel.type == RemarkType_None) {
        labelID = @"0";
    }
    else
    {
        labelID = [NSString stringWithFormat:@"%i", model.videoModel.labelModel.labelId];
    }
    
    SAFE_SETOBJECT(params, labelID, @"label");
    SAFE_SETOBJECT(params, strShareToBesides, @"toBeside");
    SAFE_SETOBJECT(params, ([NSString stringWithFormat:@"%lld", model.videoModel.recordTime]), @"recordtime");
    SAFE_SETOBJECT(params, @"123123", @"bitrate");
    SAFE_SETOBJECT(params, strPixelw, @"pixelw");
    SAFE_SETOBJECT(params, strPixelh, @"pixelh");
    SAFE_SETOBJECT(params, strLength, @"length");
    SAFE_SETOBJECT(params, strByteNum, @"bytenum");
    
    SAFE_SETOBJECT(params, model.uploadModel.urlL, @"thumb_l_path");
    SAFE_SETOBJECT(params, model.uploadModel.urlM, @"thumb_m_path");
    SAFE_SETOBJECT(params, model.uploadModel.urlS, @"thumb_s_path");
    SAFE_SETOBJECT(params, model.uploadModel.urlVideo, @"video_path");
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params, model.videoModel.videoDes==nil?@"":model.videoModel.videoDes, @"description");
    
    [super asyncPost:@"api/v3/video/create" params:params];
}

// 生成html (model 含有图片和视频的已生成的url)
- (void)api_htmlCreated:(PostModel *)model
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *strPixelw = [NSString stringWithFormat:@"%i", model.videoModel.videoPixelW];
    NSString *strPixelh = [NSString stringWithFormat:@"%i", model.videoModel.videoPixelH];
    NSString *strLength = [NSString stringWithFormat:@"%i", (int)model.videoModel.videoLength];

    SAFE_SETOBJECT(params, ([NSString stringWithFormat:@"%lld", model.videoModel.recordTime]), @"recordtime");
    SAFE_SETOBJECT(params, @"123123", @"bitrate");
    SAFE_SETOBJECT(params, strPixelw, @"pixelw");
    SAFE_SETOBJECT(params, strPixelh, @"pixelh");
    SAFE_SETOBJECT(params, strLength, @"length");
    
    SAFE_SETOBJECT(params, model.uploadModel.urlL, @"thumb_l_path");
    SAFE_SETOBJECT(params, model.uploadModel.urlM, @"thumb_m_path");
    SAFE_SETOBJECT(params, model.uploadModel.urlS, @"thumb_s_path");
    SAFE_SETOBJECT(params, model.uploadModel.urlVideo, @"video_path");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncPost:@"api/v3/anonvideo/create" params:params];
}

// 上传视频
- (void)api_postUploadVideoFiles:(PostModel *)model {
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp3"];
    NSData *dataVideo = [NSData dataWithContentsOfFile:model.videoFilterUrl];
    
//    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"];
    NSData *dataImage = [NSData dataWithContentsOfFile:model.localImagePath];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
//     "projectid":日记ID ,
//     "url_thumb":视频截图url,
//     "url_thumb_s":视频缩略图url（小图）,
//     "url_thumb_m":视频缩略图url（大图）,
//     "url_video":视频url,
//     "status":视频状态(0正常,1审核中，2审核不通过,3删除状态)，
//     "recordtime":上传时间(long形的时间戳)，
//     "bitrate":视频比特率(kbps)
//     "pixelw":视频像素-宽，
//     "pixelh":视频像素-高，
//     "length":视频长度(单位秒)，
//     "currentday"：当前天数，
//     "ispraised":我是否赞过(0未赞过,1赞过),
//     "praisecounter":赞的总数，
//     "sharecounter":分享总数
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }
    
    NSString *strByteNum = [NSString stringWithFormat:@"%lu", (unsigned long)dataVideo.length];
    
    NSString *strPixelw = [NSString stringWithFormat:@"%i", model.videoModel.videoPixelW];
    NSString *strPixelh = [NSString stringWithFormat:@"%i", model.videoModel.videoPixelH];
    NSString *strLength = [NSString stringWithFormat:@"%i", (int)model.videoModel.videoLength];
    
    NSString *strShareToBesides = [NSString stringWithFormat:@"%i", model.isShareToBesides];
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    
    if (![model.videoModel.projectID isValidString]) {
        model.videoModel.projectID = @"0";
    }
    
    SAFE_SETOBJECT(params, model.videoModel.projectID, @"projectid");
    SAFE_SETOBJECT(params, strShareToBesides, @"toBeside");
    SAFE_SETOBJECT(params, ([NSString stringWithFormat:@"%lld", model.videoModel.recordTime]), @"recordtime");
    SAFE_SETOBJECT(params, @"123123", @"bitrate");
    SAFE_SETOBJECT(params, strPixelw, @"pixelw");
    SAFE_SETOBJECT(params, strPixelh, @"pixelh");
    SAFE_SETOBJECT(params, strLength, @"length");
    SAFE_SETOBJECT(params, strByteNum, @"bytenum");
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params, model.videoModel.videoDes==nil?@"":model.videoModel.videoDes, @"description");


    [super asyncPost:@"api/v2/video/create" withDataImage:dataImage dataVideo:dataVideo params:params];
}

// 注册
- (void)api_Register:(FetionUserInfo *)userInfo {
    
    CMDLOG;
    
    NSData *data = userInfo.dataPhoto;
    
    if (data == nil) {
        data = UIImagePNGRepresentation([UIImage imageNamed:@"user_head_default@2x.png"]);
    }
    
//    NSData *data = userInfo.dataPhoto;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, @"0", @"bindtype");
    
    
    SAFE_SETOBJECT(params, userInfo.fetionID, @"thirdid");
    SAFE_SETOBJECT(params, [userInfo.name URLDecodedString], @"username");
    
    if (![userInfo.fid isValidString]) {
        
        userInfo.fid = @"0"; // weiwei 规定的0
    }
    if (![userInfo.mobileNO isValidString]) {
        
        userInfo.mobileNO = @"0"; // weiwei 规定的0
    }

    SAFE_SETOBJECT(params, userInfo.fid, @"sid");
    SAFE_SETOBJECT(params, userInfo.mobileNO, @"mobileNo");
    
    SAFE_SETOBJECT(params, [AppSetting getDeviceID], @"deviceid");
    SAFE_SETOBJECT(params, @"0", @"channel");//渠道号，iOS只有一个渠道，默认为0，api设计此参数一定要传

    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.isAPIRegister = YES;
    
    [super asyncPost:@"api/v4/user/register" withDataImage:data dataVideo:nil params:params];
}


// 注册微信微博QQ
- (void)api_RegisterWithInfo:(LoginModel *)model
{
    CMDLOG;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.urlPhoto]];
    
    UIImage *image = [UIImage imageWithData:data];
    
    if (data == nil) {
        data = UIImagePNGRepresentation([UIImage imageNamed:@"user_head_default@2x.png"]);
    }
    
    if (![model.name isValidString]) {
        
        model.name = @"无名";
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    
    NSString *bindtype = @"";
    if (model.type == LoginType_QQ) {
        bindtype = @"1";
    }
    else if ((model.type == LoginType_Weixin))
    {
        bindtype = @"2";
    }
    else if ((model.type == LoginType_WeiBo))
    {
        bindtype = @"3";
    }
    else
    {
        assert(0);
    }
    
    SAFE_SETOBJECT(params, bindtype, @"bindtype");
    
    SAFE_SETOBJECT(params, model.ID, @"thirdid");
    SAFE_SETOBJECT(params, model.name, @"username");
    
    SAFE_SETOBJECT(params, [AppSetting getDeviceID], @"deviceid");
    SAFE_SETOBJECT(params, @"0", @"channel");//渠道号，iOS只有一个渠道，默认为0，api设计此参数一定要传
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.isAPIRegister = YES;
    
    [super asyncPost:@"api/v4/user/register" withDataImage:data dataVideo:nil params:params];
}


// 上传播放次数
- (void)api_UploadVideoPlayCount:(NSMutableArray *)jsonMarray
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, jsonMarray, @"data");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    NSData *dataJson = [params convertToJsonData];
    
    self.showNetErrToast = NO;
    [super asyncPost:@"api/video/playcounter" withJsonData:dataJson params:nil];
}


// 登录
- (void)api_Login:(NSString *)uID token:(NSString *)token
{    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    SAFE_SETOBJECT(params, token, @"token");
    SAFE_SETOBJECT(params, uID, @"uid");
    
    SAFE_SETOBJECT(params, [AppSetting getDeviceID], @"deviceid");
    SAFE_SETOBJECT(params, @"0", @"channel");//渠道号，iOS只有一个渠道，默认为0，api设计此参数一定要传

    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/login" params:params];
}

// 赞
- (void)api_Love:(NSString *)projectID andVideoID:(NSString *)videoID;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, projectID, @"projectid");
    SAFE_SETOBJECT(params, videoID, @"videoid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");

    [self asyncGet:@"api/video/praise" params:params];
}

// 取消赞
- (void)api_LoveCancel:(NSString *)projectID andVideoID:(NSString *)videoID;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, projectID, @"projectid");
    SAFE_SETOBJECT(params, videoID, @"videoid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");

    [self asyncGet:@"api/video/cancelpraise" params:params];
}

// 创建日记
- (void)api_CreateProject:(NSMutableDictionary *)projectInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
//    static int i = 1000;
//    ++i;
//    NSString *str = [NSString stringWithFormat:@"测试专用日记d%i", i];
    
    
    NSString *pjName = [projectInfo objectForKey:@"pjName"];
    NSString *dayNum = [projectInfo objectForKey:@"dayNum"];
    NSString *categoryId = [projectInfo objectForKey:@"categoryId"];
    NSString *privacyId = [projectInfo objectForKey:@"privacyId"];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, categoryId, @"typeid");
    SAFE_SETOBJECT(params, [pjName URLDecodedString], @"name");
    SAFE_SETOBJECT(params, dayNum, @"duration");
//    SAFE_SETOBJECT(params, [str URLDecodedString], @"desc");
    SAFE_SETOBJECT(params, privacyId, @"ispublic");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [self asyncGet:@"api/project/create" params:params];
}

// 删除日记
- (void)api_DeleteVideo:(NSString *)videoid andPjID:(NSString *)projectid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, projectid, @"projectid");
    SAFE_SETOBJECT(params, videoid, @"videoid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [self asyncGet:@"api/video/delete" params:params];
}

// 关注
- (void)api_Attention:(NSString *)userID
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

    NSString *uID = [AppSetting getUserID];
    if (uID == nil || [uID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
        return;
    }

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, uID, @"uid");
    SAFE_SETOBJECT(params, userID, @"concerneduid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    // 关注状态改变
    [GlobalData sharedInstance].isAttentionChanged = YES;
    
    [self asyncGet:@"api/v2/user/concern" params:params];

    [[FSStatistics defaultStatistics] setStatisticsClick:@"5001" tid:@"500100009"];

}

// 取消关注
- (void)api_AttentionCancel:(NSString *)friendID
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, friendID, @"concerneduid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    // 关注状态改变
    [GlobalData sharedInstance].isAttentionChanged = YES;
    
    [self asyncGet:@"api/user/cancelconcern" params:params];
}

// 我关注的列表
- (void)api_GetConcernProjectListPageNum:(int)pagenum andPageSize:(int)pagesize {

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/v2/project/list/byconcern" params:params];
}

//获取视频列表
- (void)api_GetVideoListWithPjId:(NSString *)pjId andFriendID:(NSString *)friendid andOffset:(NSString *)offset andPageSize:(int)pagesize{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }

    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, friendid, @"friendid");
    SAFE_SETOBJECT(params, pjId, @"projectid");
    SAFE_SETOBJECT(params, offset, @"offset");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/video/getlist" params:params];

}

//删除日记
- (void)api_DeletePjWithPjId:(NSString *)pjId {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }

    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, pjId, @"projectid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/project/remove" params:params];
}

// 获取新消息提醒
- (void)api_GetMessageNotification:(NSString *)userID
{
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"未登录，！！！！");
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.showNetErrToast = NO;
    [super asyncGet:@"api/v2/user/getnewmsgcount" params:params];
}

// 获取消息列表
- (void)api_GetMessageListType:(MessageListType)type offset:(NSString *)offset count:(NSString *)count;
{

    NSString *uID = [AppSetting getUserID];
    if (uID == nil || [uID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }

    NSString *category = @"";
    if (type == MessageList_Comment) {
        category = @"0";
    }else if (type == MessageList_Notification)
    {
        category = @"1";
    }
    else
    {
        assert(!@"错误的消息请求类型 。。。 ");
    }
        
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, uID, @"uid");
    SAFE_SETOBJECT(params, offset, @"offset");
    SAFE_SETOBJECT(params, category, @"category");
    SAFE_SETOBJECT(params, count, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/getmessagelist" params:params];
//    [super asyncGet:@"api/user/getmsglist" params:params];
}


// 清空消息列表
- (void)api_ClearMessageListType:(MessageListType)type
{
    NSString *uID = [AppSetting getUserID];
    if (uID == nil || [uID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }
    
    NSString *category = @"";
    
    if (type == MessageList_Notification) {
        category = @"1";
    }else if (type == MessageList_Comment)
    {
        category = @"0";
    }else
    {
        assert(!@"错误的清空消息类型 。。。 ");
    }
//    category	是	0	需要清除的消息类型(0表示清空评论，1表示清空通知)
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, uID, @"uid");
    SAFE_SETOBJECT(params, category, @"category");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/removeallmsg" params:params];
}

//删除消息
- (void)api_DeleteMessage:(NSString *)msgID {

    NSString *uID = [AppSetting getUserID];
    if (uID == nil || [uID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, uID, @"uid");
    SAFE_SETOBJECT(params, msgID, @"mid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/deletemsg" params:params];
}

//获取频道日记列表
- (void)api_GetChannelProjectList:(int)typeIndex andPageNum:(int)pagenum andPageSize:(int)pagesize
{
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
    }
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];
    NSString *typeIndexStr = [NSString stringWithFormat:@"%d",typeIndex];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, typeIndexStr, @"typeid");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/project/list/channel" params:params];
}

//获取热门推荐列表
- (void)api_GetProjectListByRecommondWithPageNum:(int)pagenum andPageSize:(int)pagesize
{
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }

    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, @"r", @"category");//h:最热日记 n:最新日记 r:推荐日记
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/v2/common/plist" params:params];
}

//搜索日记
- (void)api_SearchProjectList:(NSString *)keyword andPageNum:(int)pagenum andPageSize:(int)pagesize
{
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！");
    }
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, [keyword URLDecodedString], @"name");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/project/list/query" params:params];
}

//获取单个人日记列表
- (void)api_getProjectListByFriendid:(NSString *)friendid andPageNum:(int)pagenum andPageSize:(int)pagesize
{
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！");
    }
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    if (![friendid isEqualToString:userID]) {
        SAFE_SETOBJECT(params, friendid, @"friendid");//自己的主页 不传friendid
    }
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/v2/project/list/byuid" params:params];
}

//获取设置日记列表
//客户端通过该接口获取日记设置页面的日记列表，通过status判断是否为已完成还是进行中
//0未完成，1已经完成，2审核不通过，3被删除
- (void)api_getSettingProjectList:(NSString *)path
{
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/project/list/setting" params:params];
}

//意见反馈
- (void)api_FeedbackWithContent:(NSString *)content {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！");
    }
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, content, @"contents");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/suggest" params:params];
}

//修改个人简介
- (void)api_ModifyUserInfoWithContent:(NSString *)content {
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, content, @"info");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/setinfo" params:params];
}

//获取个人资料
- (void)api_GetUserInfoWithId:(NSString *)uID {
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, uID, @"fuid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/getinfo" params:params];

    
}

//修改日记设置
- (void)api_ModifyProjectInfoWithContent:(NSMutableDictionary *)projectInfo {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
//    static int i = 1000;
//    ++i;
//    NSString *str = [NSString stringWithFormat:@"测试专用日记d%i", i];
    
    
    NSString *projectId = [projectInfo objectForKey:@"projectId"];
    NSString *pjName = [projectInfo objectForKey:@"pjName"];
    NSString *durationNum = [projectInfo objectForKey:@"durationNum"];
    NSString *typeId = [projectInfo objectForKey:@"typeId"];
    NSString *privacyId = [projectInfo objectForKey:@"privacyId"];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
    }
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, projectId, @"projectid");
    SAFE_SETOBJECT(params, typeId, @"typeid");
    SAFE_SETOBJECT(params, pjName, @"name");
    SAFE_SETOBJECT(params, durationNum, @"duration");
//    SAFE_SETOBJECT(params, [str URLDecodedString], @"desc");
    SAFE_SETOBJECT(params, privacyId, @"ispublic");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [self asyncGet:@"api/project/update" params:params];
}

// 举报日记或者视频
- (void)api_ReportProjectOrVideo:(NSMutableDictionary *)reportContent {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *projectId = [reportContent objectForKey:@"projectId"];
    NSString *videoId = [reportContent objectForKey:@"videoId"];
    NSString *content = [reportContent objectForKey:@"content"];
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
    }
    
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, projectId, @"projectid");
    if (![videoId isEqualToString:@""]) {
        SAFE_SETOBJECT(params, videoId, @"videoid");
    }
    SAFE_SETOBJECT(params, content, @"content");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [self asyncGet:@"api/report" params:params];
}

// 上传分享记录
- (void)api_ShareCreate:(VideoModel *)model
{
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, model.userID, @"owner");
    SAFE_SETOBJECT(params, model.projectID, @"projectid");
    SAFE_SETOBJECT(params, model.videoID, @"videoid");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.showNetErrToast = NO;

    [super asyncGet:@"api/share/create" params:params];
}

/* 首次激活 和 每日启动次数
 deviceid	是	MD5值	设备UUID的MD5值(PS:我们假设每个UUID表示一个设备)
 type	是	1	1,第一次激活;2,每日启动
 */
- (void)api_UploadRunCounterWithType:(NSString *)type {

    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！！！");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, [AppSetting getDeviceID], @"deviceid");
    SAFE_SETOBJECT(params, type, @"type");
    SAFE_SETOBJECT(params, @"0", @"channel");//渠道号，iOS只有一个渠道，默认为0，api设计此参数一定要传
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.showNetErrToast = NO;
    
    [super asyncGet:@"api/v2/common/runcounter" params:params];
}

//获取我关注的人 列表
- (void)api_GetConcernAndFollowListPageNum:(int)pagenum
                               andPageSize:(int)pagesize
                                   andType:(int)type
                                 andUserid:(NSString *)userID {

    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, typeStr, @"type");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/list/concerncells" params:params];
}

// 搜索日记 1.1.0
- (void)api_SearchProject:(NSString *)keyword
               andPageNum:(int)pagenum
              andPageSize:(int)pagesize {
    
    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！");
    }
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, [keyword URLDecodedString], @"name");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/project/list/search" params:params];
}

// 搜索用户
- (void)api_SearchUser:(NSString *)keyword
             andPageNum:(int)pagenum
            andPageSize:(int)pagesize {

    NSString *userID = [AppSetting getUserID];
    if (userID == nil || [userID isEqualToString:@""]) {
        
        NSLog(@"不存在的userID，！！！");
    }
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pagesize];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, TOKEN, @"token");
    SAFE_SETOBJECT(params, userID, @"uid");
    SAFE_SETOBJECT(params, [keyword URLDecodedString], @"name");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/user/list/search" params:params];
}


// 获取资源列表
- (void) api_getResourceList:(NSArray*) categorys
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    
    NSMutableString* strCategorys = [[NSMutableString alloc] initWithCapacity:50];
    if (categorys.count > 0) {
        
        [strCategorys appendString:@"["];
        
        for (NSDictionary* dic in categorys) {
            NSNumber* categoryid = [dic objectForKey:@"id"];
            NSNumber* version = [dic objectForKey:@"version"];

            [strCategorys appendFormat:@"{\"category\":%d,\"version\":%d},",categoryid.intValue ,version.intValue];
        }
        [strCategorys replaceCharactersInRange:NSMakeRange(strCategorys.length - 1, 1) withString:@"]"];
    }
    else
    {
        [strCategorys appendString:@"[]"];
    }

    SAFE_SETOBJECT(params, strCategorys, @"categorys");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    strCategorys = nil;
    
    self.showNetErrToast = NO;
    [super asyncGet:@"api/resource/list" params:params];
}

//获取资源Zip包
- (void) api_downloadResourcezipFile:(NSString*) resourceId
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, resourceId, @"id");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.showNetErrToast = NO;
    [super asyncGet:@"api/resource/get" params:params];
}

// 获取首页背景图片
- (void) api_updateMainPage
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    self.showNetErrToast = NO;
    [super asyncGet:@"api/getpicture" params:params];
}

// 获取标签和活动列表
- (void) api_GetLabelAndActivityList{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/label/get" params:params];
}


// 获取正在进行的活动列表,
- (void) api_GetUnderwayActivityList{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncGet:@"api/activity/getunderway" params:params];
}

// 获取已经结束的活动列表
- (void) api_GetFinishedActivityListWithPageNum:(int)pagenum andPageSize:(int)pageSize{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pageSize];
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params, pageNumStr ,@"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    
    [super asyncGet:@"api/activity/getfinish" params:params];
}


// 获取活动详情
- (void) api_GetActivityDetailWithId:(int)activityId{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *idStr = [NSString stringWithFormat:@"%d",activityId];
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params, idStr ,@"id");
    
    [super asyncGet:@"api/activity/getdetails" params:params];
    
}

// 请求发送短信密码接口
- (void) api_GetSMSPassword:(NSString *)phoneNum
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    SAFE_SETOBJECT(params, phoneNum ,@"mobile");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncPost:@"api/smspwd/send" params:params];
}

// 短信密码验证接口
- (void) api_LoginWithPhoneNum:(NSString *)phoneNum smsVerifyCode:(NSString *)code
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    SAFE_SETOBJECT(params, phoneNum ,@"mobile");
    SAFE_SETOBJECT(params, code ,@"smspwd");
    SAFE_SETOBJECT(params, [AppSetting getDeviceID], @"deviceid");
    SAFE_SETOBJECT(params, @"0", @"channel");
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    
    [super asyncPost:@"api/smspwd/verify" params:params];
}

// 获取活动视频列表
- (void) api_GetActivityVideoListWithId:(int)activityId andPageNum:(int)pagenum andPageSize:(int)pageSize{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *idStr = [NSString stringWithFormat:@"%d",activityId];
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pageSize];
    
    if ([AppSetting isLogin]) {
        
        SAFE_SETOBJECT(params, [AppSetting getUserID], @"uid");
        SAFE_SETOBJECT(params, TOKEN, @"token");
    }
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params, idStr, @"id");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    
    [super asyncGet:@"api/activity/list/getvideos" params:params];
    
}

// 获取发现页最新视频列表
- (void) api_GetTheNewestViedoListWithPageNum:(int)pagenum andPageSize:(int)pageSize{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *pageNumStr = [NSString stringWithFormat:@"%d",pagenum];
    NSString *pageSizeStr = [NSString stringWithFormat:@"%d",pageSize];
    
    if ([AppSetting isLogin]) {
        
        SAFE_SETOBJECT(params, [AppSetting getUserID], @"uid");
        SAFE_SETOBJECT(params, TOKEN, @"token");
    }
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params, pageNumStr, @"pagenum");
    SAFE_SETOBJECT(params, pageSizeStr, @"pagesize");
    
    [super asyncGet:@"api/new/plist" params:params];
}

//服务器状态查询接口
- (void) api_getServerStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    self.showNetErrToast = NO;

    [super asyncGet:@"api/server/status" params:params];
}

// 获取视频信息查询接口
- (void) api_getVideoDetailWithVideoId:(NSString *)videoId{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    
    if ([AppSetting isLogin]) {
        
        SAFE_SETOBJECT(params, [AppSetting getUserID], @"uid");
        SAFE_SETOBJECT(params, TOKEN, @"token");
    }
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params,videoId ,@"videoid");
    
    [super asyncPost:@"api/video/detail" params:params];
}

// 发布视频评论
- (void) api_releaseVideoCommentWithVideoId:(NSString *)videoId replyTo:(NSString *)replyTo comment:(NSString *)comment{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([AppSetting isLogin]) {
        
        SAFE_SETOBJECT(params, [AppSetting getUserID], @"uid");
        SAFE_SETOBJECT(params, TOKEN, @"token");
    }
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params,videoId ,@"videoid");
    SAFE_SETOBJECT(params, replyTo, @"replyto");
    SAFE_SETOBJECT(params, comment, @"comment");
    
    [super asyncPost:@"api/videocomment/create" params:params];
    
}

// 删除视频评论
- (void) api_deleteVideoCommentWithCommentId:(NSString *)commentId{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([AppSetting isLogin]) {
        
        SAFE_SETOBJECT(params, [AppSetting getUserID], @"uid");
        SAFE_SETOBJECT(params, TOKEN, @"token");
    }
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params,commentId ,@"commentid");
    
    [super asyncGet:@"api/videocomment/delete" params:params];
}

// 视频评论时间轴双向分页查询接口
- (void) api_getVideoCommentListWithVideoId:(NSString *)videoId offsetCommentid:(NSString *)offsetCommentid andSize:(NSString *)size{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([AppSetting isLogin]) {
        
        SAFE_SETOBJECT(params, [AppSetting getUserID], @"uid");
        SAFE_SETOBJECT(params, TOKEN, @"token");
    }
    
    SAFE_SETOBJECT(params, CURRENT_PLATFORM, @"clienttype");
    SAFE_SETOBJECT(params, [AppSetting getAppVersionCurrent], @"version");
    SAFE_SETOBJECT(params,offsetCommentid ,@"offsetcommentid");
    SAFE_SETOBJECT(params, videoId, @"videoid");
    SAFE_SETOBJECT(params, size , @"size");
    
    [super asyncGet:@"api/videocomment/list" params:params];
}


@end
