//
//  HomeViewController.m
//  JokeMachine
//
//  Created by 李永亮 on 15/6/28.
//  Copyright (c) 2015年 李永亮. All rights reserved.
//

#import "HomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+DocumentPath.h"

#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define NAVIGATION_HEIGHT   (self.navigationController.navigationBar.frame.size.height)

#define GLOBAL_BLUE_COLOR   ([UIColor colorWithRed:(22.0/255) green:(109.0/255) blue:(253.0/255) alpha:1.0])

@interface HomeViewController ()<UIScrollViewDelegate,AVAudioPlayerDelegate, UITableViewDataSource, UITableViewDelegate>
{}

@property (weak, nonatomic) IBOutlet UIScrollView *homeScrollView;
@property (weak, nonatomic) IBOutlet UIView *homeView;
@property (weak, nonatomic) IBOutlet UIView *sendJokeView;

@property (weak, nonatomic) IBOutlet UITextView *jokeContentTextView;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;

@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic) BOOL isRecording;
@property (nonatomic,strong) NSString *fileName;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initHomeScrollView];
    [self initSendJokeView];
}

#pragma mark - SendView ------------------------------------



#pragma mark - private method

#pragma mark - <TableView Delegate>

#pragma mark - <TableView Datasource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // avatar ----
    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    UIImage *avatarImage = [UIImage imageNamed:@"userAvatar"];
    avatarImageView.image = avatarImage;
    [cell addSubview:avatarImageView];
    
    // text---
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 200, 20)];
    userNameLabel.text = @"笑死不偿命";
    [cell addSubview:userNameLabel];
    
    return cell;
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
        
        [self selectCurrentTitle:current];
    }
}

#pragma mark - HomeView ------------------------------------
- (void)selectCurrentTitle:(int)current
{
    _recommendBtn.tintColor = [UIColor lightGrayColor];
    _funnyBtn.tintColor     = [UIColor lightGrayColor];
    _storyBtn.tintColor     = [UIColor lightGrayColor];
    _coldBtn.tintColor      = [UIColor lightGrayColor];
    _colorBtn.tintColor     = [UIColor lightGrayColor];
    _otherBtn.tintColor     = [UIColor lightGrayColor];
    
    switch (current) {
        case 0:
            _recommendBtn.tintColor = GLOBAL_BLUE_COLOR;
            break;
        case 1:
            _funnyBtn.tintColor     = GLOBAL_BLUE_COLOR;
            break;
        case 2:
            _storyBtn.tintColor     = GLOBAL_BLUE_COLOR;
            break;
        case 3:
            _coldBtn.tintColor      = GLOBAL_BLUE_COLOR;
            break;
        case 4:
            _colorBtn.tintColor     = GLOBAL_BLUE_COLOR;
            break;
        case 5:
            _otherBtn.tintColor     = GLOBAL_BLUE_COLOR;
            break;
        default:
            break;
    }
}

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
    _homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*6, 180);
    _homeScrollView.showsHorizontalScrollIndicator = NO;
    
    // ---
    [self selectCurrentTitle:0];
    
    // ---
    _sortView.layer.borderWidth = 0.5;
    _sortView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    // table view---
    _homeTableView.dataSource = self;
    _homeTableView.delegate = self;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Recommend ------------------------------------
#pragma mark - Funny ------------------------------------
#pragma mark - Story ------------------------------------
#pragma mark - Cold ------------------------------------
#pragma mark - Color ------------------------------------
#pragma mark - Other ------------------------------------

@end
