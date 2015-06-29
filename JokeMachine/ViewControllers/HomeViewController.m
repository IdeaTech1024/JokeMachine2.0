//
//  HomeViewController.m
//  JokeMachine
//
//  Created by 李永亮 on 15/6/28.
//  Copyright (c) 2015年 李永亮. All rights reserved.
//

#import "HomeViewController.h"

#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define NAVIGATION_HEIGHT   (self.navigationController.navigationBar.frame.size.height)

@interface HomeViewController ()<UIScrollViewDelegate>
{}

@property (weak, nonatomic) IBOutlet UIScrollView *homeScrollView;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UIView *sendJokeView;

@property (weak, nonatomic) IBOutlet UITextView *jokeContentTextView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHomeScrollView];
    [self initSendJokeView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UITableView class]])
    {
    }else
    {
        int current = scrollView.contentOffset.x / SCREEN_WIDTH;
        UIPageControl *pageControl = (UIPageControl *)[self.view viewWithTag:101];
        pageControl.currentPage = current;
    }
}

#pragma mark - Functions
- (void)initJokeContentViewText
{
    _jokeContentTextView.layer.borderColor = UIColor.grayColor.CGColor;
    _jokeContentTextView.layer.borderWidth = 0.5;
}

- (void)initSendJokeView
{
    [self initJokeContentViewText];
}

- (void)initHomeScrollView
{
    _homeScrollView.backgroundColor = [UIColor clearColor];
    _homeScrollView.pagingEnabled = YES;
    _homeScrollView.delegate = self;
    _homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 180);
    _homeScrollView.showsHorizontalScrollIndicator = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
