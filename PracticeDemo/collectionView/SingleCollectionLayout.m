//
//  SingleCollectionLayout.m
//  PracticeDemo
//
//  Created by apple on 15/1/17.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "SingleCollectionLayout.h"

@interface SingleCollectionLayout ()
{
    NSMutableArray *_deleteIndexPathsArr;
    NSMutableArray *_insertINdexPathsArr;
}
@end
@implementation SingleCollectionLayout

- (void)prepareLayout
{
    _deleteIndexPathsArr = [NSMutableArray new];
    _insertINdexPathsArr = [NSMutableArray new];
}

- (void)finalizeCollectionViewUpdates
{
    [_deleteIndexPathsArr removeAllObjects];
    [_insertINdexPathsArr removeAllObjects];
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionDelete:
                [_deleteIndexPathsArr addObject:updateItem.indexPathBeforeUpdate];
                break;
            case UICollectionUpdateActionInsert:
                [_insertINdexPathsArr addObject:updateItem.indexPathAfterUpdate];
                break;
            default:
                break;
        }
    }
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    if ([_insertINdexPathsArr containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        CGRect viRect = (CGRect){(CGPoint)self.collectionView.contentOffset, (CGSize)self.collectionView.bounds.size};
        attributes.alpha = 0;
        attributes.center = CGPointMake(CGRectGetMidX(viRect), CGRectGetMidY(viRect));
        attributes.transform3D = CATransform3DMakeTranslation(.6, .7, .6);
        
        return attributes;
    }else {
        return [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    }
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    if ([_deleteIndexPathsArr containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:itemIndexPath];
        CGRect viRect = (CGRect){(CGPoint)self.collectionView.contentOffset, (CGSize)self.collectionView.bounds.size};
        attributes.alpha = 0;
        attributes.center = CGPointMake(CGRectGetMidX(viRect), CGRectGetMidY(viRect));
        attributes.transform3D = CATransform3DMakeScale(1.3, 1.3, 1);
        return attributes;
    }else {
        return [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    }
}
@end
