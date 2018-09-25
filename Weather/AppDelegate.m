//
//  AppDelegate.m
//  Weather
//
//  Created by Air.Zhao on 2018/7/17.
//  Copyright © 2018年 Yang. All rights reserved.
//

#import "AppDelegate.h"
#import "BYMainTabBarController.h"
#import "BYDetermine.h"
#import "BYMagicView.h"


@interface AppDelegate ()
@property (nonatomic, strong) BYMainTabBarController *mainTabBar;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BOOL determine = [BYDetermine magicTransformFormat];
    
    if (determine) {
        BYMainTabBarController *tabBar = [[BYMainTabBarController alloc] init];
        self.window.rootViewController = tabBar;
        self.mainTabBar = tabBar;
    }else {
        BYDetermine *determine = [[BYDetermine alloc] init];
        self.window.rootViewController = determine;
    }

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSString *cityData = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCAL_CITY_NAME"];
    
    if (!cityData) {
        [self.mainTabBar locate];
    }
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSString *cityData = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCAL_CITY_NAME"];
    
    if (cityData) {
        //        [self.mainTabBar locate];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"requestWeatherWithLocation" object:nil];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
