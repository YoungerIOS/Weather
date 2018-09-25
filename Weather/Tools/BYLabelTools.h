//
//  BYLabelTools.h
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYLabelTools : NSObject


//创建label
+ (UILabel *)labelWithFrame:(CGRect)frame;

//温度动画
+ (UILabel *)tempMinMaxAnimationLabel;



@end
