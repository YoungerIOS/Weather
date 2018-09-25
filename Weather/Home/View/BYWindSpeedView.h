//
//  BYWindSpeedView.h
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYFansView.h"

#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

@interface BYWindSpeedView : UIView

@property (nonatomic, strong) UIView *fansViewA;
@property (nonatomic, strong) UIView *fansViewB;
@property (nonatomic, strong) UIView *fansViewC;

@property (nonatomic, strong) UIView *fansViewD;
@property (nonatomic, strong) UIView *fansViewE;
@property (nonatomic, strong) UIView *fansViewF;
@property (nonatomic, strong) BYFansView *fansViewBig;
@property (nonatomic, strong) BYFansView *fansViewSmall;

@property (nonatomic, strong) UILabel *windspeedLabel;
@property (nonatomic, assign) float windspeed;

- (void)createSubviews;
- (void)showTheAnimatons;

@end
