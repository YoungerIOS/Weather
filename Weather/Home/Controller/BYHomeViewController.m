//
//  BYHomeViewController.m
//  Weather
//
//  Created by young on 2018/7/23.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYHomeViewController.h"
#import "BYHomeHeaderView.h"
#import "BYWeatherModel.h"
#import "UIImageView+WebCache.h"
#import "BYBaseViewController.h"
#import "BYWeatherDataRequest.h"
#import "UIColor+FJColor.h"
#import "MJRefresh.h"


@interface BYHomeViewController ()<UIAlertViewDelegate>

//背景图片
@property (nonatomic, strong) UIImageView *backgroundImageView;

//头视图
@property (nonatomic, strong) BYHomeHeaderView *homeView;



@end

@implementation BYHomeViewController



- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setUpHomeView];
    
    //监听定位数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestWeather) name:@"requestWeatherWithLocation" object:nil];
    
    //监听天气数据请求
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHomeView:) name:@"weatherDataSource" object:nil];
    
    //下拉刷新
    [self refreshData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.homeView.humidityView setNeedsDisplay];
    [self.homeView.humidityView showTheAnimations];
    [self.homeView.windSpeedView showTheAnimatons];
    [self.homeView.tempMinMaxView showTheAnimations];
    
}


- (void)setUpHomeView {
    
    BYHomeHeaderView *header = [[BYHomeHeaderView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    header.backgroundColor = [UIColor whiteColor];
    self.homeView = header;
    
    [self.view addSubview:header];

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = Tint_COLOR;
    }
    

}

- (void)refreshData {
    __weak __typeof(self) weakSelf = self;
    self.homeView.homeScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestWeather];
    }];
    
}

- (void)requestWeather {
    
    BYWeatherDataRequest *request = [[BYWeatherDataRequest alloc] init];
    [request getJsonFromURL];
    [self.homeView.homeScrollView.mj_header endRefreshing];
}

- (void)updateHomeView:(id)sender {
    
    BYWeatherModel *model = [[sender userInfo] objectForKey:@"homeWeatherData"];
    
    self.homeView.cityLabel.text = model.cityName;
    self.homeView.conditionLabel.text = model.weatherDesc;
    self.homeView.temperatureLabel.text = [NSString stringWithFormat:@"%.0f˚C",model.temp];

    self.homeView.humidityView.humidity = model.humidity;
    NSLog(@"湿度是------%f",model.humidity);

    [self.homeView.humidityView showTheAnimations];
    [self.homeView.humidityView setNeedsDisplay];
    
    self.homeView.sunRiseSetView.sunLabel.text = model.sunrise;
    self.homeView.sunRiseSetView.moonLabel.text = model.sunset;
    
    self.homeView.windSpeedView.windspeed = model.windspeedKmph;
    [self.homeView.windSpeedView showTheAnimatons];//需要刷新风扇转速
    self.homeView.windSpeedView.windspeedLabel.text = [NSString stringWithFormat:@"%.f Kmph",model.windspeedKmph];

    NSArray *daily = [[sender userInfo] objectForKey:@"dailyWeatherData"];
    BYWeatherModel *tempModel = daily[0];
    self.homeView.hiloLabel.text = [NSString stringWithFormat:@"%.0f˚C/%.0f˚C",tempModel.maxTemp,tempModel.minTemp];
 
    
    self.homeView.tempMinMaxView.feellikeTemp = model.feellikeTemp;
    self.homeView.tempMinMaxView.minTemp = tempModel.minTemp;
    self.homeView.tempMinMaxView.maxTemp = tempModel.maxTemp;
    [self.homeView.tempMinMaxView showTheAnimations];
    
    self.homeView.tempMinMaxView.minLabel.text = [NSString stringWithFormat:@"%.f˚",tempModel.minTemp];
    self.homeView.tempMinMaxView.maxLabel.text = [NSString stringWithFormat:@"%.f˚",tempModel.maxTemp];
    self.homeView.tempMinMaxView.feelLabel.text = [NSString stringWithFormat:@"%.f˚",model.feellikeTemp];

    
//    [self.homeView.iconView sd_setImageWithURL:[NSURL URLWithString:tempModel.iconURLStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [self.homeView.iconView setImage:[UIImage imageNamed:tempModel.iconName]];
    
}


-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"requestWeatherWithLocation" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"weatherDataSource" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
