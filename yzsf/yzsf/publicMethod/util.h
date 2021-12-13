//
//  util.h
//  yzsf
//
//  Created by 卿伟明 on 2021/11/25.
//

#import <Foundation/Foundation.h>
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN
//#if DEBUG
//#define NSLog(format, ...) do {                                             \
//fprintf(stderr, "<%s : %d> %s\n",                                           \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent]   UTF8String],  \
//__LINE__, __func__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                           \
//fprintf(stderr, "---------------------\n");                               \
//} while (0)
//#else
//#define NSLog(FORMAT, ...) nil
//#endif

#ifdef DEBUG
#define LLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LLog(...) NSLog(FORMAT, ...) nil
#endif

//[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:format options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];

//设备的宽高
#define SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT      [UIScreen mainScreen].bounds.size.height

//设备状态栏和导航栏的高度（是否有刘海屏）
#define isIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
    if (!UIEdgeInsetsEqualToEdgeInsets([util getCurrentWindow].safeAreaInsets, UIEdgeInsetsZero)) {\
    isPhoneX = YES;\
    }\
}\
isPhoneX;\
})

#define navigationBarHeight (isIphoneX ? 92.f : 64.f)

#define safeAreaInsetsBottom [[[UIApplication sharedApplication] windows] objectAtIndex:0].safeAreaInsets.bottom

#define sRGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define sRGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define sRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define sRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


@interface util : NSObject

// 展示loading图
+ (void)showLoading;
// 移除loading图
+ (void)dismissLoading;

/**
 展示可控制用户交互的loading图

 @param isEnable 是否允许用户交互
 */
+ (void)showLoadingWithEnableUserInteraction:(BOOL)isEnable;

/**
 展示可控制用户交互并且带说明信息的loading图

 @param message 说明信息
 @param isEnable 是否允许用户交互
 */
+ (void)showLoadingWithMessage:(NSString *)message enableUserInteraction:(BOOL)isEnable;

//获取当前的window
+(UIWindow*)getCurrentWindow;
@end

NS_ASSUME_NONNULL_END
