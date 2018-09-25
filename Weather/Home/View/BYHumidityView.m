//
//  BYHumidityView.m
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYHumidityView.h"
#import "Masonry.h"
#import <QuartzCore/QuartzCore.h>
#import "UICountingLabel.h"

static CGFloat offset = 30;


@implementation BYHumidityView

//- (void)setHumidity:(float)humidity {
//    _humidity = humidity;
////    [self setNeedsDisplay];
//
//}
- (instancetype)initWithSubviews {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //项目title
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2, ScreenHeight/20)];
    [self addSubview:title];
    title.text = @"Humidity";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    
    //添加data
//    UILabel *dataLabel = [[UILabel alloc] init];
    UICountingLabel *dataLabel = [[UICountingLabel alloc] init];
    [self addSubview:dataLabel];
    dataLabel.format = @"%d";
    dataLabel.method = UILabelCountingMethodEaseOut;
    dataLabel.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:56];
    dataLabel.textAlignment = NSTextAlignmentRight;
    dataLabel.textColor = [UIColor yellowColor];
    self.humidityLabel = dataLabel;
//    dataLabel.backgroundColor = [UIColor blueColor];
    
    UILabel *percent = [UILabel new];
    [self addSubview:percent];
    percent.font = [UIFont fontWithName:@"CourierNewPS-ItalicMT" size:24];
    percent.textAlignment = NSTextAlignmentLeft;
    percent.text = @"%";
//    percent.backgroundColor = [UIColor greenColor];

    [dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self).centerOffset(CGPointMake(-20, offset));
        make.width.equalTo(@105);
        make.height.equalTo(@80);
    }];
    
    [percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataLabel.mas_right).offset(0);
        make.bottom.equalTo(dataLabel.mas_bottom).offset(0);
        
        make.width.mas_equalTo(30);
        make.height.equalTo(dataLabel).multipliedBy(0.8);
    }];
    
    return self;
}


- (void)showTheAnimations {
    
    [self.humidityLabel countFromZeroTo:self.humidity withDuration:1.5f];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGFloat parameter  = 0.00f;
    if (_humidity) {
        parameter = _humidity * 0.01f;
    };
    
    if (self.humLayer) {
        [self.humLayer removeFromSuperlayer];
    }
    //底层圆圈的贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2 + offset);
    CGFloat radius = MIN(rect.size.width/2 - 20, rect.size.height/2 - 20);
    [path addArcWithCenter:center
                    radius:radius
                startAngle:M_PI_2 + M_PI * 45/180
                  endAngle:M_PI_2 - M_PI * 45/180
                 clockwise:YES];
    path.lineWidth = 2;
    [[UIColor blackColor] setStroke];
    [path stroke];
    
    //湿度指示圆圈
    self.humLayer = [CAShapeLayer layer];
    self.humLayer.fillColor = [UIColor clearColor].CGColor;
    self.humLayer.lineWidth =  2.0f;
    self.humLayer.lineCap = kCALineCapRound;
    self.humLayer.lineJoin = kCALineJoinRound;
    self.humLayer.strokeColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:self.humLayer];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    [path2 addArcWithCenter:center
                     radius:radius
                 startAngle:M_PI_2 + M_PI * 45/180
                   endAngle:(2 * M_PI - M_PI * 90/180) * parameter + M_PI_2 + M_PI * 45/180
                  clockwise:YES
     ];
    
    // 关联layer和贝塞尔路径(也可以用父视图的layer,但新建一个layer则可设置更多属性)
    self.humLayer.path = path2.CGPath;
    self.humLayer.autoreverses = NO;
    
    // 创建Animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = 1.5f;
    animation.timingFunction =  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];

    [self.humLayer addAnimation:animation forKey:nil];
    animation.delegate = self;
    

    
}


- (NSMutableAttributedString *)attributedLabelTextWithText:(float)text {

    if (text) {
        
        NSString *string = [NSString stringWithFormat:@"%.f%%",text];
        
        NSRange range = NSMakeRange(2, 1);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        //设置字体颜色
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
        //设置字体大小
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CourierNewPS-ItalicMT" size:24] range: range];
        
        return str;
        
    }else {
        return nil;
    }
    
    
}


@end
