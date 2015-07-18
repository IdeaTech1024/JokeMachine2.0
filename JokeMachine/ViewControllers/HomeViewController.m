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
- (IBAction)previewRecord:(UIButton *)sender {
    if(self.player.isPlaying){
        [self.player stop];
    }
    
    //播放
    NSString *filePath=[NSString documentPathWith:self.fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    [self initPlayer];
    NSError *error;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    [self.player setVolume:1];
    [self.player prepareToPlay];
    [self.player setDelegate:self];
    [self.player play];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    // ---
    NSLog(@"Size :%lld", [self fileSizeAtPath:filePath]);
}

-(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//结束录制
- (IBAction)finishRecord:(id)sender {
    self.isRecording=NO;
    [self.recorder stop];
    self.recorder=nil;
    NSLog(@"-----");
}

//开始录制
- (IBAction)beginRecord:(id)sender {
    if(self.isRecording){
        return;
    }
    
    self.isRecording = YES;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"rec_%@.wav",[dateFormater stringFromDate:now]];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
    NSLog(@"录制的文件路径:%@",fileName);
}

//初始化播放器
-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}

#pragma mark - <AVAudioPlayerDelegate>
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice]setProximityMonitoringEnabled:NO];
    [self.player stop];
    self.player=nil;
}

#pragma mark - HomeView ------------------------------------
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

#pragma mark - Title Functions
- (IBAction)sortByNew:(UIButton *)sender {
    _sortNewBtn.tintColor = [UIColor blueColor];
    _sortHotBtn.tintColor = [UIColor blackColor];
}
- (IBAction)sortByHot:(UIButton *)sender {
    _sortNewBtn.tintColor = [UIColor blackColor];
    _sortHotBtn.tintColor = [UIColor blueColor];
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
        [self updateTitleView:current];
    }
}

#pragma mark - Functions
- (void)updateTitleView:(int)currentPage
{
    if(currentPage == 0)
    {
        _title0.tintColor = [UIColor blueColor];
        _title1.tintColor = [UIColor lightGrayColor];
    }
    else
    {
        _title0.tintColor = [UIColor lightGrayColor];
        _title1.tintColor = [UIColor blueColor];
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
    _homeScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 180);
    _homeScrollView.showsHorizontalScrollIndicator = NO;
    
    // ---
    [self updateTitleView:0];

    // ---
    _sortNewBtn.tintColor = [UIColor blueColor];
    _sortHotBtn.tintColor = [UIColor blackColor];
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

@end
