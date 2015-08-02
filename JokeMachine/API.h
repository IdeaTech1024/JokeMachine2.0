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
- (void)api_postUploadVideoFiles:(PostModel *)model;

// 上传 (model 含有本地图片和视频的路径)
- (void)api_fileUpload:(PostModel *)model;

// 发布 (model 含有图片和视频的已生成的url)
- (void)api_postVideoInfo:(PostModel *)model;

// 生成html (model 含有图片和视频的已生成的url)
- (void)api_htmlCreated:(PostModel *)model;

// 注册飞信
- (void)api_Register:(FetionUserInfo *)userInfo;

// 注册微信微博QQ
- (void)api_RegisterWithInfo:(LoginModel *)model;

// 上传播放次数
//data:[
//      {videoid:123,playcounter:6},
//      {videoid:456,playcounter:2},
//{videoid:546,playcounter:23}
//      ]
- (void)api_UploadVideoPlayCount:(NSMutableArray *)jsonMarray;

// 登录 刷新token的时候，要使用新获得的token，登录成功在保存token。
- (void)api_Login:(NSString *)uID token:(NSString *)token;

// 赞
- (void)api_Love:(NSString *)projectID andVideoID:(NSString *)videoID;

// 取消赞
- (void)api_LoveCancel:(NSString *)projectID andVideoID:(NSString *)videoID;

// 创建日记
- (void)api_CreateProject:(NSMutableDictionary *)projectInfo;

//删除日记
- (void)api_DeletePjWithPjId:(NSString *)pjId;

// 删除视频
- (void)api_DeleteVideo:(NSString *)videoid andPjID:(NSString *)projectid;

// 关注
- (void)api_Attention:(NSString *)userID;

// 取消关注
- (void)api_AttentionCancel:(NSString *)friendID;

//获取视频列表 - 日记详情
- (void)api_GetVideoListWithPjId:(NSString *)pjId
                     andFriendID:(NSString *)friendid
                       andOffset:(NSString *)offset
                     andPageSize:(int)pagesize;


// 获取新消息提醒
- (void)api_GetMessageNotification:(NSString *)userID;

// 获取消息列表
- (void)api_GetMessageListType:(MessageListType)type offset:(NSString *)offset count:(NSString *)count;

// 清空消息列表
- (void)api_ClearMessageListType:(MessageListType)type;

// 删除消息
- (void)api_DeleteMessage:(NSString *)msgID;

//获取我关注的列表
- (void)api_GetConcernProjectListPageNum:(int)pagenum
                             andPageSize:(int)pagesize;

//获取频道日记列表
- (void)api_GetChannelProjectList:(int)typeIndex
                        andPageNum:(int)pagenum
                      andPageSize:(int)pagesize;

//获取日记列表 里面有三个视频 //category = h:最热日记 n:最新日记 r:推荐日记
- (void)api_GetProjectListByRecommondWithPageNum:(int)pagenum
                         andPageSize:(int)pagesize;

//搜索日记列表
- (void)api_SearchProjectList:(NSString *)keyword
                    andPageNum:(int)pagenum
                  andPageSize:(int)pagesize;

//获取单个人日记列表 - 客态页
- (void)api_getProjectListByFriendid:(NSString *)friendid
                           andPageNum:(int)pagenum
                         andPageSize:(int)pagesize;

//获取设置日记列表
- (void)api_getSettingProjectList:(NSString *)path;

//意见反馈
- (void)api_FeedbackWithContent:(NSString *)content;

//修改个人简介
- (void)api_ModifyUserInfoWithContent:(NSString *)content;

//获取个人资料
- (void)api_GetUserInfoWithId:(NSString *)uID;

//修改日记设置
- (void)api_ModifyProjectInfoWithContent:(NSMutableDictionary *)projectInfo;

// 举报日记或者视频
- (void)api_ReportProjectOrVideo:(NSMutableDictionary *)reportContent;

// 上传分享记录
- (void)api_ShareCreate:(VideoModel *)model;

/* 首次激活 和 每日启动次数
 deviceid	是	MD5值	设备UUID的MD5值(PS:我们假设每个UUID表示一个设备)
 type	是	1	1,第一次激活;2,每日启动
 */
- (void)api_UploadRunCounterWithType:(NSString *)type;


// 1.1.0

//获取 关注和粉丝 列表 type:0=关注，1=粉丝。
- (void)api_GetConcernAndFollowListPageNum:(int)pagenum
                               andPageSize:(int)pagesize
                                   andType:(int)type
                                 andUserid:(NSString *)userID;


// 搜索日记
- (void)api_SearchProject:(NSString *)keyword
               andPageNum:(int)pagenum
              andPageSize:(int)pagesize;

// 搜索用户
- (void)api_SearchUser:(NSString *)keyword
            andPageNum:(int)pagenum
           andPageSize:(int)pagesize;

// 获取资源列表
- (void) api_getResourceList:(NSArray*) categorys;

//获取资源Zip包
- (void) api_downloadResourcezipFile:(NSString*) resourceId;

// 获取首页背景图片
- (void) api_updateMainPage;

// 获取标签和活动列表
- (void) api_GetLabelAndActivityList;

// 获取正在进行的活动列表
- (void) api_GetUnderwayActivityList;

// 获取已经结束的活动列表
- (void) api_GetFinishedActivityListWithPageNum:(int)pagenum andPageSize:(int)pageSize;

// 获取活动详情
- (void) api_GetActivityDetailWithId:(int)activityId;

// 请求发送短信密码接口
- (void) api_GetSMSPassword:(NSString *)phoneNum;
// 获取活动视频列表
- (void) api_GetActivityVideoListWithId:(int)activityId andPageNum:(int)pagenum andPageSize:(int)pageSize;

// 短信密码验证接口
- (void) api_LoginWithPhoneNum:(NSString *)phoneNum smsVerifyCode:(NSString *)code;

// 获取发现页最新视频列表
- (void) api_GetTheNewestViedoListWithPageNum:(int)pagenum andPageSize:(int)pageSize;

//服务器状态查询接口
- (void) api_getServerStatus;

// 获取视频信息查询接口
- (void) api_getVideoDetailWithVideoId:(NSString *)videoId;

// 发布视频评论
- (void) api_releaseVideoCommentWithVideoId:(NSString *)videoId replyTo:(NSString *)replyTo comment:(NSString *)comment;

// 删除视频评论
- (void) api_deleteVideoCommentWithCommentId:(NSString *)commentId;

// 视频评论时间轴双向分页查询接口
- (void) api_getVideoCommentListWithVideoId:(NSString *)videoId offsetCommentid:(NSString *)offsetCommentid andSize:(NSString *)size;


@end
