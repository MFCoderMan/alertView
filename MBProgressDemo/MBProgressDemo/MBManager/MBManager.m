//
//  MBManager.m
//  MBProgressDemo
//
//  Created by ZhangYunguang on 16/1/23.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "MBManager.h"

@interface MBManager ()
{
    UIView *bottomView;
    UIView *showView;
    UIView *addedView;
}
@end

@implementation MBManager
MBProgressHUD *HUD;
static MBManager *hudManager = nil;

-(instancetype)init{
    if (self = [super init]) {
        [self initBackView];
    }
    return self;
}
#pragma mark - 初始化深色背景
-(void)initBackView{
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.5;
    showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
    showView.backgroundColor = [UIColor clearColor];
    bottomView.hidden = YES;
    showView.hidden = YES;
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
    [hudManager hideBackView];
}
#pragma mark - 深色背景
-(void)showBackView{
    bottomView.hidden = NO;
    showView.hidden = NO;
}
-(void)hideBackView{
    bottomView.hidden = YES;
    showView.hidden = YES;
}
#pragma mark - 私有方法
-(void)showAlertTextOnly:(NSString *)title inView:(UIView *)view{
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
    addedView = view;
    [view addSubview:bottomView];
    [view addSubview:HUD];
    [self showBackView];
   // HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = title;
    [HUD show:YES];
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

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

#pragma mark - 添加手势,触摸屏幕将提示框隐藏
-(void)addGestureInView:(UIView *)view{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheScreen)];
    [view addGestureRecognizer:tap];
}
#pragma mark -点击屏幕
-(void)tapTheScreen{
    [HUD hide:YES];
    [hudManager hideBackView];
}


@end
