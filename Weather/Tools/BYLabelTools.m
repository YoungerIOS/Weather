//
//  BYLabelTools.m
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BYLabelTools.h"
#import "UIColor+FJColor.h"

@implementation BYLabelTools

+ (UILabel *)labelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = Tint_COLOR;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    
    return label;
    
}

+ (UILabel *)tempMinMaxAnimationLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:10];
    label.textColor = [UIColor yellowColor];
    label.alpha = 0.f;
//    label.backgroundColor = [UIColor lightGrayColor];
    return label;
    
}


    
@end
