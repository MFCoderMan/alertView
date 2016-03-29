//
//  MBManager.h
//  MBProgressDemo

/********************************************
 *                                          *
 *   版权属于原作者                           *
 *   https://github.com/hungryBoy/alertView *
 *   Authour: hungryBoy                     *
 *   mail:    zhangyunguang_13@sina.cn      *
 *                                          *
 ********************************************
 */
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
 *  显示简短提示语到view上
 *
 *  @param message 提示语
 *  @param view    要添加到的view
 */
+ (void) showBriefMessage:(NSString *) message InView:(UIView *) view;
/**
 *  显示长久的（只要不用手触摸屏幕或者调用hideAlert方法就会一直显示）提示语到view上
 *
 *  @param message 提示语
 *  @param view    要添加到的view
 */
+ (void) showPermanentMessage:(NSString *)message InView:(UIView *) view;
/**
 *  显示网络加载到view上
 *
 *  @param view 要添加到的view
 */
+ (void) showLoadingInView:(UIView *) view;

@end
