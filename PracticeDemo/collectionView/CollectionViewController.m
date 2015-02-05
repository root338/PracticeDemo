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
#import "PinchLayout.h"

static const CGFloat kMinScale = 1.0f;
static const CGFloat kMaxScale = 3.0f;

@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UIPinchGestureRecognizer *pinchOutGestureRecognizer;

@property (strong, nonatomic) UICollectionView *currentPinchCollectionView;

@property (strong, nonatomic) NSIndexPath *currentPinchedItem;
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


- (void)handlePinchOutGeture:(UIPinchGestureRecognizer *)recognizer
{
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 2 获取缩放发生的点
        CGPoint pinchPoint = [recognizer locationInView:self.collectionView];
        NSIndexPath *pinchItem = [self.collectionView indexPathForItemAtPoint:pinchPoint];
        
        if (pinchItem) {
            // 3
            self.currentPinchedItem = pinchItem;
            
            // 4 设置一个新的缩放布局，初始化缩放大小为0
            PinchLayout *layout = [[PinchLayout alloc] init];
            layout.itemSize = CGSizeMake(200, 200);
            layout.minimumInteritemSpacing = 20;
            layout.minimumLineSpacing = 20;
            layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
            layout.headerReferenceSize = CGSizeMake(0, 90);
            layout.pinchScale = 0;
            
            // 5
            self.currentPinchCollectionView = [[UICollectionView alloc] initWithFrame:self.collectionView.frame collectionViewLayout:layout];
            self.currentPinchCollectionView.backgroundColor = [UIColor clearColor];
            self.currentPinchCollectionView.delegate = self;
            self.currentPinchCollectionView.dataSource = self;
            self.currentPinchCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.currentPinchCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
            
            // 6
            [self.view addSubview:self.currentPinchCollectionView];
            
            // 7
            UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchInGesture:)];
            [_currentPinchCollectionView addGestureRecognizer:recognizer];
        }
    } else if(recognizer.state == UIGestureRecognizerStateChanged) {
        if (_currentPinchedItem) {
            // 8
            CGFloat theScale = recognizer.scale;
            theScale = MAX(MIN(theScale, kMaxScale), kMinScale);
            
            // 9
            CGFloat theScalePct = (theScale - kMinScale) / (kMaxScale - kMinScale);
            
            // 10
            PinchLayout *layout = (PinchLayout *)_currentPinchCollectionView.collectionViewLayout;
            layout.pinchScale = theScalePct;
            layout.pinchCenter = [recognizer locationInView:self.collectionView];
            
            // 11
            self.collectionView.alpha = 1.0f - theScalePct;
        }
    }else {
        if (self.currentPinchedItem) {
            // 12
            PinchLayout *layout = (PinchLayout *)_currentPinchCollectionView.collectionViewLayout;
            layout.pinchScale = 1;
            self.collectionView.alpha = 0;
        }
    }
}

- (void)handlePinchInGesture:(UIPinchGestureRecognizer *)recognizer
{
    if ((recognizer.state == UIGestureRecognizerStateBegan)) {
        // 1
        self.collectionView.alpha = 0;
    }else if (UIGestureRecognizerStateChanged == recognizer.state) {
        // 2
        CGFloat theScale = 1 /recognizer.scale;
        theScale = MAX(MIN(theScale, kMaxScale), kMinScale);
        CGFloat theScalePct = 1 - ((theScale - kMinScale) / (kMaxScale - kMinScale));
        
        // 3
        PinchLayout *layout = (PinchLayout *)self.currentPinchCollectionView.collectionViewLayout;
        layout.pinchScale = theScalePct;
        layout.pinchCenter = [recognizer locationInView:self.collectionView];
        
        // 4
        self.collectionView.alpha = 1 - theScalePct;
    }else {
        // 5
        self.collectionView.alpha = 1;
        
        [self.currentPinchCollectionView removeFromSuperview];
        self.currentPinchCollectionView = nil;
        self.currentPinchedItem = nil;
    }
}

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
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchOutGeture:)];
    [self.collectionView addGestureRecognizer:pinch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

@end
