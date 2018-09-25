//
//  BYSunRiseSetView.h
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYMacroDefinition.h"


@interface BYSunRiseSetView : UIView

@property (nonatomic, strong) UILabel *sunLabel;
@property (nonatomic, strong) UILabel *moonLabel;


+ (instancetype)initWithSubviews;

@end
