//
//  HomeViewController.m
//  JokeMachine
//
//  Created by 李永亮 on 15/6/28.
//  Copyright (c) 2015年 李永亮. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // first commit
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#if 0

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.viewWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds)*2;
}
#endif

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
