//
//  PinchLayout.h
//  PracticeDemo
//
//  Created by apple on 15/1/19.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PinchLayout : UICollectionViewFlowLayout

///0=堆在一起， 1=完全展开
@property (assign, nonatomic) CGFloat pinchScale;

@property (assign, nonatomic) CGPoint pinchCenter;
@end
