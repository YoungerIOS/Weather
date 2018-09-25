//
//  BYFansView.h
//  Weather
//
//  Created by young on 2018/8/14.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYFansView : UIView

@property (nonatomic, strong) UIView *fansViewA;
@property (nonatomic, strong) UIView *fansViewB;
@property (nonatomic, strong) UIView *fansViewC;

- (void)addSubviewsWithScale:(CGFloat)scale;
- (void)showTheAnimatonsWithWindspeed:(float)speed;

@end
