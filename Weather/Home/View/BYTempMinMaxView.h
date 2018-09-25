//
//  BYTempMinMaxView.h
//  Weather
//
//  Created by young on 2018/8/3.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYTempMinMaxView : UIView

@property (nonatomic, assign) float minTemp;
@property (nonatomic, assign) float maxTemp;
@property (nonatomic, assign) float feellikeTemp;

@property (nonatomic, assign) CGRect selfRect;
@property (nonatomic, strong) NSArray *viewsArray;
@property (nonatomic, strong) NSArray *labelsArray;
@property (nonatomic, strong) NSArray *strLabelsArray;

@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *maxLabel;
@property (nonatomic, strong) UILabel *feelLabel;

@property (nonatomic, strong) UILabel *min;
@property (nonatomic, strong) UILabel *max;
@property (nonatomic, strong) UILabel *feel;
    
- (void)createSubviews;

- (void)showTheAnimations;

@end
