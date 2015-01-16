//
//  ViewController.h
//  PracticeDemo
//
//  Created by 345 on 15/1/16.
//  Copyright (c) 2015年 345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PracticeClassModel : NSObject

@property (strong, nonatomic) Class className;

@property (strong, nonatomic) NSString *title;

+ (PracticeClassModel *)create_title:(NSString *)title className:(NSString *)className;
@end

@interface ViewController : UIViewController


@end

