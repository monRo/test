//
//  CountView.h
//  test
//
//  Created by Andrey Starostenko on 20.05.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CountViewDelegate <NSObject>

-(void)getView:(UIView *)view andDirection:(int)direction;

@end

@class DrawViewController;

@interface CountView : UIView

extern const int COUNT;

@property int widthView;
@property int heightView;
@property int xView;
@property int yView;
@property (strong, nonatomic) NSMutableArray *array;
@property UILabel *labelR;
@property UILabel *labelG;
@property UILabel *labelB;
@property (assign) id <CountViewDelegate> delegate;

@property int position;

-(id)initWithFrame:(CGRect)frame andCountFrame:(int)count sameCount:(int)sameCount andPoint:(CGPoint)point omgHowManyParam:(DrawViewController *)viewController;

@end
