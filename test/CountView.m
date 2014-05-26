//
//  CountView.m
//  test
//
//  Created by Andrey Starostenko on 20.05.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "CountView.h"
#import "DrawViewController.h"

@implementation CountView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 
-(id)initWithFrame:(CGRect)frame andCountFrame:(int)count sameCount:(int)sameCount andPoint:(CGPoint)point omgHowManyParam:(DrawViewController *)viewController {
    self = [super initWithFrame:frame];
    if (self) {
        // initialization code here
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];

        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        
        self.array = [[NSMutableArray alloc] init];
        // Add label R.G.B
        self.labelR = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 20, 10)];
        [self.labelR setText:@"R"];
        [self.labelR setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
        [self.labelR setTextColor:[UIColor whiteColor]];
        [self.labelR setTag:-1];
        
        self.labelG = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 20, 10)];
        [self.labelG setText:@"G"];
        [self.labelG setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
        [self.labelG setTextColor:[UIColor whiteColor]];
        [self.labelG setTag:-1];
        
        self.labelB = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 20, 10)];
        [self.labelB setText:@"B"];
        [self.labelB setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
        [self.labelB setTextColor:[UIColor whiteColor]];
        [self.labelB setTag:-1];
        
        [self addSubview:self.labelR];
        [self addSubview:self.labelG];
        [self addSubview:self.labelB];
        
        int oneCounterLeft = count - 1;
        [self setTag:oneCounterLeft];
        
        if (count == 1) {
            NSLog(@"There is no more view!");
        } else {
            self.widthView = self.frame.size.width - point.x * 2;
            self.heightView = self.frame.size.height - point.y * 2;
            NSLog(@"width: %d, height: %d", [self widthView], [self heightView]);
            NSLog(@"point x: %d, point y: %d", [self xView], [self yView]);
            CGRect bound = CGRectMake(point.x, point.y, self.widthView, self.heightView);
            
            CountView *view = [[CountView alloc] initWithFrame:bound andCountFrame:oneCounterLeft sameCount:sameCount andPoint:point omgHowManyParam:viewController];
            [view setDelegate:viewController];
            [view setBackgroundColor:[viewController randomColor]];

            [self addSubview:view];
            self.userInteractionEnabled = YES;
            [self addGestureRecognizer:swipeLeft];
            [self addGestureRecognizer:swipeRight];
            [self addGestureRecognizer:swipeDown];
            [self addGestureRecognizer:swipeUp];
        }
    }
    
    return self;
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        [self.delegate getView:self andDirection:3];
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        [self.delegate getView:self andDirection:4];
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"Down Swipe!: %@", self);
        [self.delegate getView:self andDirection:2];
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"Up Swipe!");
        [self.delegate getView:self andDirection:1];
    }
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    UIColor *uicolor = [self backgroundColor];
    CGColorRef color = [uicolor CGColor];
    int numComponent = CGColorGetNumberOfComponents(color);
    if (numComponent == 4) {
        const CGFloat *components = CGColorGetComponents(color);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    self.labelR.text = [NSString stringWithFormat:@"%.02f", red];
    self.labelG.text = [NSString stringWithFormat:@"%.02f", green];
    self.labelB.text = [NSString stringWithFormat:@"%.02f", blue];
}
@end
