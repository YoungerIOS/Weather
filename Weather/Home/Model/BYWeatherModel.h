//
//  BYWeatherModel.h
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYWeatherModel : NSObject

//首页天气
@property (nonatomic, strong) NSString *cityName;

//湿度
@property (nonatomic, assign) float humidity;

//风速
@property (nonatomic, assign) float windspeedKmph;
    
//日出
@property (nonatomic, strong) NSString *sunrise;

//日落
@property (nonatomic, strong) NSString *sunset;


//天气图标
//@property (nonatomic, strong) NSString *iconURLStr;
@property (nonatomic, strong) NSString *iconName;

//天气概述
@property (nonatomic, strong) NSString *weatherDesc;

//最高温
@property (nonatomic, assign) float maxTemp;

//最低温
@property (nonatomic, assign) float minTemp;

//体感温度
@property (nonatomic, assign) float feellikeTemp;
    
//当前温度
@property (nonatomic, assign) float temp;

//日期
@property (nonatomic, strong) NSString *date;

//每小时天气情况
@property (nonatomic, assign) float hourly;//time/100

//解析当前的json
+ (id)weatherWithNowJson:(NSDictionary *)nowJson;

//解析天气数据
+ (NSArray *)weatherFromJson:(NSDictionary *)jsonDic isHourly:(BOOL)isHourly;


@end
