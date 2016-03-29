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

@interface MBManager ()
{
    
//    UIView *showView;
    UITapGestureRecognizer *tap;
}
@end

@implementation MBManager
MBProgressHUD *HUD;
UIView *bottomView;
static MBManager *hudManager = nil;


-(instancetype)init{
    if (self = [super init]) {
        [self initBackView];
        self.isShowGloomy = YES;
    }
    return self;
}

+ (void) showBriefMessage:(NSString *) message InView:(UIView *) view{
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
+ (void) showPermanentMessage:(NSString *)message InView:(UIView *) view{
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    if (hudManager.isShowGloomy) {
        [view addSubview:bottomView];
        [hudManager showBackView];
    }
    [view bringSubviewToFront:hud];
    [hudManager addGestureInView:view];
}
+ (void) showLoadingInView:(UIView *) view{
    if (view == nil) {
        view = [[UIApplication sharedApplication] windows].lastObject;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText = @"加载中";
    hud.removeFromSuperViewOnHide = YES;
    if (hudManager.isShowGloomy) {
        [view addSubview:bottomView];
        [hudManager showBackView];
    }
    [view addSubview:hud];
    [hud show:YES];
    [hudManager addGestureInView:view];
}
+(void)showLoading{
    [self shareManager];
    [self showLoadingInView:nil];
}
+(void)showBriefAlert:(NSString *)alert{
    [self shareManager];
    [self showBriefMessage:alert InView:nil];
}
+(void)showPermanentAlert:(NSString *)alert{
    [self shareManager];
    [self showPermanentMessage:alert InView:nil];
}







#pragma mark - 初始化深色背景
-(void)initBackView{
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.5;
//    showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
//    showView.backgroundColor = [UIColor clearColor];
    bottomView.hidden = YES;
//    showView.hidden = YES;
}
+(instancetype )shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hudManager = [[self alloc] init];
    });
    return hudManager;
}
#pragma mark - 外部直接调用的类方法
+(void)showAlertTextOnly:(NSString *)title inView:(UIView *)view{
    [MBManager shareManager];
    [hudManager showAlertTextOnly:title inView:view];
}
+(void)showAlert:(NSString *)title inView:(UIView *)view{
    [MBManager shareManager];
    [hudManager showAlert:title inView:view];
}
+(void)showAlert:(NSString *)title after:(NSTimeInterval)delay inView:(UIView *)view{
    [MBManager shareManager];
    [hudManager showAlert:title after:delay inView:view];
}
#pragma mark - 隐藏提示框
+(void)hideAlert{
    [HUD hide:YES];
    [HUD removeFromSuperViewOnHide];
    [hudManager hideBackView];
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
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
//    showView.hidden = NO;
}
-(void)hideBackView{
    bottomView.hidden = YES;
//    showView.hidden = YES;
    [tap removeTarget:nil action:nil];
}
#pragma mark - 私有方法
-(void)showAlertTextOnly:(NSString *)title inView:(UIView *)view{
    view = [[UIApplication sharedApplication] windows].lastObject;
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = title;
    HUD.margin = 10.f;
    //HUD.yOffset = 200;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:2];
    [self addGestureInView:view];
}
-(void)showAlert:(NSString *)title inView:(UIView *)view{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:bottomView];
    [view addSubview:HUD];
    [self showBackView];
   // HUD.dimBackground = YES;
    HUD.labelText = title;
    [HUD show:YES];
    [view bringSubviewToFront:HUD];
    [self addGestureInView:view];
}
-(void)showAlert:(NSString *)title after:(NSTimeInterval)delay inView:(UIView *)view{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = title;
    [HUD show:YES];
    [HUD hide:YES afterDelay:delay];
    [self addGestureInView:view];
}

#pragma mark - 添加手势,触摸屏幕将提示框隐藏
-(void)addGestureInView:(UIView *)view{
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheScreen)];
    [view addGestureRecognizer:tap];
        
}
#pragma mark -点击屏幕
-(void)tapTheScreen{
    NSLog(@"点击屏幕");
    [HUD hide:YES];
    [hudManager hideBackView];
    [tap removeTarget:nil action:nil];
    [MBManager hideAlert];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"PKProductMainListTableViewCellContentView"]) {
        return NO;
    }
    if ([touch.view isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end
