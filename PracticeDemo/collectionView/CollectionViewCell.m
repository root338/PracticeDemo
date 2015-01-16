//
//  CollectionViewCell.m
//  PracticeDemo
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (UIImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    return _imageView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
