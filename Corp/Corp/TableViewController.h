//
//  TableViewController.h
//  Corp
//
//  Created by 345 on 15/1/30.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController

@end

@class CGLabel;

@interface CGTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CGLabel *label;
@end

@interface CGLabel : UILabel

@end