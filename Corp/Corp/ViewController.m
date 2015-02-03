//
//  ViewController.m
//  Corp
//
//  Created by 345 on 15/1/29.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "ViewController.h"
#import "CGCropImage.h"

@interface ViewController ()
{
    UITableView *tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CGZoomScrollView *cropImage= [[CGZoomScrollView alloc] initWithFrame:self.view.bounds];
    CGCropImage *cropImage= [[CGCropImage alloc] initWithFrame:self.view.bounds];
//    cropImage.isAutoImageViewContentMode = YES;
    cropImage.image = [UIImage imageNamed:@"2.jpg"];
    self.view = cropImage;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
