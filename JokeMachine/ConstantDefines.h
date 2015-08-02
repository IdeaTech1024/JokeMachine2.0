//
//  ConstantDefines.h
//  Giveit100
//
//  Created by ytb on 14-3-6.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#ifndef Giveit100_ConstantDefines_h
#define Giveit100_ConstantDefines_h

#import "AppDelegate.h"

// 测试公共账号  18701511643     790624

/*
 when define APPSTORE_RELEASE, the bundle id is cn.10086.fetion.video, release to appstore, otherwise inhouse release, the bundle id need to be set to com.feinno.fetion.video.
 */

//#define APPSTORE_RELEASE


/*
   when define use_test_environment,is test environment
 */
//#define USE_TEST_ENVIRONMENT


/*
 新浪微博的key,APPSTORE_RELEASE bundle id 对应的 key @"2143829714"
 */
#ifdef APPSTORE_RELEASE

#define kAppKey         @"2143829714"

#else 

#define kAppKey         @"2599097291"

#endif


#ifdef DEBUG
#define IS_DEV_VERSION 1
#define IS_DEBUG_FOR_SINA_SHARE YES
#else
#define IS_DEV_VERSION 0
#define IS_DEBUG_FOR_SINA_SHARE NO
#endif

#ifdef USE_TEST_ENVIRONMENT
//#define BASE_URL @"http://10.10.70.102:8080/snsvideo/"              //李芮的电脑  内网
//#define BASE_URL @"http://10.10.70.103:8080/snsvideo/"              //魏伟的电脑  内网
//#define BASE_URL @"http://192.168.251.122:8999/snsvideo/"           //测试环境   限内网访问
#define BASE_URL @"http://221.179.173.101:8999/snsvideo/"           //测试环境   外网可访问
#else
#define BASE_URL @"http://221.176.31.206/snsvideo/"       //线上
#endif

// 使用日志
#ifdef DEBUG
//#define NSLog(var, ...) NSLog((var),## __VA_ARGS__)
#define NSLog(var,...)     NSLog((@"%s(%d):" var),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#define CMDLOG     NSLog(@"%@", NSStringFromSelector(_cmd) )

#else
#define NSLog(var, ...)
#define CMDLOG
#endif



// 网络连接
#define TIMEOUT_INTERVAL_WIFI 20.0f
#define TIMEOUT_INTERVAL_GPRS 30.0f

// 参数
#define VIDEO_WIDTH         480        //分辨率
#define VIDEO_LENGHT_MIN    4.0f       //最小时长
#define VIDEO_LENGHT_MAX    10.0f      //最大时长

#define RefreshIconOrigionY (-20)
#define VerifyCodeSeconds   60.0       // 获取验证码间隔


// 默认提示语
#define WeiboDefautText_Mine @"我拍了个视频，大家来捧场啊！"
#define WeiboDefautText_Others @"这个视频很好看，大家来围观呀！"
#define NetNotInService @"服务器开小差了"

// app相关
#define APP_VERSION_SAVED @"AppVersionSaved" //保存当前版本号，用来判断是不是最新安装的应用
#define APP_ID @"866942633" //appid 检查更新和下载新版本时用到

//#define HIDE_NET_NOT_IN_SERVERCE

//iOS系统
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define IS_IPAD [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_RETINA [UIScreen instancesRespondToSelector:@selector(scale)]
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define HORIZONTAL_OFFSET   (SCREEN_WIDTH - 320)/2  //水平偏移量，适配iphone6,6+使用
#define VERTICAL_OFFSET  (SCREEN_HEIGHT -480)/2     //垂直偏移量，适配iphone6,6+使用
#define PORTRAIT_NAVIGATIONBAR_HEIGHT 64.0F

// 6 puls 分辨率下屏幕的真实高度（只提供了……6 plus的标注，得到通用的高度。4 5 6 通用，不涉及适配）
#define HEIGHT_6_PLUS(a) (((a)*414.0f)/1080.0f)

// 适配宽度和高度（以iPhone4为基底）
#define ADAPT_X_Y(x) (x*(SCREEN_WIDTH/320.0f))

// 适配比例
#define  ADAPT_RATIO (SCREEN_WIDTH/320.0f)
#define ADJUST_ADAPT(x) (x=ADAPT_RATIO*x)


// 获取当前设备的分辨率 格式：960X640
#define CURRENT_SCREEN [NSString stringWithFormat:@"%dX%d",(int)([[UIScreen mainScreen]bounds].size.height*([UIScreen mainScreen].scale)),(int)([[UIScreen mainScreen]bounds].size.width*([UIScreen  mainScreen].scale))]
#define CURRENT_PLATFORM @"16" //当前平台 iOS=16,Android=15

//颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:(a)]
#define RGBCLEAR [UIColor clearColor]

// 蓝色
#define APP_COLOR_BLUE RGBCOLOR(120, 135, 243)


// 整体风格颜色 (导航 一些label和button字体)
#define APP_NAVI_COLOR                    RGBACOLOR(246, 246, 246, 1.0)   //导航条色 灰白色
#define APP_STYLE_COLOR                   RGBACOLOR(239, 103, 62, 1.0)    //整体风格 桔红色
#define APP_STYLE_COLOR_20                   RGBACOLOR(251, 91, 166, 1.0)    //2.0整体风格 粉红色
#define APP_FONT_BLACK_COLOR              RGBACOLOR(51, 51, 51, 1.0)      //字体颜色 黑色
#define APP_FONT_GREEN_COLOR              RGBACOLOR(0, 188, 132, 1.0)     //字体颜色 绿色
// 所有页面的背景色统一设置
#define APP_VC_BG_COLOR     RGBCOLOR(228, 230, 233)
//创建日记页面背景颜色
#define CreatePj_Bg_COLOR     RGBACOLOR(229, 229, 229, 1.0)
//日记名称字体颜色
#define Pj_Font_COLOR     RGBACOLOR(88, 95, 105, 1.0)
//cell的左边title字体颜色
#define CellLeftTitle_Font_COLOR     RGBACOLOR(32, 38, 38, 1.0)
//cell的分割线颜色
#define Cell_Separator_COLOR     RGBCOLOR(221, 222, 224)
//cell的右边title字体颜色
#define CellRightTitle_Font_COLOR     RGBACOLOR(107, 113, 121, 1.0)
//placeholder的默认字体颜色
#define PlaceHolder_Font_COLOR     RGBCOLOR(187, 187, 187)

#define Color_ProjectDetail_Progress RGBACOLOR(228, 142, 221, 1.0)
#define Color_ProjectDetail_BG RGBACOLOR(140, 140, 140, 1.0)

#define Cell_Header_Color RGBCOLOR(156, 158, 162)
//2.0cell的左边title字体颜色
#define Cell_Left_Title_Color_V2 RGBCOLOR(98, 98, 98)
//2.0cell的右边边title字体颜色
#define Cell_Right_Title_Color_V2 RGBCOLOR(187, 187, 187)

//#define G_Appdelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))
//#define G_UIEngine (G_Appdelegate.engineUI);
//#define G_RootViewController ((UITabBarController *)G_UIEngine.rootViewController)
//#define G_TabBarController (([G_RootViewController isKindOfClass:UITabBarController.class]) ? ((UITabBarController *)G_RootViewController) : (nil))

#define UISCROLLVIEWDELEGATE(view) \
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{\
[view fsRefreshScrollViewBeginScroll:scrollView];\
}\
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{\
[view fsRefreshScrollViewDidScroll:scrollView];\
}\
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{\
[view fsRefreshScrollViewDidEndDragging:scrollView];\
}\
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView\
{\
[view fsRefreshScrollViewDidEndDecelerating:scrollView];\
}

//发意见反馈，举报，修改个人简介用同一个view
typedef enum {
    
    InputTextViewTypeFeedBack = 0,         //发意见反馈
    InputTextViewTypeIntro, //个人简介
    InputTextViewTypeReport, //举报
    InputTextViewTypeProjectName //日记名称
    
}InputTextViewType;

#define NSINTEGER_MAX 2147483647

#endif
