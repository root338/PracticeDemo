//
//  CGCropView.h
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGCropView;
@protocol CGCropViewDelegate <NSObject>

@optional

/**
 *  设置截取框的可用显示区域
 *
 *  @param cropView 当前截取框的对象
 *
 *  @return 返回设置的可用区域
 */
- (CGRect)setupAvailableAreaCropView:(CGCropView *)cropView;

/**
 *  当前截取框的显示区域
 *
 *  @param cropView 当前截取框的对象
 *  @param cropRect 当前截取框的显示区域
 */
- (void)cropView:(CGCropView *)cropView currentCropRect:(CGRect)cropRect;
@end

@interface CGCropView : UIView

/**
 *  代理对象
 */
@property (weak, nonatomic) id<CGCropViewDelegate> delegate;

/**
 *  截图的显示区域
 */
@property (assign, nonatomic) CGSize cropSize;

/**
 *  截图未选中区域的背景色
 *  
 *  默认颜色为 黑色 透明度 0.6
 */
@property (strong, nonatomic) UIColor *screenshotUncheckAreaColor;

/**
 *  当前截取框的显示区域
 */
@property (assign, nonatomic) CGRect currentShowAreaCropView;
@end
