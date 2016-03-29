//
//  MBManager.h
//  MBProgressDemo
//
//  Created by ZhangYunguang on 16/1/23.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

static NSString *const kLoadingMessage = @"加载中";
static CGFloat const   kShowTime  = 2.0f;

@interface MBManager : NSObject

/**
 *  是否显示变淡效果，默认为YES，  PS：只为 showPermanentAlert:(NSString *) alert 和 showLoading 方法添加
 */
@property (nonatomic, assign) BOOL isShowGloomy;
/**
 *  显示“加载中”，待圈圈，若要修改直接修改kLoadingMessage的值即可
 */
+ (void) showLoading;
/**
 *  一直显示自定义提示语，不带圈圈
 *
 *  @param alert 提示信息
 */
+ (void) showPermanentAlert:(NSString *) alert;
/**
 *  显示简短的提示语，默认2秒钟，时间可直接修改kShowTime
 *
 *  @param alert 提示信息
 */
+ (void) showBriefAlert:(NSString *) alert;
/**
 *  隐藏alert
 */
+(void)hideAlert;


/***************************************
 *                                     *
 *  以下方法根据情况可选择使用，一般使用不到  *
 *                                     *
 ***************************************
 */




/**
 *  只提示文字   在加载到view中央
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



@end
