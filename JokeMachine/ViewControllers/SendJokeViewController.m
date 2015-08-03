//
//  SendJokeViewController.m
//  JokeMachine
//
//  Created by 李永亮 on 15/7/18.
//  Copyright (c) 2015年 李永亮. All rights reserved.
//

#import "SendJokeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+DocumentPath.h"
#import "SVProgressHUD.h"
#import "API.h"

@interface SendJokeViewController ()<AVAudioPlayerDelegate>
{
    API *sendJokeAPI;
}

@property (weak, nonatomic) IBOutlet UITextView *jokeContentTextView;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIButton *auditionBtn;
@property (strong, nonatomic) IBOutlet UIButton *sendJokeBtn;
@property (strong, nonatomic) IBOutlet UIButton *jokeLabel;
@property (strong, nonatomic) IBOutlet UIButton *storyJokeLabel;
@property (strong, nonatomic) IBOutlet UIButton *coldJokeLabel;
@property (strong, nonatomic) IBOutlet UIButton *colorJokeLabel;
@property (strong, nonatomic) IBOutlet UIButton *otherJokeLabel;

@property (strong, nonatomic) IBOutlet UITextField *jokeNameTextField;



@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic) BOOL isRecording;
@property (nonatomic,strong) NSString *fileName;

@end

@implementation SendJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"来一发";
    
    [self willShowAuditionBtn:NO];
    
    
}

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

-(IBAction)startOrFinishRecord:(id)sender{
    if (self.isRecording) {
        [self finishRecord];
        [self.recordBtn setTitle:@"点击开始录制" forState:UIControlStateNormal];
    }else{
        [self beginRecord];
        [self.recordBtn setTitle:@"录制中，点击结束录制" forState:UIControlStateNormal];
    }
}

//结束录制
- (void)finishRecord{
    
    NSLog(@"time-----------%f",self.recorder.currentTime);
    
    self.isRecording=NO;
    [self.recorder stop];
    self.recorder=nil;
    
    [self willShowAuditionBtn:YES];
    NSLog(@"stop recording --------");
}

//开始录制
- (void)beginRecord{
    if(self.isRecording){
        return;
    }
    
    self.isRecording = YES;
    
    [self willShowAuditionBtn:NO];
    
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

- (void)willShowAuditionBtn:(BOOL)will{
    self.auditionBtn.hidden = !will;
    self.sendJokeBtn.hidden = !will;
    
}
- (IBAction)sendJoke:(id)sender {
    
    [SVProgressHUD showWithOnlyStatus:@"发送成功！"];
}

#pragma mark - <AVAudioPlayerDelegate>
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [[UIDevice currentDevice]setProximityMonitoringEnabled:NO];
    [self.player stop];
    self.player=nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
