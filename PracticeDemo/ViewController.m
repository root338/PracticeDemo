//
//  ViewController.m
//  PracticeDemo
//
//  Created by 345 on 15/1/16.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
}

@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupTableView];
}

- (void)setupTableView
{
    _dataSource = [NSMutableArray arrayWithObjects:
                   
                   nil];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PracticeClassModel *)objectIndexPath:(NSInteger)row
{
    return _dataSource[row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    cell.textLabel.text = [self objectIndexPath:indexPath.row].title;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self objectIndexPath:indexPath.row].className)];
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end

@implementation PracticeClassModel

+ (PracticeClassModel *)create_title:(NSString *)title class:(Class)className
{
    PracticeClassModel *model = [[PracticeClassModel alloc] init];
    model.title = title;
    model.className = className;
    return model;
}

@end