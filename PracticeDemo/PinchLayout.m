//
//  PinchLayout.m
//  PracticeDemo
//
//  Created by apple on 15/1/19.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "PinchLayout.h"

@implementation PinchLayout

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self applySettingToAttributes:attributes];
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributeses = [super layoutAttributesForElementsInRect:rect];
    [attributeses enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * obj, NSUInteger idx, BOOL *stop) {
        [self applySettingToAttributes:obj];
    }];
    return attributeses;
}

- (void)applySettingToAttributes:(UICollectionViewLayoutAttributes *)attributes
{
    //
    NSIndexPath *indexPath = attributes.indexPath;
    attributes.zIndex = -indexPath.item;
    
    //
    CGFloat deltaX = self.pinchCenter.x - attributes.center.x;
    CGFloat deltaY = self.pinchCenter.y - attributes.center.y;
    CGFloat scale = 1.0 - self.pinchScale;
    
    //2
    CATransform3D transform = CATransform3DMakeTranslation(deltaX * scale,
                                                            deltaY * scale,
                                                            0.0f);
    attributes.transform3D = transform;
}

- (void)setPinchCenter:(CGPoint)pinchCenter
{
    _pinchCenter = pinchCenter;
    [self invalidateLayout];
}

- (void)setPinchScale:(CGFloat)pinchScale
{
    _pinchScale = pinchScale;
    [self invalidateLayout];
}
@end
