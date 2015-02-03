//
//  TableViewController.m
//  Corp
//
//  Created by 345 on 15/1/30.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self _tableView:tableView indexPath:indexPath flag:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [[self _tableView:tableView indexPath:indexPath flag:NO] floatValue];
//}

- (id)_tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath flag:(BOOL)flag
{
    CGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.label.text = @"这样的话语体系其实和前几年流传的「新浪最大股东是日本人,Sina在日语中就是支那」、「人人网是日本人开的，狗日的窃取我们资料」是一体的。上面例举的小米段子也会像这些谣言一样在QQ空间、论坛、朋友圈流转不停，成功加入「月经贴」的大家庭。阿表能想到的解决办法只能是「以谣制谣」，首先打开冰箱门，然后编造一个段子：『雷军答印度阿三的话语，台下八十国记者自发响起雷鸣般的掌声』，最后往网上一放，结果爱国小将顿时六神无主。";

    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
//    [cell layoutIfNeeded];
    
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize withHorizontalFittingPriority:UILayoutPriorityDefaultHigh verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
    CGSize oldSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return flag ? cell : @(oldSize.height + 1);
}
@end

@implementation CGTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
//    
//    self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.label.bounds);
//    
//    NSLog(@"%lf",self.label.preferredMaxLayoutWidth);
}

@end

@implementation CGLabel

- (CGSize)intrinsicContentSize
{
//    return [super intrinsicContentSize];
    
    CGSize size = [super intrinsicContentSize];
    
    if (size.width == 0) {
        size.width = self.preferredMaxLayoutWidth;
    }
    
    if (size.height < 22) {
        size.height = 22;
    }
    
    return size;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);
    NSLog(@"%lf",self.preferredMaxLayoutWidth);
}
@end