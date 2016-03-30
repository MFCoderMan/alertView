//
//  ViewController.m
//  MBProgressDemo
//
//  Created by ZhangYunguang on 16/1/23.
//  Copyright © 2016年 ZhangYunguang. All rights reserved.
//

#import "ViewController.h"
#import "MBManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  使用说明：
     *         1、引入头文件： #import "MBManager.h"
     *         2、一句代码搞定提示信息
     *         3、只要轻触屏幕或者调用[MBManager hideAlert]，提示信息就会消失
     */

}


- (IBAction)showTextOnly:(UIButton *)sender {
    [MBManager showBriefMessage:@"提示语" InView:self.view];
}
- (IBAction)showStill:(UIButton *)sender {
#if 0
    [MBManager showPermanentAlert:@"一直显示"];
#else
    [MBManager showPermanentMessage:@"一直显示" InView:self.backView];
#endif
}

- (IBAction)showDelay:(UIButton *)sender {
#if 1
    [MBManager showLoading];
#else
    [MBManager hideAlert];
    [MBManager showBriefAlert:@"hello"];
#endif
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
