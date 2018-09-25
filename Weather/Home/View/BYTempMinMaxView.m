//
//  BYTempMinMaxView.m
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYTempMinMaxView.h"
#import "BYMacroDefinition.h"
#import "UIColor+FJColor.h"
#import "Masonry.h"
#import "BYLabelTools.h"

@implementation BYTempMinMaxView

- (void)createSubviews {
    
    [super layoutIfNeeded];
    
    CGRect rect = self.bounds;
    self.selfRect = rect;

    //项目title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, ScreenHeight/20)];//ScreenWidth/2, ScreenHeight/20
    [self addSubview:title];
    
    title.text = @"Temperature";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    //Min温度条
    UIView *lineviewA  = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width/2 - 40,
                                                                  rect.origin.y + 30,
                                                                  20,
                                                                  40)];
    lineviewA.backgroundColor = [UIColor orangeColor];
    lineviewA.alpha = 0.f;
    [self addSubview:lineviewA];
        //min
    self.min = [BYLabelTools tempMinMaxAnimationLabel];
    self.min.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.min.text = @"Min";
    [self addSubview:_min];
        //数字
    self.minLabel = [BYLabelTools tempMinMaxAnimationLabel];
    [self addSubview:_minLabel];
    
    //Max温度条
    UIView *lineviewB  = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width/2,
                                                                  rect.origin.y + 30,
                                                                  20,
                                                                  40)];
    lineviewB.backgroundColor = [UIColor orangeColor];
    lineviewB.alpha = 0.f;
    [self addSubview:lineviewB];
        //max
    self.max = [BYLabelTools tempMinMaxAnimationLabel];
    self.max.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.max.text = @"Max";
    [self addSubview:_max];
        //数字
    self.maxLabel = [BYLabelTools tempMinMaxAnimationLabel];
    [self addSubview:_maxLabel];
    
    //体感温度条
    UIView *lineviewC  = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width/2 + 40,
                                                                  rect.origin.y + 30,
                                                                  20,
                                                                  40)];
    lineviewC.backgroundColor = [UIColor orangeColor];
    lineviewC.alpha = 0.f;
    [self addSubview:lineviewC];
        //feel
    self.feel = [BYLabelTools tempMinMaxAnimationLabel];
    self.feel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    self.feel.text = @"Feel";
    [self addSubview:_feel];
        //数字
    self.feelLabel = [BYLabelTools tempMinMaxAnimationLabel];
    [self addSubview:_feelLabel];
    
    
    //约束
    [_minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineviewA.mas_top).offset(0);
        make.centerX.equalTo(lineviewA);
        
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        
    }];
    [_min mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.minLabel.mas_top).offset(0);
        make.centerX.equalTo(self.minLabel);
        
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    [_maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineviewB.mas_top).offset(0);
        make.centerX.equalTo(lineviewB);
        
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        
    }];
    [_max mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.maxLabel.mas_top).offset(0);
        make.centerX.equalTo(self.maxLabel);
        
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    [_feelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineviewC.mas_top).offset(0);
        make.centerX.equalTo(lineviewC);
        
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
        
    }];
    [_feel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.feelLabel.mas_top).offset(0);
        make.centerX.equalTo(self.feelLabel);
        
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(15);
    }];
    
    
    
    
    //动画显示
    self.viewsArray     = @[lineviewA,lineviewB,lineviewC];
    self.labelsArray    = @[_minLabel,_maxLabel,_feelLabel];
    self.strLabelsArray = @[_min,_max,_feel];
    
//    [self showTheAnimations];
    

    
}

- (void)showTheAnimations {
    
    //重置初始位置
    for (int i = 0; i < 3; i++) {
        UIView *view = self.viewsArray[i];
        UILabel *label = self.labelsArray[i];
        UILabel *strLabel = self.strLabelsArray[i];
        CGRect frame = view.bounds;
        frame = CGRectMake(self.selfRect.size.width/2 + 40 * (i - 1),
                           self.selfRect.origin.y + 30,
                           20,
                           40);
        view.frame = frame;
        view.alpha = 0.f;
        label.alpha = 0.f;
        strLabel.alpha = 0.f;
    }
    //动画
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        float heights[3];
        float average = (self.minTemp + self.maxTemp + self.feellikeTemp) / 3;
        heights[0] = (self.minTemp + 60) * 0.5 + (self.minTemp - average) * 2;//扩大差值
        heights[1] = (self.maxTemp + 60) * 0.5 + (self.maxTemp - average) * 2;
        heights[2] = (self.feellikeTemp + 60) * 0.5 + (self.feellikeTemp - average) * 2;
        
        for (int i = 0 ;i < 3;i++) {
            UIView *view = self.viewsArray[i];
            
            if (heights[i] == 0) {
                heights[i] = 1.f;
            };
            CGRect frame = view.bounds;
            frame = CGRectMake(self.selfRect.size.width/2 + 40 * (i - 1),
                               self.selfRect.size.height - 30 - heights[i],
                               10,
                               heights[i]);
            view.frame = frame;
            
            view.backgroundColor = [UIColor yellowColor];
            view.alpha = 1.f;
            
        }
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.5 animations:^{
            for (int i = 0 ;i < 3;i++) {
                
                UILabel *label = self.labelsArray[i];
                UILabel *strLabel = self.strLabelsArray[i];
                label.alpha = 1.f;
                strLabel.alpha = 1.f;
            }
        }];
    }];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *aColor      = [UIColor colorWithHex:0xfffd38 andAlpha:1.f];
    CGContextSetStrokeColorWithColor(context, aColor.CGColor);
    CGContextSetLineWidth(context, 1);
    
    CGPoint aPoint[3];
    aPoint[0] = CGPointMake(rect.size.width/2, rect.size.height - 30);
    aPoint[1] = CGPointMake(aPoint[0].x + 80, aPoint[0].y);
    aPoint[2] = CGPointMake(aPoint[0].x - 80, aPoint[0].y);
    CGContextAddLines(context, aPoint, 3);

    CGContextDrawPath(context, kCGPathFillStroke);
    
}



@end
