//
//  ViewController.m
//  MBProgressDemo
//
//  Created by ZhangYunguang on 16/1/23.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "ViewController.h"
#import "MBManager.h"

@interface ViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if 0
    [MBManager showAlert:@"zidongxiaoshi" after:3 inView:self.view];
#elif 0
    [MBManager showAlert:@"hello" inView:self.view];
    
    // 需要在需要的时刻调用 [MBManager hideAlert];
#elif 1
    [MBManager showAlertTextOnly:@"只显示文字" inView:self.view];
#endif

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
