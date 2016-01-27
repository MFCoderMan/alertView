//
//  MBManager.h
//  MBProgressDemo
//
//  Created by ZhangYunguang on 16/1/23.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

/**
 *  屏幕的宽度和高度
 *
 */
#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width


/**
 *  DEBUG模式下打印信息，RELEASE模式不打印
 *
 */

#ifdef DEBUG
#define kDLOG(FORMAT, ...) fprintf(stderr,"%s: %d\t  %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#define NSLog(...)  NSLog(__VA_ARGS__)
#else
#define kDLOG(...)
#define NSLog(...)
#endif


@interface MBManager : NSObject<MBProgressHUDDelegate>
/**
 *  只提示文字   在加载到的屏幕中央
 *
 *  @param title 要显示的文字
 *  @param view  要加载到的界面
 */
+(void)showAlertTextOnly:(NSString *)title inView:(UIView *)view;
/**
 *  展示alert
 *
 *  @param title 要显示的信息
 *  @param view  要加载到的界面
 */
+(void)showAlert:(NSString *)title inView:(UIView *)view;

/**
 *  自定义时间隐藏alert
 *
 *  @param title 要显示的信息
 *  @param delay 延迟的时间
 *  @param view  要加载到的界面
 */
+(void)showAlert:(NSString *)title after:(NSTimeInterval )delay inView:(UIView *)view;

/**
 *  隐藏alert
 */
+(void)hideAlert;

@end
