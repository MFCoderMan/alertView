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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  使用说明：
     *         1、引入头文件： #import "MBManager.h"
     *         2、遵守协议：   <MBProgressHUDDelegate>
     *         3、一句代码搞定提示信息
     *         4、只要轻触屏幕或者调用[MBManager hideAlert]，提示信息就会消失
     */
    
    NSArray *titles = @[@"自动消失",@"一直显示",@"提示"];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(100, 100 + 50*i, 60, 40);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = 11 +i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }

}
-(void)buttonClick:(UIButton *) button{
    switch (button.tag) {
        case 11:
        {
            [MBManager showAlert:@"自动消失" after:3 inView:self.view];
        }
            break;
        case 12:
        {
            [MBManager showAlert:@"loading..." inView:self.view];
            
            // 需要在需要的时刻调用 [MBManager hideAlert];  或者轻触屏幕
        }
            break;
        case 13:
        {
            [MBManager showAlertTextOnly:@"只显示文字" inView:self.view];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
