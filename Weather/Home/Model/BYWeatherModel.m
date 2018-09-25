//
//  BYWeatherModel.m
//  Weather
//
//  Created by young on 2018/7/24.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYWeatherModel.h"

@implementation BYWeatherModel

//解析当前天气json
+ (id)weatherWithNowJson:(NSDictionary *)nowJson {
    
    return [[self alloc] initWithNowJson:nowJson];
}

-(id)initWithNowJson:(NSDictionary *)dic {
    
    if ([super init]) {
        NSDictionary *dataDic = dic[@"data"];
        NSDictionary *condition = dataDic[@"current_condition"][0];
        
        NSString *city = dataDic[@"request"][0][@"query"];
        NSArray *areaArray = [city componentsSeparatedByString:@","];
        //当前城市
        self.cityName = areaArray[0];
        
        //湿度
        self.humidity = [condition[@"humidity"] floatValue];
        
        //日出,日落
        self.sunrise = dataDic[@"weather"][0][@"astronomy"][0][@"sunrise"];
        self.sunset = dataDic[@"weather"][0][@"astronomy"][0][@"sunset"];
        
        //当前温度
        self.temp = [condition[@"temp_C"] floatValue];
        
        //体感温度
        self.feellikeTemp = [condition[@"FeelsLikeC"] floatValue];
        
        //风速
        self.windspeedKmph = [condition[@"windspeedKmph"] integerValue];
        
        //天气概述
        self.weatherDesc = condition[@"weatherDesc"][0][@"value"];
        
        //天气图标
//        self.iconURLStr = condition[@"weatherIconUrl"][0][@"value"];
        self.iconName = condition[@"weatherCode"];
    }
    
    return self;

}

//解析每天和每时段json数据
+ (NSArray *)weatherFromJson:(NSDictionary *)jsonDic isHourly:(BOOL)isHourly {
    
    NSMutableArray *dailyResult = [NSMutableArray array];
    NSMutableArray *hourlyResult = [NSMutableArray array];
    
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *weatherArray = dataDic[@"weather"];
    NSArray *hourlyArray = weatherArray[0][@"hourly"]; //取第0个元素表示只解析第一天（当天）的8个时段
    
    for (NSDictionary *weatherDic in weatherArray) {
        BYWeatherModel *dailyWeather = [[self alloc] weatherWithDailyJson:weatherDic];
        [dailyResult addObject:dailyWeather];
    }
    
    for (NSDictionary *hourlyDic in hourlyArray) {
        BYWeatherModel *hourlyWeather = [[self alloc] weatherWithHourlyJson:hourlyDic];
        [hourlyResult addObject:hourlyWeather];
    }
    
    
    return isHourly ? hourlyResult : dailyResult;
}


//解析每小时json
- (id)weatherWithHourlyJson:(NSDictionary *)hourlyJson {
    
    return [self initWithHourlyJson:hourlyJson];
}

- (id)initWithHourlyJson:(NSDictionary *)dic {
    if (self = [super init]) {
        //tempC
        self.temp = [dic[@"tempC"] floatValue];
        
        //time (200; 500; 800 ==> 2; 5; 8)
        self.hourly = [dic[@"time"] floatValue] / 100;
        
        //weatherIconUrl
//        self.iconURLStr = dic[@"weatherIconUrl"][0][@"value"];
        self.iconName = [self turnWeatherCodesToWeaherIcons:dic[@"weatherCode"]];

    }
    
    return self;
    
    
}

//解析每天json
- (id)weatherWithDailyJson:(NSDictionary *)dailyJson {
    
    return [self initWithDailyJson:dailyJson];
}

- (id)initWithDailyJson:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        //date
        NSString *dateTime = dic[@"date"];
        self.date = [self turnTheDateToWeekday:dateTime];
        //maxTemp
        self.maxTemp = [dic[@"maxtempC"] floatValue];
        //mixTemp
        self.minTemp = [dic[@"mintempC"] floatValue];
        //iconUrl
//        self.iconURLStr = dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
        self.iconName = [self turnWeatherCodesToWeaherIcons:dic[@"hourly"][0][@"weatherCode"]];
        
    }
    
    return self;
}

//日期转换为星期
-(NSString *)turnTheDateToWeekday:(NSString *) dateString{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat",  nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"YYYY-MM-dd"];
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate* date = [formatter dateFromString:dateString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *theComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


//对应天气图标与天气代码
-(NSString *)turnWeatherCodesToWeaherIcons:(NSString *)weatherCode {
    
    NSDictionary *iconsCodes = @{
                                 @"113":    @"100",
                                 @"116":    @"103",
                                 @"119":    @"101",
                                 @"122":    @"104",
                                 @"143":    @"500",
                                 @"176":    @"300",
                                 @"179":    @"404",
                                 @"182":    @"404",
                                 @"185":    @"404",
                                 @"200":    @"302",
                                 @"227":    @"406",
                                 @"230":    @"410",
                                 @"248":    @"501",
                                 @"260":    @"501",
                                 @"263":    @"300",
                                 @"266":    @"305",
                                 @"281":    @"404",
                                 @"284":    @"404",
                                 @"293":    @"305",
                                 @"296":    @"305",
                                 @"299":    @"301",
                                 @"302":    @"306",
                                 @"305":    @"301",
                                 @"308":    @"307",
                                 @"311":    @"404",
                                 @"314":    @"404",
                                 @"317":    @"404",
                                 @"320":    @"404",
                                 @"323":    @"400",
                                 @"326":    @"400",
                                 @"329":    @"401",
                                 @"332":    @"401",
                                 @"335":    @"406",
                                 @"338":    @"402",
                                 @"350":    @"404",
                                 @"353":    @"300",
                                 @"356":    @"301",
                                 @"359":    @"301",
                                 @"362":    @"305",
                                 @"365":    @"305",
                                 @"368":    @"406",
                                 @"371":    @"406",
                                 @"374":    @"305",
                                 @"377":    @"404",
                                 @"386":    @"304",
                                 @"389":    @"303",
                                 @"392":    @"302",
                                 @"395":    @"402"
                                                    };
    
    NSString *iconNum = [iconsCodes objectForKey:weatherCode];
    
    return iconNum;
}


@end
