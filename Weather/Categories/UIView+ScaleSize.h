//
//  UIView+ScaleSize.h
//  Weather
//
//  Created by young on 2018/8/6.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScaleSize)
//当前设备的宽和iPhone6的比例(iPhone X, 8, 7, 6s, 6)
#define W_SCALE [UIScreen mainScreen].bounds.size.width/375.0

//当前设备的高和iPhone6的比例
#define H_SCALE ([UIScreen mainScreen].bounds.size.height == 812.0 ? 667.0/667.0 : [UIScreen mainScreen].bounds.size.height/667.0)
//#define HRATIO [UIScreen mainScreen].bounds.size.height/667

//当前设备的宽和iPhone6Plus的比例(iPhone 8+, 7+, 6s+, 6+)
#define W_SCALE_PLUS [UIScreen mainScreen].bounds.size.width/414.0

//当前设备的高和iPhone6Plus的比例
#define H_SCALE_PLUS [UIScreen mainScreen].bounds.size.height/736.0

//是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

+(float)setWidth:(float)width;
+(float)setHeight:(float)height;
+(CGRect)setFrame:(CGRect)frame;

+ (float)setMWidth:(float)width;
+ (float)setMHeight:(float)height;

@end
