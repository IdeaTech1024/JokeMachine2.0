//
//  UIImageView+LoadingView.m
//  Giveit100
//
//  Created by ytb on 14-5-13.
//  Copyright (c) 2014年 Feinno. All rights reserved.
//

#import "UIImageView+LoadingView.h"
#import "UIImage+Addition.h"

@implementation UIImageView (LoadingView)

- (void)startLoading {

    NSMutableArray * images = [NSMutableArray arrayWithCapacity:48];

    UIImage * image = [UIImage imageNamed:@"SVProgressHUD.bundle/load.png"];
    
    for (int i = 1; i <= 48; i++)
    {
        
        UIImage *img = [image imageRotatedByDegrees:7.5F*i];
        
        [images addObject:img];
        
    }
    self.animationImages = images;
    
    self.animationDuration = 1.2;
    [self startAnimating];
}

- (void)stopLoading {

    [self stopAnimating];
}

@end
