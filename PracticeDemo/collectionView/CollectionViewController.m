//
//  CollectionViewController.m
//  PracticeDemo
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "SingleCollectionLayout.h"

@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";


//- (UIImage *)createImage:(UIColor *)bgColor
//{
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    UIGraphicsBeginImageContext(CGSizeMake(100, 80));
//    [bgColor setFill];
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(0, 0, 100, 80));
//    CGContextDrawPath(context, kCGPathFill);
//    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
    
//    return newImg;
//}

- (void)addDataSources
{
    _dataSource = [NSMutableArray new];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityView.autoresizingMask = UIViewAutoresizingFlexibleB
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:activityView];
    activityView.frame = CGRectMake(0, 0, activityView.bounds.size.width, activityView.bounds.size.height);
    self.navigationItem.rightBarButtonItem = item;
    [activityView startAnimating];
    
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
        dispatch_sync(global, ^{
            for (CGFloat i = .1; i <= 1; i+=.1) {
                for (CGFloat j = .1; j <= 1; j+=.2) {
                    for (CGFloat k = .0; k <= 1; k+=.15) {
                        [_dataSource addObject:[UIColor colorWithRed:i green:j blue:k alpha:1]];
                    }
                }
            }
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [activityView stopAnimating];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    SingleCollectionLayout *single = [[SingleCollectionLayout alloc] init];
    self.collectionView.collectionViewLayout = single;
    // Register cell classes
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self addDataSources];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.imageView.backgroundColor = _dataSource[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_dataSource removeObjectAtIndex:indexPath.row];
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
//    [_dataSource addObject:_dataSource[0]];
//    [collectionView insertItemsAtIndexPaths:@[indexPath]];
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
