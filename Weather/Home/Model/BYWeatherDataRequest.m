//
//  BYWeatherDataRequest.m
//  Weather
//
//  Created by young on 2018/8/16.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYWeatherDataRequest.h"
#import "AFNetworking.h"
#import "BYWeatherModel.h"
#import "SVProgressHUD.h"


#define weatherURL @"https://api.worldweatheronline.com/premium/v1/weather.ashx"

@implementation BYWeatherDataRequest


- (void)getJsonFromURL {
    
    //设置请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes= [[NSSet alloc] initWithObjects:@"application/json",@"text/plain", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSDictionary *parameterDic=@{
                                 @"num_of_days":@"7",
                                 @"key":@"9d85428cb67e4aa193060813181707",
                                 @"fx":@"yes",
                                 @"format":@"json"
                                 };
    NSMutableDictionary *parameters = [parameterDic mutableCopy];
    NSString *citystring = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCAL_CITY_NAME"];
    if (!citystring) {
        citystring = @"London";
    }
    NSLog(@"本地存储的城市=====%@",citystring);
    parameters[@"q"] = citystring;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    
    [manager GET: weatherURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
    
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:nil];
        
        self.homeModel = [BYWeatherModel weatherWithNowJson:jsonDic];
        
        self.dailyModelArray = [BYWeatherModel weatherFromJson:jsonDic isHourly:NO];
        

        //更新数据
        NSDictionary *homeModel = @{@"homeWeatherData":self.homeModel, @"dailyWeatherData":self.dailyModelArray};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherDataSource" object:nil userInfo:homeModel];
        
        [[NSUserDefaults standardUserDefaults] setObject:jsonDic forKey:@"weatherData"];


        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
        [SVProgressHUD showErrorWithStatus:@"Network connection failed!"];
        
    }];
    
    
    
}

@end
