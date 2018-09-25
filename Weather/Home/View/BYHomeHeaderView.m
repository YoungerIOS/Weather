//
//  BYHomeHeaderView.m
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYHomeHeaderView.h"
#import "BYLabelTools.h"
#import "Masonry.h"
#import "UIColor+FJColor.h"


//常量
//边距
static CGFloat inset = 20;
//当前温度lable高度
static CGFloat temperatureHeight = 110;
//最高最低lable高度
static CGFloat hiloHeight = 40;
//图标imageView高度
static CGFloat iconHeight = 35;
//城市lable高度
static CGFloat cityHeight = 44;


@implementation BYHomeHeaderView

//重写initWithFrame
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    //使用Frame布局视图控件
    if (self) {
        
        //城市名称
        CGRect cityFrame = CGRectMake(0, StatusBarHeight, frame.size.width, cityHeight);
        self.cityLabel = [BYLabelTools labelWithFrame:cityFrame];
        //初始值
        //self.cityLabel.text = @"Beijing";
        self.cityLabel.textColor = [UIColor blackColor];
        [self addSubview:self.cityLabel];
        self.cityLabel.backgroundColor = Tint_COLOR;
        
        //滚动视图(用于下拉刷新)
        CGRect scrollFrame = CGRectMake(0, cityFrame.origin.y + cityHeight, frame.size.width, frame.size.height - cityFrame.origin.y - cityHeight - TabBarHeight);
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        self.homeScrollView = scrollView;
        scrollView.frame = scrollFrame;
        scrollView.bounces = YES;
        scrollView.showsVerticalScrollIndicator = NO;
//        scrollView.contentSize = scrollView.frame.size;
        [self addSubview:scrollView];
        
        UIView *contentView = [[UIView alloc] init];
        [scrollView addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scrollView.mas_top).offset(0);
            make.left.equalTo(scrollView.mas_left).offset(0);
            make.bottom.equalTo(scrollView.mas_bottom).offset(0);
//            make.right.equalTo(scrollView.mas_right);
            
            make.width.equalTo(scrollView.mas_width);
            make.height.equalTo(scrollView.mas_height).offset(30);
            
            /**
             1.对scrollView添加约束时,一定要有width和height
             2.正常的上,下,左,右的约束也不能随意减掉,故看起来像加多了几个约束
             3.除了正常必要的约束,如果要上下滚动,就必须有top,bottom,height;
                                    左右滚动,就必须有left,right,width;
             
             */
        }];
    
        //最高最低温度label
        CGRect hiloFrame = CGRectMake(inset, scrollFrame.size.height - hiloHeight, scrollFrame.size.width - 2 * inset, hiloHeight);
        self.hiloLabel = [BYLabelTools labelWithFrame:hiloFrame];
        [contentView addSubview:self.hiloLabel];
        
//        self.hiloLabel.backgroundColor = [UIColor redColor];
        
        //当前温度label
        CGRect temeratureFrame = CGRectMake(0, scrollFrame.size.height - (hiloHeight + temperatureHeight), frame.size.width - 2 * inset, temperatureHeight);
        self.temperatureLabel = [BYLabelTools labelWithFrame:temeratureFrame];
        [contentView addSubview:self.temperatureLabel];
        
        self.temperatureLabel.textAlignment = NSTextAlignmentLeft;
        self.temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:124];
        
//        self.temperatureLabel.backgroundColor = [UIColor grayColor];
        
        //天气图标
        CGRect iconFrame = CGRectMake(inset, temeratureFrame.origin.y - iconHeight, iconHeight, iconHeight);
        self.iconView = [[UIImageView alloc] initWithFrame:iconFrame];
        [contentView addSubview:self.iconView];
        
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        
//        self.iconView.backgroundColor = [UIColor greenColor];
        
        //天气描述
        CGRect conditionFrame = CGRectMake(iconFrame.origin.x + iconHeight + 10, iconFrame.origin.y, frame.size.width - 2 * inset - iconHeight, iconFrame.size.height);
        self.conditionLabel = [BYLabelTools labelWithFrame:conditionFrame];
        [contentView addSubview:self.conditionLabel];
        
        self.conditionLabel.textAlignment = NSTextAlignmentLeft;
        
        
//        self.conditionLabel.backgroundColor = [UIColor blueColor];
        
        
        //创建视图控件
        self.humidityView = [[BYHumidityView alloc] initWithSubviews];
        self.humidityView.backgroundColor = Tint_COLOR;
        [contentView addSubview:self.humidityView];
        
        self.tempMinMaxView = [[BYTempMinMaxView alloc] init];
        self.tempMinMaxView.backgroundColor = Tint_COLOR;
        [contentView addSubview:self.tempMinMaxView];
        
        self.sunRiseSetView = [BYSunRiseSetView initWithSubviews];
        self.sunRiseSetView.backgroundColor = Tint_COLOR;
        [contentView addSubview:self.sunRiseSetView];
        
        self.windSpeedView = [[BYWindSpeedView alloc] init];
        self.windSpeedView.backgroundColor = Tint_COLOR;
        [contentView addSubview:self.windSpeedView];
        
        //添加约束
        [_humidityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).offset(0.5);
            make.left.equalTo(contentView.mas_left).offset(0);
            make.bottom.equalTo(self.sunRiseSetView.mas_top).offset(-1);
            make.right.equalTo(self.tempMinMaxView.mas_left).offset(-1);
            
            make.width.equalTo(@[self.tempMinMaxView.mas_width,
                                 self.sunRiseSetView.mas_width,
                                 self.windSpeedView.mas_width]);
            make.height.equalTo(@[self.tempMinMaxView.mas_height,
                                  self.sunRiseSetView.mas_height,
                                  self.windSpeedView.mas_height]);
            
        }];
        
        [_tempMinMaxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).offset(0.5);
            make.bottom.equalTo(self.windSpeedView.mas_top).offset(-1);
            make.right.equalTo(contentView.mas_right).offset(0);
            
        }];
        
        [_sunRiseSetView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.mas_left).offset(0);
            make.bottom.equalTo(self.conditionLabel.mas_top).offset(-5);
            make.right.equalTo(self.windSpeedView.mas_left).offset(-1);
            
        }];
        
        [_windSpeedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.conditionLabel.mas_top).offset(-5);
            make.right.equalTo(contentView.mas_right).offset(0);
            
        }];

    }
    
    [self.tempMinMaxView createSubviews];
    [self.windSpeedView createSubviews];

    return self;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
