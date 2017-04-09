//
//  ViewController.m
//  MBProgressDemo
//
//  Created by hungryBoy on 16/1/23.
//  Copyright © 2016年 hungryBoy. All rights reserved.
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
     *         4、在app的window还没有加载出来时使用不指定view的方法会显示不出来，解决方法为选择制定view的方法:如[MBManger showLoadingInView:self.view];
     */
    
#if 1
        [MBManager showAlertWithCustomImage:@"test" title:@"测试" inView:self.view];
#else
        [MBManager showAlertWithCustomImage:@"test" title:@"测试"];//若运行此方法会发现提示框并没有加载出来
#endif
}
- (IBAction)showLoading:(id)sender {
    [MBManager showLoading];
}
- (IBAction)showLoadingInView:(id)sender {
    [MBManager showLoadingInView:self.view];
}
- (IBAction)showWaitingTitle:(id)sender {
    [MBManager showWaitingWithTitle:@"我是自定义"];
}
- (IBAction)showWatingTitleInView:(id)sender {
    [MBManager showWaitingWithTitle:@"我是自定义：self.view" inView:self.view];
}
- (IBAction)showBriefAlert:(id)sender {
    [MBManager showBriefAlert:@"简短提示"];
}
- (IBAction)showBrieftAlertInView:(id)sender {
    [MBManager showBriefAlert:@"简短提示：self.view" inView:self.view];
}
- (IBAction)showPermenent:(id)sender {
    [MBManager showPermanentAlert:@"一直显示"];
}
- (IBAction)showPermenentInView:(id)sender {
    [MBManager showPermanentMessage:@"一直显示：self.view" inView:self.view];
}
- (IBAction)showCustomeImage:(id)sender {
    [MBManager showAlertWithCustomImage:@"test" title:@"我是title"];
}
- (IBAction)showCustomeImageInView:(id)sender {
    [MBManager showAlertWithCustomImage:@"test" title:@"我是title:self.view" inView:self.view];
}






@end
