//
//  MBManager.m
//  MBProgressDemo
//
//  Created by ZhangYunguang on 16/1/23.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "MBManager.h"

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width

@interface MBManager ()<UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
}
@end

@implementation MBManager
UIView *bottomView;
static MBManager *hudManager = nil;
UIView *hudAddedView;

#pragma mark - 初始化
-(instancetype)init{
    if (self = [super init]) {
        [self initBackView];
        self.isShowGloomy = YES;
    }
    return self;
}
#pragma mark - 初始化深色背景
-(void)initBackView{
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.5;
    bottomView.hidden = YES;
}
#pragma mark - 单例
+(instancetype )shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudManager = [[self alloc] init];
    });
    return hudManager;
}
#pragma mark - 简短提示语
+ (void) showBriefMessage:(NSString *) message InView:(UIView *) view{
    hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    //HUD.yOffset = 200;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kShowTime];
    [hudManager addGestureInView:view];
}
#pragma mark - 长时间的提示语
+ (void) showPermanentMessage:(NSString *)message InView:(UIView *) view{
    hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    if (hudManager.isShowGloomy) {
        //如果添加了view则将botomView的frame修改与view一样大
        if (hudAddedView) {
            bottomView.frame = CGRectMake(0, 0, hudAddedView.frame.size.width, hudAddedView.frame.size.height);
        }
        [view addSubview:bottomView];
        [hudManager showBackView];
    }
    [view bringSubviewToFront:hud];
    [hudManager addGestureInView:view];
}
#pragma mark - 网络加载提示用
+ (void) showLoadingInView:(UIView *) view{
    hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText = kLoadingMessage;
    hud.removeFromSuperViewOnHide = YES;
    if (hudManager.isShowGloomy) {
        //如果添加了view则将botomView的frame修改与view一样大
        if (hudAddedView) {
            bottomView.frame = CGRectMake(0, 0, hudAddedView.frame.size.width, hudAddedView.frame.size.height);
        }
        [view addSubview:bottomView];
        [hudManager showBackView];
    }
    [view addSubview:hud];
    [hud show:YES];
    [hudManager addGestureInView:view];
}
+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title inView:(UIView *)view{
    hudAddedView = view;
    [self shareManager];
    if (view == nil) {
        view = [[UIApplication sharedApplication]windows].lastObject;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
    littleView.image = [UIImage imageNamed:imageName];
    hud.customView = littleView;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.mode = MBProgressHUDModeCustomView;
    [hud show:YES];
    [hud hide:YES afterDelay:kShowTime];
    [hudManager addGestureInView:view];
}
#pragma mark - 外部调用
+(void)showLoading{
    [self showLoadingInView:nil];
}
+(void)showBriefAlert:(NSString *)alert{
    [self showBriefMessage:alert InView:nil];
}
+(void)showPermanentAlert:(NSString *)alert{
    [self showPermanentMessage:alert InView:nil];
}
//+(void)showAlertWithCustomImage:(NSString *)imageName title:(NSString *)title{
//    [self showAlertWithCustomImage:imageName title:title inView:nil];
//}
#pragma mark - 隐藏提示框
+(void)hideAlert{
    [hudManager hideBackView];
    UIView *view ;
    if (hudAddedView) {
        view = hudAddedView;
    }else{
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view];
}
+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:animated];
        return YES;
    }
    return NO;
}
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}
#pragma mark - 深色背景
-(void)showBackView{
    bottomView.hidden = NO;
}
-(void)hideBackView{
    bottomView.hidden = YES;
    [tap removeTarget:nil action:nil];
    bottomView.frame = CGRectMake(0, 0, kScreen_width, kScreen_height);
}

#pragma mark - 添加手势,触摸屏幕将提示框隐藏
-(void)addGestureInView:(UIView *)view{
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheScreen)];
    tap.delegate = self;
    [view addGestureRecognizer:tap];
        
}
#pragma mark -点击屏幕
-(void)tapTheScreen{
    NSLog(@"点击屏幕");
    [hudManager hideBackView];
    [tap removeTarget:nil action:nil];
    [MBManager hideAlert];
}
#pragma mark - 解决手势冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[MBProgressHUD class]]) {
        return YES;
    }else{
        return NO;
    }
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end
