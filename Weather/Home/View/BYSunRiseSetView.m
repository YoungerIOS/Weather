//
//  BYSunRiseSetView.m
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYSunRiseSetView.h"
#import "UIView+ScaleSize.h"
#import "Masonry.h"

@implementation BYSunRiseSetView


+ (instancetype)initWithSubviews {
    
    BYSunRiseSetView *selfView = [[BYSunRiseSetView alloc] init];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,0,ScreenWidth/2,ScreenHeight/20)];
    
    [selfView addSubview:title];
    title.text = @"Sunrise/Sunset";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];

    //日出
    UIImageView *sunriseView = [[UIImageView alloc] init];
    sunriseView.image = [UIImage imageNamed:@"sun"];
    [selfView addSubview:sunriseView];
//    sunriseView.backgroundColor = [UIColor blueColor];
    
    UILabel *sunLabel = [[UILabel alloc] init];
    sunLabel.backgroundColor = [UIColor clearColor];
    sunLabel.textColor = [UIColor yellowColor];
    sunLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:10];

    [selfView addSubview:sunLabel];
    selfView.sunLabel = sunLabel;
    
    
    //日落
    UIImageView *sunsetView = [[UIImageView alloc] init];
    sunsetView.image = [UIImage imageNamed:@"moon"];
    [selfView addSubview:sunsetView];
//    sunsetView.backgroundColor = [UIColor blueColor];
    
    UILabel *moonLabel = [[UILabel alloc] init];
    moonLabel.backgroundColor = [UIColor clearColor];
    moonLabel.textColor = [UIColor yellowColor];
    moonLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:10];

    [selfView addSubview:moonLabel];
    selfView.moonLabel = moonLabel;
    
    
    //添加约束
    float padding = 30;
    [sunriseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.greaterThanOrEqualTo(title.mas_bottom).offset(0);
        make.left.equalTo(selfView.mas_left).offset(padding);
        make.bottom.equalTo(sunsetView.mas_top).offset(0);
        
        make.width.equalTo(sunsetView.mas_width);
        make.height.equalTo(sunsetView.mas_height);
        
        make.width.equalTo(sunriseView.mas_height);

        
    }];
    
    [sunsetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sunriseView.mas_right).offset(0);
        make.bottom.equalTo(selfView.mas_bottom).offset(-padding);
        make.right.equalTo(selfView.mas_right).offset(-padding);
        

    }];
    
    [sunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sunriseView.mas_bottom).offset(0);
        make.left.equalTo(selfView.mas_left).offset(padding);
        
        make.width.equalTo(sunriseView.mas_width);
        make.height.equalTo(@20);
        
    }];
    
    [moonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sunriseView.mas_right).offset(0);
        make.bottom.equalTo(sunsetView.mas_top).offset(0);
        
        make.width.equalTo(sunsetView.mas_width);
        make.height.equalTo(@20);
        
    }];
    
    
    
    return selfView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 
}
*/

@end
