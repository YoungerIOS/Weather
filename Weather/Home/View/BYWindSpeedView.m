//
//  BYWindSpeedView.m
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYWindSpeedView.h"
#import "BYMacroDefinition.h"
#import "Masonry.h"
#import "BYFansView.h"

@implementation BYWindSpeedView

- (void)createSubviews {
    [super layoutIfNeeded];
    
    //项目title
    UILabel *title = [[UILabel alloc] init];
    [self addSubview:title];
    title.text = @"Wind Speed";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    //大风扇
    self.fansViewBig = [[BYFansView alloc] init];
    [self addSubview:self.fansViewBig];
    
    //小风扇
    self.fansViewSmall = [[BYFansView alloc] init];
    [self addSubview:self.fansViewSmall];

    //风速值
    UILabel *speed = [[UILabel alloc] init];
    [self addSubview:speed];
    speed.textColor = [UIColor yellowColor];
    speed.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:10];
    self.windspeedLabel = speed;
//    speed.backgroundColor = [UIColor blueColor];
    
    CGFloat padding = 30;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        
        make.height.mas_equalTo(ScreenHeight/20);
    }];
    
    [self.fansViewBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-padding);
        make.centerX.equalTo(self).offset(-20);
        
        make.width.mas_equalTo(80);
        
    }];
    
    [self.fansViewSmall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-padding - 20);
        make.centerX.equalTo(self).offset(20);
        
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(80);
        
    }];
    
    [speed mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-padding);
        make.left.equalTo(self.fansViewBig.mas_centerX).offset(20);
        
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.fansViewBig addSubviewsWithScale:1.f];
    [self.fansViewSmall addSubviewsWithScale:0.7];
//    self.fansViewSmall.backgroundColor = [UIColor blueColor];
//    self.fansViewBig.backgroundColor = [UIColor orangeColor];

}

    
- (void)showTheAnimatons {
   
    [self.fansViewBig showTheAnimatonsWithWindspeed:self.windspeed];
    [self.fansViewSmall showTheAnimatonsWithWindspeed:self.windspeed];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
