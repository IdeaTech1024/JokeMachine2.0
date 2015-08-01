//
//  FSTableView.h
//  FetionSchool
//
//  Created by 蔡建海 on 13-2-25.
//  Copyright (c) 2013年 Bruce Pei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

// 
typedef enum{
    
	FSFootViewPulling = 0,
	FSFootViewReleasing,
	FSFootViewLoading,
} FSFootViewState;

typedef enum
{
    FootViewNone = 10000,
    FootViewLabelLoadMoreTag,
    FootViewIndicatorTag,
}FootViewTag;


#define Time_Interval 0.3f

@protocol FSTableViewDelegate;

@interface FSTableView : UITableView<EGORefreshTableHeaderDelegate>
{
    // footview 状态
//    BOOL _boolFootView;//
    
    // 判断正在刷新
    BOOL _loadingRefresh;
    // 判断正在加载更多
    BOOL _loadingMore;
    
    // 上次的坐标
    CGFloat _floatLastheight;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
//    id<FSTableViewDelegate> fsDelegate;
    
    BOOL _isBanUploading; // 禁止上拉
    BOOL _isBanRefreshloading; // 禁止下拉
    
}
@property (nonatomic, strong)EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, assign)BOOL loadingRefresh;
@property (nonatomic, assign)BOOL isLoadingMore;
@property (nonatomic, assign)id<FSTableViewDelegate> fsDelegate;


@property (nonatomic, assign)BOOL isBanUploading;  // 禁止上拉
@property (nonatomic, assign)BOOL isBanRefreshloading;  // 禁止下拉


- (id)initWithFrame:(CGRect)frame withContentOffset:(CGFloat)contentOffset;

// 修改文字方案
- (void)setPullDownStr:(NSString *)str; // 下拉
- (void)setReleaseStr:(NSString *)str; // 松开
- (void)setLoadingStr:(NSString *)str; // 正在加载

 // UITableViewStyleGrouped 的tableview的定义
//- (id)initWithFrame:(CGRect)frame withStyle:(UITableViewStyle)style;

// 刷新事件完成
- (void)refreshDoneLoading;
// 加载更多完成
- (void)loadMoreDoneLoading:(BOOL)isHasError;

- (void) noMoreLoading;

- (void)fsRefreshScrollViewBeginScroll:(UIScrollView *)scrollView;

// 滑动
- (void)fsRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
// 松手
- (void)fsRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
// 停止
- (void)fsRefreshScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)changeStateOfEGO;

- (void)emptyFootView;

@end

@protocol FSTableViewDelegate <NSObject>
@optional
// 下拉刷新的执行的事件
- (void)refreshTableView:(FSTableView *)fsTableView;
// 上拉加载更多执行的事件
- (void)loadMoreTableView:(FSTableView *)fsTableView;
- (void)tableViewClicked;//被点击。

@end