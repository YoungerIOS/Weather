//
//  BYHumidityView.h
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYMacroDefinition.h"
#import "UICountingLabel.h"

@interface BYHumidityView : UIView <CAAnimationDelegate>

@property (nonatomic, assign) float humidity;
@property (nonatomic, strong) UICountingLabel *humidityLabel;
@property (nonatomic, strong) CAShapeLayer *humLayer;

- (instancetype)initWithSubviews;
- (void)showTheAnimations;
- (NSMutableAttributedString *)attributedLabelTextWithText:(float)text;

@end
