//
//  ViewController.m
//  Corp
//
//  Created by 345 on 15/1/29.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "ViewController.h"
#import "CGCropImage.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
    UITableView *tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CGCropImage *cropImage= [[CGCropImage alloc] initWithFrame:self.view.bounds];
////    cropImage.isAutoImageViewContentMode = YES;
//    cropImage.image = [UIImage imageNamed:@"1.jpg"];
//    self.view = cropImage;
    
    CALayer *testImageLayer = [CALayer layer];
    testImageLayer.frame = CGRectMake(0, 0, 200, 180);
    testImageLayer.position = self.view.center;
    
    [self.view.layer addSublayer:testImageLayer];
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    
    //设置为图层添加图片，桥接CGImage使其满足类型需求
    testImageLayer.contents = (__bridge id)image.CGImage;
    
    //设置图层图片的显示方式
    testImageLayer.contentsGravity = kCAGravityResizeAspect;//kCAGravityCenter;
    
    //表示每个点多少像素点,当contentsGravity 属性设置拉伸图片的属性值时无效, 例如：kCAGravityResizeAspect属性
//    testImageLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //设置图片的显示区域内容，这里和frame不一样，是相对于图片来说
    testImageLayer.contentsRect = CGRectMake(0, 0, 1, 1);
    
    testImageLayer.backgroundColor = [UIColor blueColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
