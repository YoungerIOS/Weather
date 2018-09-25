//
//  UIColor+FJColor.h
//  Zebra
//
//  Created by cy-fengjian on 15/9/30.
//  Copyright © 2015年 cy-fengjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Tint_COLOR [UIColor colorWithHex:0x9932CC andAlpha:1]
//#define Tint_COLOR [UIColor colorWithHex:0x9932CC andAlpha:1]
//[UIColor brownColor]
@interface UIColor (FJColor)

+(UIColor *)colorWithHex:(long)hex andAlpha:(CGFloat)alpha;

@end
