//
//  HomeViewController.h
//  JokeMachine
//
//  Created by 李永亮 on 15/6/28.
//  Copyright (c) 2015年 李永亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController


// Home View -------------------------
// title ---
@property (weak, nonatomic) IBOutlet UIButton *title0;

// ---
@property (weak, nonatomic) IBOutlet UIView *sortView;

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

// Send View -------------------------


@end
