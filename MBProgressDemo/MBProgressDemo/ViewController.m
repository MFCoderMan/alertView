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
    
//    NSArray *titles = @[@"自动消失",@"一直显示",@"提示"];
//    for (int i=0; i<3; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.frame = CGRectMake(100, 100 + 50*i, 60, 40);
//        [button setTitle:titles[i] forState:UIControlStateNormal];
//        button.tag = 111 +i;
//        NSLog(@"%d",(int)button.tag);
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:button];
//    }

}
//-(void)buttonClick:(UIButton *) button{
//    switch (button.tag) {
//        case 111:
//        {
//            [MBManager showAlert:@"自动消失" after:3 inView:self.view];
//        }
//            break;
//        case 112:
//        {
//            [MBManager showAlert:@"loading..." inView:self.view];
//            
//            // 需要在需要的时刻调用 [MBManager hideAlert];  或者轻触屏幕
//        }
//            break;
//        case 113:
//        {
//            [MBManager showAlertTextOnly:@"只显示文字" inView:self.view];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}

- (IBAction)showTextOnly:(UIButton *)sender {
   // [MBManager showAlertTextOnly:@"自动消失" inView:self.view];
    [MBManager showBriefMessage:@"提示语" InView:self.view];
}
- (IBAction)showStill:(UIButton *)sender {
//    [MBManager showAlert:@"loading..." inView:self.view];
//    [MBManager hideAlert];
//    [MBManager showAlertTextOnly:@"自动消失" inView:self.view];
 //   [MBManager showPermanentAlert:@"一直显示"];
    [MBManager showPermanentMessage:@"一直显示" InView:self.backView];
}

- (IBAction)showDelay:(UIButton *)sender {
  //  [MBManager showAlert:@"自动消失" after:3 inView:self.view];
    [MBManager showLoading];
//    [MBManager hideAlert];
//    [MBManager showBriefAlert:@"hello"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
