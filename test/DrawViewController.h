//
//  DrawViewController.h
//  test
//
//  Created by Andrey Starostenko on 19.05.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
#import "CountView.h"

@interface DrawViewController : UIViewController <TopViewDelegate, CountViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property int widthView;
@property int heightView;
@property int xView;
@property int yView;
@property NSDictionary *dictionary;
@property NSMutableArray *array;
@property NSArray *sortedArray;
@property NSMutableArray *viewArray;
@property NSMutableArray *fkingColor;
@property NSMutableArray *returnArray;
@property int position;
@property int position1;
@property NSMutableArray *allNewSubView;

@property BOOL isRotate;
@property BOOL isHasSubview;

@property int countView;

//True @property
@property (nonatomic, retain) NSMutableArray *allSubViews;

-(UIColor *)randomColor;

@end
