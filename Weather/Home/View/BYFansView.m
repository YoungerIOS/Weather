//
//  BYFansView.m
//  Weather
//
//  Created by young on 2018/8/14.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYFansView.h"
#import "Masonry.h"

@implementation BYFansView

- (void)addSubviewsWithScale:(CGFloat)scale{
    
    [super layoutIfNeeded];

    //风扇圆心
    UIImageView *dotImage = [[UIImageView alloc] init];
    dotImage.image = [UIImage imageNamed:@"alpha"];
    [self addSubview:dotImage];
    
    //支柱
    UIView *column = [UIView new];
    column.backgroundColor = [UIColor yellowColor];
    [self addSubview:column];
    
    //扇叶A
    UIView *fansViewA = [[UIView alloc] init];
    [self addSubview:fansViewA];
    self.fansViewA = fansViewA;
    
    UIImageView *fanOne = [[UIImageView alloc] init];
    [fansViewA addSubview:fanOne];
    fanOne.image = [UIImage imageNamed:@"WindSpeed"];
    
    //扇叶B
    UIView *fansViewB = [[UIView alloc] init];
    [self addSubview:fansViewB];
    self.fansViewB = fansViewB;
    
    UIImageView *fanTwo = [[UIImageView alloc] init];
    [fansViewB addSubview:fanTwo];
    fanTwo.image = [UIImage imageNamed:@"WindSpeed"];
    //    fansViewB.transform = CGAffineTransformRotate(fansViewB.transform, M_PI * 2 / 3);
    
    //扇叶C
    UIView *fansViewC = [[UIView alloc] init];
    [self addSubview:fansViewC];
    self.fansViewC = fansViewC;
    
    UIImageView *fanThree = [[UIImageView alloc] init];
    
    [fansViewC addSubview:fanThree];
    fanThree.image = [UIImage imageNamed:@"WindSpeed"];
    //    fansViewC.transform = CGAffineTransformRotate(fansViewC.transform, M_PI * 2  * 2 / 3);
    
    
    //约束
    [dotImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self).centerOffset(CGPointMake(0, - self.bounds.size.height * 0.25));
        make.width.mas_equalTo(10 * scale);
        make.height.equalTo(dotImage.mas_width);
    }];
    
    [fansViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dotImage);
        make.width.mas_equalTo(8 * scale);
        make.height.equalTo(self).multipliedBy(0.4);
    }];
    
    [fanOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fansViewA.mas_top).offset(0);
        make.left.equalTo(fansViewA.mas_left).offset(0);
        make.right.equalTo(fansViewA.mas_right).offset(0);
        
        make.height.equalTo(fansViewA).multipliedBy(0.5);
    }];
    
    [fansViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dotImage);
        make.width.mas_equalTo(8 * scale);
        make.height.equalTo(self).multipliedBy(0.4);
    }];
    
    [fanTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fansViewB.mas_top).offset(0);
        make.left.equalTo(fansViewB.mas_left).offset(0);
        make.right.equalTo(fansViewB.mas_right).offset(0);
        
        make.height.equalTo(fansViewB).multipliedBy(0.5);
    }];
    
    [fansViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dotImage);
        make.width.mas_equalTo(8 * scale);
        make.height.equalTo(self).multipliedBy(0.4);
    }];
    
    [fanThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fansViewC.mas_top).offset(0);
        make.left.equalTo(fansViewC.mas_left).offset(0);
        make.right.equalTo(fansViewC.mas_right).offset(0);
        
        make.height.equalTo(fansViewC).multipliedBy(0.5);
    }];
    
    [column mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dotImage.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.centerX.equalTo(dotImage);
        
        make.width.mas_equalTo(3 * scale);
        //        make.height.mas_equalTo(30);
    }];
}
    
- (void)showTheAnimatonsWithWindspeed:(float)speed {
    
    NSArray *fanViews = @[_fansViewA,_fansViewB,_fansViewC];
    float duration = 1.50f;
    
    if (speed != 0) {
        duration = (float)30/speed;
    }
    NSLog(@"风速是------%f,%f",duration,speed);


    for (int i = 0; i < 3; i++) {
        
        UIView *fan = fanViews[i];
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = [NSNumber numberWithDouble:2 * M_PI * i / 3];
        rotationAnimation.toValue = [NSNumber numberWithDouble:2 * M_PI * (i + 1) / 3];
        rotationAnimation.duration = duration;
        rotationAnimation.repeatCount = MAXFLOAT;
        
        [fan.layer addAnimation:rotationAnimation forKey:@"BYFanRotation"];
    }
}

@end
