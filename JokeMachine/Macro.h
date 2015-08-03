//
//  Macro.h
//  Giveit100
//
//  Created by 蔡建海 on 14-3-13.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//


// 宏定义

#ifndef Giveit100_Macro_h
#define Giveit100_Macro_h

#pragma mark - QQ

#define QQAppID         @"1103477868"
#define QQAppKey         @"gD02jNT1B03odkys"
//#define QQRedirectURI    @"https://api.weibo.com/oauth2/default.html"


//https://itunes.apple.com/cn/app/fei-xin-shi-pin/id866942633?mt=8
// 可通过[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wb185845417://cn.10086.i.giveit100"]];
//来判断用户机器中是否安装了该程序

#pragma mark - 新浪微博分享
// 新浪微博Oauth 2.0 相关

// cn.10086.i.giveit100
// bound di和 kAppKey 要与开放平台的一致， 如修改，也要修改info.plist URL Types 类型中参数。
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"

// 发布微博（带图片） http://open.weibo.com/wiki/2/statuses/upload
/*
请求参数

必选	类型及范围	说明
source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
list_id	false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
lat	false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
long	false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。*/


// 发布微博（不带图片） http://open.weibo.com/wiki/2/statuses/update
/*
 请求参数
 
 必选	类型及范围	说明
 source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 list_id	false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 lat	false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 long	false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。*/

/*
users/show
根据用户ID获取用户信息
URL
https://api.weibo.com/2/users/show.json
支持格式
JSON
HTTP请求方式
GET
是否需要登录
是
关于登录授权，参见 如何登录授权
访问授权限制
访问级别：普通接口
频次限制：是
关于频次限制，参见 接口访问权限说明
请求参数

必选	类型及范围	说明
source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
uid	false	int64	需要查询的用户ID。
screen_name	false	string	需要查询的用户昵称。
注意事项

参数uid与screen_name二者必选其一，且只能选其一
*/

#define APISinaUploadWithPic    @"https://upload.api.weibo.com/2/statuses/upload.json"   // 分享带图片
#define APISinaUpload           @"https://api.weibo.com/2/statuses/update.json"                 // 分享不带图片
#define APISinaUserInfo         @"https://api.weibo.com/2/users/show.json"                     // 获取用户信息

#define APISinaRequestTag_UploadText    @"APISinaRequestTag_UploadText"                     // 分享不带图片
#define APISinaRequestTag_UploadImage   @"APISinaRequestTag_UploadImage"                    // 分享带图片
#define APISinaRequestTag_UserInfo      @"APISinaRequestTag_UserInfo"                       // 获取用户信息
#define APISinaRequestTag_Logout        @"APISinaRequestTag_Logout"                         // 注销

//#define POST @"POST"
//#define GET @"GET"

#pragma mark - 微信分享

#define WEIXINAPPID     @"wxf56cfe168533ffb2"
#define WEIXINAPPSECRET @"cfb28643c745b7caa04ff317719226db"


#define NOTIFICATION_REQUEST_SSO_SUCCEED    @"NOTIFICATION_REQUEST_SSO_SUCCEED"
#define NOTIFICATION_REQUEST_SSO_FAILED     @"NOTIFICATION_REQUEST_SSO_FAILED"
#define NOTIFICATION_REQUEST_SHARE_SUCCEED  @"NOTIFICATION_REQUEST_SHARE_SUCCEED"
#define NOTIFICATION_REQUEST_SHARE_FAILID   @"NOTIFICATION_REQUEST_SHARE_FAILID"




#pragma mark - 飞信分享

#define FetionAppID               @"FS7ee8bd-ab74-4891-913a-b613779effe0"
#define FetionAppKey              @"634d9cc9-65d6-45f9-bb95-7550c7612553"



#define FetionShare               @"shareXXXXXX"
#define FetionToken               @"tokenkenken"


#pragma mark - Other

#define UploadTotalByteWritten          @"totalBytesWritten"
#define UploadTotalBytesExpectedToWrite @"totalBytesExpectedToWrite"
#define UploadResponseObject            @"responseObject"

// 上传数据失败
#define NotificationUploadDataError         @"NotificationUploadDataError"
//#define NotificationUploadJsonError @""
// 上传进度
#define NotificationUploadVideoProgress     @"NotificationUploadVideoProgress"
// 上传开始
#define NotificationUploadVideoBegin       @"NotificationUploadVideoBegin"
// 上传成功
#define NotificationUploadVideoSucess       @"NotificationUploadVideoSucess"
// 上传取消
#define NotificationUploadVideoCancel       @"NotificationUploadVideoCancel"
// 上传取消 注销
#define NotificationUploadVideoCancelWhenLogout       @"NotificationUploadVideoCancelWhenLogout"

// 新消息通知
#define NotificationMessageReceived         @"NotificationMessageReceived"

// web授权成功登录成功通知
#define NotificationWebPageSSOSucceed         @"NotificationWebPageSSOSucceed"

// 注册登录成功通知
#define NotificationRegisterOrLoginSucceed         @"NotificationRegisterOrLoginSucceed"
// 注册成功 for 更新头像 通知
#define NotificationRegisterSucceedForRefreshPhoto         @"NotificationRegisterSucceedForRefreshPhoto"


// 新消息通知
#define MSG_INTERVAL                 120.f
#define Max_Draft_Count              20    // 草稿箱最大数量20， 在有不添加
#define Max_SearchHistory_Count      20     // 搜索历史最大数量20 添加删除最前一个

#define TOKEN_TIMELEFT 60*60*24

// 有草稿箱保存的通知
#define NotificationDraftBoxStatusChanged         @"NotificationDraftBoxStatusChanged"

// 发布日记回到个人主页通知
#define NotificationShowMineViewController         @"NotificationShowMineViewController"

// 退出登录后 登录成功 进【我关注的】 通知
#define NotificationShowFollowViewController         @"NotificationShowFollowViewController"
// 【我关注的】没有日记，点击“发现”进入【发现】页面 通知
#define NotificationShowFindViewController         @"NotificationShowFindViewController"
//退出登录 回到登录页面 通知
#define NotificationShowLoginVCAfterLogout         @"NotificationShowLoginVCAfterLogout"

// 清理缓存 通知
#define NotificationReleaseVCWhenClearCache         @"NotificationReleaseVCWhenClearCache"

//退出登录 成功
#define NotificationLogoutTokenSucceed         @"NotificationLogoutTokenSucceed"

//退出登录 失败
#define NotificationLogoutTokenFailed        @"NotificationLogoutTokenFailed"

// token失效，过期，重新登录 去登录页面
#define NotificationTokenInvalidToLoginVC        @"NotificationTokenInvalidToLoginVC"

#define NotificationRefreshTokenSucceed      @"NotificationRefreshTokenSucceed"
#define NotificationRefreshTokenFailed       @"NotificationRefreshTokenFailed"

//
#define NOTIFICATIONVIDEOCELLAPIRESULT       @"NOTIFICATIONVIDEOCELLAPIRESULT"

// 通知评论结果
#define NOTIFICATION_COMMENT_RESULT         @"NOTIFICATION_COMMENT_RESULT"

// 关注和粉丝列表里关注和取消关注 返回结果通知
#define NotificationFriendVCFollowAndUnfollowApiResult       @"NotificationFriendVCFollowAndUnfollowApiResult"

// 创建日记成功，直接跳至发布页
#define NotificationCreateDiarySucceedToPostView   @"NotificationCreateDiarySucceedToPostView"


#define NotificationHomePageAttentionSucess  @"NotificationHomePageAttentionSucess"
#define NotificationHomePageCancelAttentionSucess  @"NotificationHomePageCancelAttentionSucess"

#define NFDismissAllPresentedController  @"NotificationDismissAllPresentedController"

// “参与活动”通知
#define NotificationJoinActiviy  @"NotificationJoinActiviyByFind"

typedef enum {
    
    ProjectListType_None,  //
    ProjectListType_Search, // 搜索列表
    ProjectListType_Category,// 种类
    ProjectListType_HotOrLatest,// 最新 最热
    
}ProjectListType;  // 搜索类型tag


typedef enum {
    
    AttentionType_None,  //
    AttentionType_NO, // 未关注
    AttentionType_YES,// 己关注
    AttentionType_Together,// 互相关注
    AttentionType_MySelf,// 我自己
    
}AttentionType;  // 关注tag

typedef enum {
    
    MessageType_None,  //
    MessageType_Love, // 赞
    MessageType_Attention,// 关注
    MessageType_Comment,// 评论视频
    MessageType_Replay,// 回复
    MessageType_Delete,// 已删除
    MessageType_xxx,//
    
}MessageType;  // 消息关注类型


typedef enum {
    
    MessageList_None,  //
    MessageList_Notification, // 通知
    MessageList_Comment,// 评论
    MessageListType_xxx,//
    
}MessageListType;  // 消息列表类型

typedef enum {
    
    VideoCellAPIResult_None = 100,  //
    VideoCellAPIResult_Praise, // 赞
    VideoCellAPIResult_UnPraise, // 取消赞
    VideoCellAPIResult_Follow,// 关注
    VideoCellAPIResult_UnFollow,// 关注
    VideoCellAPIResult_Delete,// 删除
    PjDetailCellAPIResult_Delete,// 删除 日记详情页
    
}VideoCellAPIResultType;  // API Tag

typedef enum {
    
    APIErrorType_None = 100,  //
    APIErrorType_Net, // 无网
    APIErrorType_Service, //服务的错误
    
}APIErrorType;  // API Tag


typedef enum{
    
    ListCellActionSheetTagNil = 0,
    ListCellActionSheetTagShare,  //分享
    ListCellActionSheetTagReport, //举报
    ListCellActionSheetTagDelete, //删除
    
}ListCellActionSheetTag;


typedef enum{
    
    ButtonFoldStatus_None = 100,
    ButtonFoldStatus_Hidden,  //隐藏
    ButtonFoldStatus_Open, // open
    ButtonFoldStatus_Close, // close
    
}ButtonFoldStatusType;


// 滤镜分类
typedef enum{
    
    VideoFilterType_None = 100, // 没有滤镜
    VideoFilterType_1,  //
    VideoFilterType_2,  //
    VideoFilterType_3,  //
    VideoFilterType_4,  //
    VideoFilterType_5,  //
    VideoFilterType_6,  //
    VideoFilterType_7,  //
    VideoFilterType_8,  //
    VideoFilterType_9,  //
    
}VideoFilterType;


// 标签
typedef enum{
    
    MineViewShowType_None = 100, // 没有标签
    MineViewShowType_Mine,  //  我的
    MineViewShowType_MyAttention,  // 我关注的
    
}MineViewShowType;


// 上传状态
typedef enum{
    
    UploadStatusType_None = 0, // 没有标签
    UploadStatusType_Uploading,  //  正在上传
    UploadStatusType_Fail,  //  失败
    UploadStatusType_Success,  // 成功
    
}UploadStatusType;

// 上传状态(视频文件拆分)
typedef enum{
    
    UploadType_None = 0, // 没有标签
    UploadType_FileUploadSucceed,  //  文件流上传成功 （避免发布和匿名发布的重复上传）
    UploadType_FileAnonSucceed,    //  匿名文件发布成功 （避免匿名发布的重复上传）
    UploadType_Success,  // 成功
    
}UploadType;

//        _labelFailText.text = @"发布失败，日记已完成";
//    }
//    // 发布失败，日记已删除
//    else if(errorCode == 207)
//    {
//        _labelFailText.text = @"发布失败，日记已删除";
//    }
//    // 发布失败，今日已上传
//    else if(errorCode == 214)
//    {
//        _labelFailText.text = @"发布失败，今日已上传";
//    }
//    else
//    {
//        _labelFailText.text = @"发布失败，已存草稿";

// 上传失败code
typedef enum
{
    FailedUploadType_None, //
    FailedUploadType_Finished,  // 发布失败，日记已完成
    FailedUploadType_Deleted,   // 发布失败，日记已删除
    FailedUploadType_Uploaded,  // 发布失败，今日已上传
    FailedUploadType_Failed,    // 失败
} FailedUploadType;


// 空图
typedef enum{
    
    EmptyViewType_None = 0, //
    EmptyViewType_MyVideo,  // 我的视频
    EmptyViewType_MyAttention,  // 我关注的
    EmptyViewType_MyVideoNoLogin,  // 我的视频未登录
    EmptyViewType_MyAttentionNoLogin,  // 我关注的 未登录
    EmptyViewType_OtherPage,  // 客态页空页面
    EmptyViewType_xxx,  //
    
}EmptyViewType;

// 空图
typedef enum{
    
    RemarkType_None= 0,  //
    RemarkType_Label,  // 标签
    RemarkType_Activitity,  // 活动
    
} RemarkType;

typedef enum{
    FindType_HotVideo = 0,
    FindType_NewVideo,
    
} FindType;

// 上传数据类型
typedef enum{
    
    UploadDataType_None = 0, //
    UploadDataType_Share,   // 分享给好友
    UploadDataType_Post,    // 发布
    UploadDataType_XXX,     //
    
} UploadDataType;

// 登录类型
typedef enum {
    
    LoginType_None = 0, // 未登录
    LoginType_Fetion,   // 飞信登录
    LoginType_Phone,    // 手机登录
    LoginType_WeiBo,    // 微博登录
    LoginType_QQ,       // QQ登录
    LoginType_Weixin,   // 微信登录
    LoginType_xxx,
    
}LoginType;


// 验证码按钮状态
typedef enum {
    
    VerifyCodeType_None = 0, // 发送验证码状态
    VerifyCodeType_Timer,     // 定时读秒状态
    VerifyCodeType_Retry,     // 重试
    VerifyCodeType_xxx,
    
}VerifyCodeType;

//原因: 因为播放页需要确定webview的来源, 所以要求客户端在分享的时候就在播放页地址后附带一个名为shareto的URL查询参数
//1001 飞信
//1002 微博
//1003 微信
//1004 朋友圈
//1005 身边
//1006 QQ
//1007 QQ空间
//例如: 把视频分享到微信, {播放页地址}?shareto=1003// 验证码按钮状态
typedef enum {
    
    ShareType_None = 1000,  // 发送验证码状态
    ShareType_Fetion,       //1001 飞信
    ShareType_Weibo,        //1002 微博
    ShareType_Weixin,       //1003 微信
    ShareType_WeiXinFriend, //1004 朋友圈
    ShareType_Besides,      //1005 身边
    ShareType_QQ,           //1006 QQ
    ShareType_QZone,        //1007 QQ空间
    ShareType_xxx,          //
}ShareType;

// 视频列表类型
typedef enum {
    
    VideoListCategoryNone = 0,         //None
    VideoListCategoryRecommand,        //推荐(热门)
    VideoListCategoryNew,              //最新
    
    VideoListCategoryActivity,      //活动视频列表
    
}VideoListCategory;


#endif
