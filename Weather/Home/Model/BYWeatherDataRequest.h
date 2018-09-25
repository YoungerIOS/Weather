//
//  BYWeatherDataRequest.h
//  Weather
//
//  Created by young on 2018/8/16.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYWeatherModel.h"

@interface BYWeatherDataRequest : NSObject

//当前城市
@property (nonatomic, strong) NSString *currentCity;

//Header的数据
@property (nonatomic, strong) BYWeatherModel *homeModel;

//每天天气
@property (nonatomic, strong) NSArray *dailyModelArray;

//每时段天气
@property (nonatomic, strong) NSArray *hourlyModelArray;


- (void)getJsonFromURL;

@end
