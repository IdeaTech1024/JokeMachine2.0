//
//  FSTableView.m
//  FetionSchool
//
//  Created by 蔡建海 on 13-2-25.
//  Copyright (c) 2013年 Bruce Pei. All rights reserved.
//

#import "FSTableView.h"

@implementation FSTableView
@synthesize fsDelegate;

@synthesize isBanUploading = _isBanUploading;
@synthesize isBanRefreshloading = _isBanRefreshloading;
@synthesize refreshHeaderView = _refreshHeaderView;

@synthesize loadingRefresh = _loadingRefresh;
@synthesize isLoadingMore = _loadingMore;

- (id)initWithFrame:(CGRect)frame withContentOffset:(CGFloat)contentOffset
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];//[super initWithFrame:frame];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (_refreshHeaderView == nil) {
            EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.frame.size.height, self.frame.size.width, self.frame.size.height) withContentOffset:contentOffset];
            view.delegate = self;
            [self addSubview:view];
            _refreshHeaderView = view;
        }
        [_refreshHeaderView refreshLastUpdatedDate];
        
        [self createTableFooter];
        [self hideFootView];
        
        _loadingRefresh = NO;
        _loadingMore = NO;
        
        // 允许上拉
        _isBanUploading = NO;
        _isBanRefreshloading = NO;
        _floatLastheight = 0;
        //        _boolFootView = YES;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];//[super initWithFrame:frame];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (_refreshHeaderView == nil) {
            EGORefreshTableHeaderView * view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.frame.size.height, self.frame.size.width, self.frame.size.height)];
            view.delegate = self;
            [self addSubview:view];
            _refreshHeaderView = view;
        }
        [_refreshHeaderView refreshLastUpdatedDate];
        
        [self createTableFooter];
        [self hideFootView];
        
        _loadingRefresh = NO;
        _loadingMore = NO;
        
        // 允许上拉
        _isBanUploading = NO;
        _isBanRefreshloading = NO;
        _floatLastheight = 0;
        //        _boolFootView = YES;
    }
    
    return self;
}

#pragma mark - setting
//
- (void)setIsBanRefreshloading:(BOOL)isBanRefreshloading
{
    _isBanRefreshloading = isBanRefreshloading;
    
    _refreshHeaderView.hidden = _isBanRefreshloading;
}

#pragma mark - custom

// 修改文字方案
- (void)setPullDownStr:(NSString *)str // 下拉
{
    _refreshHeaderView.pullDownStr = str;
}
- (void)setReleaseStr:(NSString *)str // 松开
{
    _refreshHeaderView.releaseStr = str;
}

- (void)setLoadingStr:(NSString *)str // 正在加载
{
    _refreshHeaderView.loadingStr = str;
}

// 刷新事件完成
- (void)refreshDoneLoading
{
    [self doneLoadingTableViewData];
}

// 加载更多完成
- (void)loadMoreDoneLoading:(BOOL)isHasError
{
    [self loadDataEnd];
    if (isHasError == NO) {
        //加载更多成功
        [self hideFootView];
    } else {
        //加载更多失败
        [self loadMoreFailed];
    }
}


- (void) noMoreLoading
{
    [self loadDataEnd];
    
    UIView *view = [self.tableFooterView viewWithTag:FootViewLabelLoadMoreTag];
    if ([view isMemberOfClass:UILabel.class]) {
        
        UILabel *label = (UILabel *)view;
        label.hidden = NO;
        label.text = NSLocalizedString(@"NoMoreContent", nil);
    }
    
    UIView *view2 = [self.tableFooterView viewWithTag:FootViewIndicatorTag];
    if ([view2 isMemberOfClass:UIActivityIndicatorView.class]) {
        
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view2;
        if ([indicatorView isAnimating]) {
            [indicatorView stopAnimating];
        }
    }

}
//
- (void)changeStateOfEGO {
    
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    [self bringSubviewToFront:_refreshHeaderView];
}

#pragma mark-

- (void)fsRefreshScrollViewBeginScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewBeginScroll:scrollView];
}

// v 2.2.0 版本
- (void)fsRefreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_loadingRefresh == YES || _loadingMore == YES) {
        return;
    }
    
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat content_y = scrollView.contentSize.height;
    CGFloat frame_h = scrollView.frame.size.height;
    
    CGFloat height = offset -(content_y - frame_h);
    
    // 下拉
    if (offset<=0) {
        
        if (_isBanRefreshloading == NO) {
            [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
        }
    }
    // 上拉
    else{
        
        // 如果cell 为空， 不显示footview
        if ([self isCellEmpty] || _isBanUploading == YES) {
            
            [self hideFootView];
            return;
        }
        
        // 向下恢复的过程中 不做请求
        if (height-_floatLastheight <0) {
            
            _floatLastheight = height;
            return;
        }
 // 超过一屏
        if (content_y-frame_h >0) {

            if (height>0) {

                [self loadDataBegin];
            }

        }
        // 不足一屏
        else
        {
            if (offset>0) {
                
                [self loadDataBegin];
            }
        }
        
        
        _floatLastheight = height;
    }
    
}

- (void)fsRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (_loadingRefresh == YES || _loadingMore == YES) {
        return;
    }
    
    CGFloat offset = scrollView.contentOffset.y;
    
    if (offset<0) {
        
        if (_isBanRefreshloading == NO) {
            [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
        }
    }
    
}
// 停止
- (void)fsRefreshScrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

#pragma mark - private

// 显示footview
- (void)showFootView
{
    UIView *view = [self.tableFooterView viewWithTag:FootViewLabelLoadMoreTag];
    if ([view isMemberOfClass:UILabel.class]) {
        
        UILabel *label = (UILabel *)view;
        label.hidden = NO;
        label.text = NSLocalizedString(@"LoadingMore", nil);
        
    }
    
    UIView *view2 = [self.tableFooterView viewWithTag:FootViewIndicatorTag];
    if ([view2 isMemberOfClass:UIActivityIndicatorView.class]) {
        
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view2;
        [indicatorView startAnimating];

    }
}
// 隐藏footview
- (void)hideFootView
{
    UIView *view = [self.tableFooterView viewWithTag:FootViewLabelLoadMoreTag];
    if ([view isMemberOfClass:UILabel.class]) {
        
        UILabel *label = (UILabel *)view;
        label.hidden = YES;
    }
    
    UIView *view2 = [self.tableFooterView viewWithTag:FootViewIndicatorTag];
    if ([view2 isMemberOfClass:UIActivityIndicatorView.class]) {
        
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view2;
        [indicatorView stopAnimating];
    }
}

// footview 加载失败
- (void)loadMoreFailed
{
    UIView *view = [self.tableFooterView viewWithTag:FootViewLabelLoadMoreTag];
    if ([view isMemberOfClass:UILabel.class]) {
        
        UILabel *label = (UILabel *)view;
        label.hidden = NO;
        label.text = NSLocalizedString(@"NetErrorTryLater", nil);
    }
    
    UIView *view2 = [self.tableFooterView viewWithTag:FootViewIndicatorTag];
    if ([view2 isMemberOfClass:UIActivityIndicatorView.class]) {
        
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view2;
        [indicatorView stopAnimating];
    }
}

// 清空footView
- (void)emptyFootView {

    UIView *view = [self.tableFooterView viewWithTag:FootViewLabelLoadMoreTag];
    if ([view isMemberOfClass:UILabel.class]) {
        
        UILabel *label = (UILabel *)view;
        label.text = @"";
    }
    
    UIView *view2 = [self.tableFooterView viewWithTag:FootViewIndicatorTag];
    if ([view2 isMemberOfClass:UIActivityIndicatorView.class]) {
        
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)view2;
        [indicatorView stopAnimating];
    }
}

// 计算cell个数
- (NSUInteger)numberOfTableViewCells
{
    NSUInteger sections = [self numberOfSections];
    if (sections == 0) {
        return 0;
    }
    NSInteger count = 0;
    for (int i = 0; i<sections; ++i) {
        
        count += [self numberOfRowsInSection:i];
    }
    
    return count;
}

// 判断cell为空
- (BOOL)isCellEmpty
{
    if ([self numberOfSections] == 1) {
        
        if ([self numberOfRowsInSection:0]==0) {
           
            return YES;
        }
    }else if([self numberOfSections] == 0){
        
        return YES;
    }
    return NO;
}

#pragma mark - Loading more

// 创建表格底部
- (void) createTableFooter
{
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 50.0f)];
    
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, 150.0f, 40.0f)];
    [loadMoreText setCenter:tableFooterView.center];
    [loadMoreText setFont:[UIFont systemFontOfSize:12]];
    loadMoreText.tag = FootViewLabelLoadMoreTag;
    loadMoreText.text = NSLocalizedString(@"LoadingMore", nil);
    loadMoreText.textColor = RGBCOLOR(88, 95, 105);
    loadMoreText.backgroundColor = [UIColor clearColor];
    loadMoreText.textAlignment = NSTextAlignmentCenter;
    [tableFooterView addSubview:loadMoreText];
    
    UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(109.0f, 15.0f, 20.0f, 20.0f)];
    [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    tableFooterActivityIndicator.tag = FootViewIndicatorTag;
    [tableFooterView addSubview:tableFooterActivityIndicator];
    tableFooterActivityIndicator = nil;
    
    self.tableFooterView = tableFooterView;
}

// 开始加载数据
- (void) loadDataBegin
{
    [self showFootView];
    
    if ([self.fsDelegate respondsToSelector:@selector(loadMoreTableView:)]&& _isBanUploading == NO) {
        [self.fsDelegate loadMoreTableView:self];
    }
}

// 加载数据完毕
- (void) loadDataEnd
{
    _loadingMore = NO;
}

//
- (void)reloadTableViewDataSource
{    
    // 执行刷新事件
    if ([self.fsDelegate respondsToSelector:@selector(refreshTableView:)]) {
        [self.fsDelegate refreshTableView:self];
    }
}

- (void)doneLoadingTableViewData
{
    if (_isBanRefreshloading == NO) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    }
}

#pragma mark - EGORefreshTableHeaderDelegate
//
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    if (_isBanRefreshloading == NO) {
        
        [self reloadTableViewDataSource];
    }
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _loadingRefresh;
}

// optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date];
}
@end
