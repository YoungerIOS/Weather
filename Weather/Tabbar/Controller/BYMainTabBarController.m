//
//  BYMainTabBarController.m
//  Weather
//
//  Created by young on 2018/7/23.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "BYMainTabBarController.h"
#import "BYHomeViewController.h"
#import "BYHourlyViewController.h"
#import "BYDailyViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "UIColor+FJColor.h"

@interface BYMainTabBarController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *currentCityName;

@end

@implementation BYMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = Tint_COLOR;
    
    //创建初始化子控制器
    [self  initializeChildViewControllers];
    
    [self locate];
    

}

- (void)initializeChildViewControllers {
    
    BYHomeViewController *home = [[BYHomeViewController alloc] init];
    [self  setUpChildViewController:home title:@"Now" image:@"tab_now" selectedImage:@"tab_now_selected"];
    
    BYHourlyViewController *hourly = [[BYHourlyViewController alloc] init];
    [self setUpChildViewController:hourly title:@"Hourly" image:@"tab_hourly" selectedImage:@"tab_hourly_selected"];
    
    BYDailyViewController *daily = [[BYDailyViewController alloc] init];
    [self setUpChildViewController:daily title:@"Daily" image:@"tab_daily" selectedImage:@"tab_daily_selected"];
    
    
    
    
}

- (void)setUpChildViewController:(UIViewController *) viewController title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName {
    
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:viewController];
    
    
    
    
}

#pragma mark -- 定位城市
- (void)locate {
    
    //判断定位是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        //设置定位精确度到千米
        self.locationManager.desiredAccuracy=kCLLocationAccuracyKilometer;
        // 设置过滤器为无
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        //ios8以上版本需要使用
        if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
            [ self.locationManager requestWhenInUseAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
        
    }else {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
            
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please go to Settings - Privacy - Location to open the location service!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
            }];
            
            [alertVC addAction:confirm];
        
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }
    }
}


#pragma mark -- CLLocationManagerDelegate
//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Tips" message:@"Please turn on location service in Settings" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *open = [UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{}   completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertView addAction:open];
    [alertView addAction:cancel];
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self presentViewController:alertView animated:YES completion:nil];
    });
    
    
}

//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject]; // 最后一个值为最新位置
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向得出位置城市信息
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self.currentCityName = placeMark.locality;
            // ? placeMark.locality : placeMark.administrativeArea;
            
            NSLog(@"定位到城市----%@---%@",placeMark,self.currentCityName);
            if (!self.currentCityName) {
                self.currentCityName = NSLocalizedString(@"home_cannot_locate_city", comment:@"Unable to locate current city");
            }else{
                
                [[NSUserDefaults standardUserDefaults] setObject:self.currentCityName forKey:@"LOCAL_CITY_NAME"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"requestWeatherWithLocation" object:nil];
            }
            
        }
        
        [manager stopUpdatingLocation];
        
        
    }];
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
