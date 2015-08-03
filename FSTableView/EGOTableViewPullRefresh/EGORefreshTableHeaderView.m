//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"
#import "CALayer+Spin.h"


#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView
@synthesize delegate;
@synthesize pullDownStr = _pullDownStr, releaseStr = _releaseStr, loadingStr = _loadingStr ;

- (id) initWithFrame:(CGRect)frame withContentOffset:(CGFloat)contentOffset{
    self = [self initWithFrame:frame];
    if (self) {
        _findContetnOffset = contentOffset;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.pullDownStr = NSLocalizedString(@"Pull down to update", nil);
        self.releaseStr = NSLocalizedString(@"Release to update", nil);
        self.loadingStr = NSLocalizedString(@"Loading", nil);
        
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
        self.backgroundColor = APP_VC_BG_COLOR;
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 28.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:11.0f];
		label.textColor = RGBCOLOR(155, 159, 165);//TEXT_COLOR;
//		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:12.0f];
		label.textColor = RGBCOLOR(88, 95, 105);//TEXT_COLOR;
//		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
//		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		
//        UIImageView *catView = [[UIImageView alloc]initWithFrame:CGRectMake(35.0f, frame.size.height-53.0f, 44.0f, 53.0f)];
//        [catView catPullRefreshAnimation];
//        [self addSubview:catView];
        
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(112.0f, frame.size.height - 65.0f, 13.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
//		layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
		layer.contents = (id)[UIImage imageNamed:@"ego_refresh_arrow"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
        
        CALayer *layerLoading = [CALayer layer];
		layerLoading.frame = CGRectMake(110.0f, frame.size.height - 46.0f, 17.0f, 17.0f);
		layerLoading.contentsGravity = kCAGravityResizeAspect;
        //		layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
		layerLoading.contents = (id)[UIImage imageNamed:@"ego_refresh_loading"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layerLoading.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layerLoading];
        _loadingImage=layerLoading;
		
//		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//		view.frame = CGRectMake(109.0f, frame.size.height - 48.0f, 20.0f, 20.0f);
//		[self addSubview:view];
//		_activityView = view;
		
		
		[self setState:EGOOPullRefreshNormal];
        
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
	if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
		
		NSDate *date = [self.delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//		[formatter setAMSymbol:@"AM"];
//		[formatter setPMSymbol:@"PM"];
//		[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
		[formatter setAMSymbol:@"AM"];
		[formatter setPMSymbol:@"PM"];
		[formatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
        
//        NSString *string = [NSString stringWithString:[FeedTransform timestampWithDate:[formatter stringFromDate:date]]];
        //如果格式化，最后更新的时间永远是 “刚刚” 所以不要格式化了
        NSString *string = [NSString stringWithString:[formatter stringFromDate:date]];

		_lastUpdatedLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Last Refresh Time %@", nil), string];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		_lastUpdatedLabel.text = nil;
		
	}
    
}

- (void)setState:(EGOPullRefreshState)aState{
	
    [_loadingImage removeAllAnimations];
    
	switch (aState) {
		case EGOOPullRefreshPulling:
			
			_statusLabel.text = _releaseStr;
            
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];

            self.hidden = NO;

			break;
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];

			}
			
			_statusLabel.text = _pullDownStr;
//			[_activityView stopAnimating];
            
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
            _loadingImage.hidden = YES;
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
            
			[self refreshLastUpdatedDate];
            
            self.hidden = YES;
            
			break;
		case EGOOPullRefreshLoading:
                        
			_statusLabel.text = _loadingStr;
//			[_activityView startAnimating];
            
            [_loadingImage spinArrowImage];
            
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
            
            self.hidden = NO;
			
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewBeginScroll:(UIScrollView *)scrollView
{
    scrollEnd = NO;
}

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < (-3 - _findContetnOffset)  && !scrollEnd) {
        [self setHidden:NO];
    }
    
//    NSLog(@"scrollView.contentOffset.y = %f",scrollView.contentOffset.y);
	
	if (_state == EGOOPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, _findContetnOffset + 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [self.delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
        
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > (-65.0f -_findContetnOffset) && scrollView.contentOffset.y < 0.0f && !_loading) {
            
			[self setState:EGOOPullRefreshNormal];
            
            NSLog(@"===========%f==contentoffset",_findContetnOffset);
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < (-65.0f -_findContetnOffset) && !_loading) {
            
			[self setState:EGOOPullRefreshPulling];
            
            NSLog(@"===========%f==contentoffset",_findContetnOffset);
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsMake(_findContetnOffset, 0, 0, 0);
		}
		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
    NSLog(@"egoRefreshScrollViewDidEndDragging____________");
    
    scrollEnd = YES;
    
	BOOL _loading = NO;
	if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [self.delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= (- 65.0f - _findContetnOffset) && !_loading) {
		
		if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[self.delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f + _findContetnOffset, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
	}
    
}

- (void)egoRefreshScrollViewDidEndDraggingWithRefreshButton:(UIScrollView *)scrollView {
	
	if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		[self.delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
    
    if ([self.delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
        [self.delegate egoRefreshTableHeaderDidTriggerRefresh:self];
    }
    
    [self setState:EGOOPullRefreshLoading];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    scrollView.contentInset = UIEdgeInsetsMake(60.0f + _findContetnOffset, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f + _findContetnOffset, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:EGOOPullRefreshNormal];
}

@end
