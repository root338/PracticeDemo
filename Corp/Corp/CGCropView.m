//
//  CGCropView.m
//  Corp
//
//  Created by 345 on 15/2/2.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CGCropView.h"

@implementation CGCropView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.screenshotUncheckAreaColor = [UIColor colorWithWhite:0 alpha:.6];
        
    }
    return self;
}

- (void)setCropSize:(CGSize)cropSize
{
    if (!CGSizeEqualToSize(_cropSize, cropSize)) {
        _cropSize = cropSize;
        self.currentShowAreaCropView = (CGRect){self.currentShowAreaCropView.origin, _cropSize};
    }
}

- (void)setCurrentShowAreaCropView:(CGRect)currentShowAreaCropView
{
    if (!CGRectEqualToRect(currentShowAreaCropView, _currentShowAreaCropView)) {
        _currentShowAreaCropView = currentShowAreaCropView;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
//    CGFloat width = self.cropSize.width, height = self.cropSize.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGContextAddRect(context, self.bounds);
    [self.screenshotUncheckAreaColor setStroke];
    [self.screenshotUncheckAreaColor setFill];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGRect availableRect = self.bounds;
    if ([self.delegate respondsToSelector:@selector(setupAvailableAreaCropView:)]) {
        availableRect = [self.delegate setupAvailableAreaCropView:self];
    }
    
    CGContextAddRect(context, _currentShowAreaCropView);
    [[UIColor clearColor] setStroke];
    [[UIColor clearColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
