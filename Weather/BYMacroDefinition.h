//
//  BYMacroDefinition.h
//  Weather
//
//  Created by young on 2018/7/28.
//  Copyright © 2018年 Yang. All rights reserved.
//

#ifndef BYMacroDefinition_h
#define BYMacroDefinition_h

//是否为iPhoneX
#define isIPhoneX   [[UIScreen mainScreen] bounds].size.width == 375.f && [[UIScreen mainScreen] bounds].size.height == 812.f

//区分选择iPhoneX与其他型号iPhone
#define iPhoneX_Or_OtherIPhones(A,B)    ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); isIPhoneX ? __a : __b; })

//屏幕宽高
#define ScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height

//TabBar高度
#define TabBarHeight    iPhoneX_Or_OtherIPhones(83.f,49.f)

//NavBar高度(包含StatusBar)
#define NavBarHeight    iPhoneX_Or_OtherIPhones(88.f,64.f)

//StatusBar高度
#define StatusBarHeight     iPhoneX_Or_OtherIPhones(44.f,20.f)

//十六进制色号
#define ssRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//屏幕适配
//适配
#define W(float) [UIView setWidth:(float)]
#define H(float) [UIView setHeight:(float)]


#define DefineSize(float) (float  1.15 / 3.0)  320.f / 414.f

#define F(float) [UIFont SHSystemFontOfSize:float/(96/72)]

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define kNavigationBarHeight (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define kMarginTopHeight (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define kTabBarHeight (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)




#endif /* BYMacroDefinition_h */
