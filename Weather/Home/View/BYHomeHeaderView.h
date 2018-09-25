//
//  BYHomeHeaderView.h
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sys/utsname.h"
#import "BYMacroDefinition.h"
#import "BYHumidityView.h"
#import "BYWindSpeedView.h"
#import "BYSunRiseSetView.h"
#import "BYTempMinMaxView.h"

@interface BYHomeHeaderView : UIView

//城市label
@property (nonatomic, strong) UILabel *cityLabel;
//最高/最低温度
@property (nonatomic, strong) UILabel *hiloLabel;
//当前温度
@property (nonatomic, strong) UILabel *temperatureLabel;
//当前天气状况
@property (nonatomic, strong) UILabel *conditionLabel;
//当天天气的图标
@property (nonatomic, strong) UIImageView *iconView;

//湿度,风速,温差,日出日落
@property (nonatomic, strong) BYHumidityView *humidityView;
@property (nonatomic, strong) BYSunRiseSetView *sunRiseSetView;
@property (nonatomic, strong) BYWindSpeedView *windSpeedView;
@property (nonatomic, strong) BYTempMinMaxView *tempMinMaxView;

@property (nonatomic, strong) UIScrollView *homeScrollView;


@end
