//
//  DrawViewController.m
//  test
//
//  Created by Andrey Starostenko on 19.05.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#define NUMBER_OF_VIEW 3

#import "DrawViewController.h"

@interface DrawViewController ()

@property CountView *viewCount;
@property TopView *topView;

@end

@implementation DrawViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.dictionary = [[NSMutableDictionary alloc] init];
    self.array = [[NSMutableArray alloc] init];
    self.viewArray = [[NSMutableArray alloc] init];
    self.returnArray = [[NSMutableArray alloc] init];
    self.allNewSubView = [[NSMutableArray alloc] init];
    
    self.isRotate = YES;
    
    self.countView = NUMBER_OF_VIEW;
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    NSLog(@"x = %f, y = %f", bounds.size.width, bounds.size.height);
    
    CGPoint point = CGPointMake(bounds.size.width / (self.countView  * 2), bounds.size.height / (self.countView  * 2));
    
    // Add View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 20)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    [view bringSubviewToFront:self.view];
    
    // Add Top View
    CGRect topRect = CGRectMake(0, 20, bounds.size.width, 50);
    self.topView = [[TopView alloc] initWithFrame:topRect];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    
    // Add Count View
    self.viewCount = [[CountView alloc] initWithFrame:CGRectMake(0, 70, bounds.size.width, bounds.size.height - 70) andCountFrame:self.countView  sameCount:self.countView andPoint:point omgHowManyParam:self];
    [self.viewCount setBackgroundColor:[self randomColor]];
    self.viewCount.delegate = self;
    [self.view addSubview:self.viewCount];    
    [self.viewArray removeAllObjects];
    
    self.allSubViews = [self getViewsForView:self.viewCount];
    NSLog(@"mArray: %@", self.allSubViews);
}

#pragma mark - delegate method

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    CGPoint location = [[touches anyObject] locationInView:self.view];
//    CGRect fingerRect = CGRectMake(location.x - 5, location.y - 5, 10, 10);
//    
//    for (UIView *view in self.view.subviews) {
//        CGRect subViewFrame = view.frame;
//        
//        if (CGRectIntersectsRect(fingerRect, subViewFrame)) {
//            NSLog(@"Got it! %@", view);
//        }
//    }
//}
#define degreesToRadians(x) (M_PI * x / 180.0)
-(void)getView:(UIView *)view andDirection:(int)direction {
    NSMutableArray *color = [[NSMutableArray alloc] init];
    
    NSLog(@"View from DrawViewController: %@", view);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:view];
    for (UIView *subview in view.subviews) {
        if (subview.tag != -1) {
            [array addObject:subview];
        }
    }
    switch (direction) {
        // Up
        case 1:
            // 1. Clear array allSubView
            [self.allSubViews removeAllObjects];
            [self.allNewSubView removeAllObjects];
            
            // 2. Get all subview from view
            self.allSubViews = [self getViewsForView:self.viewCount];
            
            [self.allSubViews removeObject:view];
            
            // 3. Get color from view
            color = [self getColorFromViews:self.allSubViews];
            
            // 5. Apply sorted color to array allSubview
            [self applyColor:color toViewArray:self.allSubViews];
            
            NSLog(@"REMOVED VIEW! :%@", self.allSubViews);
            
            self.allSubViews = [NSMutableArray arrayWithArray:[[self.allSubViews reverseObjectEnumerator]allObjects]];
            
            for (UIView *view in self.allSubViews) {
                CGPoint localPoint = [view bounds].origin;
                CGPoint basePoint = [view convertPoint:localPoint toView:self.view];
                NSLog(@"base points x: %f, y: %f", basePoint.x, basePoint.y);
                UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(basePoint.x, basePoint.y, view.frame.size.width, view.frame.size.height)];
                [newView setBackgroundColor:[view backgroundColor]];
                [self.view addSubview:newView];
                [self.allNewSubView addObject:view];

            }
            NSLog(@"new view: %@", self.allNewSubView);
            [self.allSubViews removeAllObjects];
            self.allSubViews = [NSMutableArray arrayWithArray:self.allNewSubView];
            NSLog(@"new view in allSubview: %@", self.allSubViews);
//            [UIView beginAnimations:nil context:nil];
//            [UIView setAnimationDelegate:self];
//            [UIView setAnimationDuration:0.5];
//            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//            view.frame = CGRectMake(500, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
//            for (UIView *subview in view.subviews) {
//                if (subview.tag != 1) {
//                    subview.frame = CGRectMake(-500 , subview.frame.origin.y, subview.frame.size.width, subview.frame.size.height);
//                }
//            }
//            [UIView commitAnimations];
            break;
            
        // Down
        case 2:
            
            break;
            
        // Left
        case 3:
            self.position = 1;
            [UIView beginAnimations:@"rotate" context:(__bridge_retained void *)(array)];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:2];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            
            view.transform = CGAffineTransformMakeRotation(-M_PI/2);
            for (UIView *subview in view.subviews) {
                if (subview.tag != -1) {
                    self.position1 = 1;
                    subview.transform = CGAffineTransformMakeRotation(M_PI/2);
                }
            }
            [UIView commitAnimations];
            break;
            
        // Right
        case 4:
            self.position = 1;
            [UIView beginAnimations:@"rotate" context:(__bridge_retained void *)(array)];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:2];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            
            view.transform = CGAffineTransformMakeRotation(M_PI/2);
            for (UIView *subview in view.subviews) {
                if (subview.tag != -1) {
                    self.position1 = 1;
                    subview.transform = CGAffineTransformMakeRotation(-M_PI/2);
                }
            }
            [UIView commitAnimations];
            break;
            
        default:
            break;
    }
}



- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
    
    NSArray *array = [[NSArray alloc] initWithArray:(__bridge NSArray *)context];//(__bridge_transfer NSArray *)context;
    UIView *view, *subview = [[UIView alloc] init];
    view = [array objectAtIndex:0];
    if ([array count] == 2) {
            subview = [array objectAtIndex:1];
        }
    
    NSLog(@"contex: %@", view);
    
    
    if ([animationID isEqualToString:@""])
    {
        if (self.position == 1) {
            NSLog(@"1");
            self.position = 2;
            [UIView beginAnimations:@"rotate" context:(__bridge_retained void *)(array)];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:2];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            view.transform = CGAffineTransformMakeRotation(M_PI);
            if ([array count] == 2) {
                subview.transform = CGAffineTransformMakeRotation(-M_PI);
            }
            [UIView commitAnimations];

        } else if (self.position == 2) {
            NSLog(@"2");
            self.position = 3;
            [UIView beginAnimations:@"rotate" context:(__bridge_retained void *)(array)];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:2];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            view.transform = CGAffineTransformMakeRotation(M_PI * 1.5);
            if ([array count] == 2) {
                subview.transform = CGAffineTransformMakeRotation(-M_PI * 1.5);
            }
            [UIView commitAnimations];

        } else if (self.position == 3) {
            NSLog(@"3");
            self.position = 4;
            [UIView beginAnimations:@"rotate" context:(__bridge_retained void *)(array)];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:2];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            view.transform = CGAffineTransformMakeRotation(M_PI * 2);
            if ([array count] == 2) {
                subview.transform = CGAffineTransformMakeRotation(-M_PI * 2);
            }
            [UIView commitAnimations];

        } else if (self.position == 4) {
            NSLog(@"4");
            self.position = 1;
            [UIView beginAnimations:@"rotate" context:(__bridge_retained void *)(array)];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:2];
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
            view.transform = CGAffineTransformMakeRotation(M_PI / 2);
            if ([array count] == 2) {
                subview.transform = CGAffineTransformMakeRotation(-M_PI / 2);
            }
            [UIView commitAnimations];

        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor *)randomColor {
    CGFloat red = arc4random()%255;
    CGFloat blue = arc4random()%255;
    CGFloat green = arc4random()%255;

    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
}

- (void)changeCountView:(int)count
{
        [self.viewCount removeFromSuperview];
        CGRect bounds = [[UIScreen mainScreen] bounds];
        CGPoint point = CGPointMake(bounds.size.width / (count * 2), bounds.size.height / (count * 2));
        
        self.viewCount = [[CountView alloc] initWithFrame:CGRectMake(0, 70, bounds.size.width, bounds.size.height - 70) andCountFrame:count sameCount:count andPoint:point omgHowManyParam:self];
        [self.viewCount setBackgroundColor:[self randomColor]];
        [self.view addSubview:self.viewCount];
        [self.view bringSubviewToFront:self.topView];
        self.topView.textField.text = @"";
    
        self.countView = count;
    
        [self.viewArray removeAllObjects];
}

- (void)pressRGB:(int)changerTag{
    [self sortViewByType:changerTag];
}

#pragma mark - test zone
-(void)sortViewByType:(int)type {
    NSMutableArray *color = [[NSMutableArray alloc] init];
    NSMutableArray *sortedColor = [[NSMutableArray alloc] init];
    
    // 1. Clear array allSubView
    [self.allSubViews removeAllObjects];
    
    // 2. Get all subview from view
    self.allSubViews = [self getViewsForView:self.viewCount];
//    self.allSubViews = [NSMutableArray arrayWithArray:self.allNewSubView];
    
    // 3. Get color from view
    color = [self getColorFromViews:self.allSubViews];
    
    // 4. Sort color
    sortedColor = [self sortColor:color andTag:type];
    
    // 5. Apply sorted color to array allSubview
    [self applyColor:sortedColor toViewArray:self.allSubViews];
}

// Sorts an array of colors, return sorted array of colors
-(NSMutableArray *)sortColor:(NSArray *)colorArray andTag:(int)tag {
    NSArray *sortedArray = [colorArray sortedArrayUsingComparator:^NSComparisonResult(id firstColor, id secondColor2) {
        UIColor *color1 = firstColor, *color2 = secondColor2;
        
        CGFloat First;
        CGFloat Second;
        
        CGColorRef colorref = [color1 CGColor];
        int numComponents = CGColorGetNumberOfComponents(colorref);
        
        CGColorRef colorref2 = [color2 CGColor];
        int numComponents2 = CGColorGetNumberOfComponents(colorref2);
        
        // switch
        switch (tag) {
            case 1:
                if (numComponents == 4) {
                    const CGFloat *components = CGColorGetComponents(colorref);
                    First = components[0];
                }
                
                if (numComponents2 == 4) {
                    const CGFloat *components2 = CGColorGetComponents(colorref2);
                    Second = components2[0];
                }
                break;
                
            case 2:
                if (numComponents == 4) {
                    const CGFloat *components = CGColorGetComponents(colorref);
                    First = components[1];
                }
                
                if (numComponents2 == 4) {
                    const CGFloat *components2 = CGColorGetComponents(colorref2);
                    Second = components2[1];
                }
                break;
                
            case 3:
                if (numComponents == 4) {
                    const CGFloat *components = CGColorGetComponents(colorref);
                    First = components[2];
                }
                
                if (numComponents2 == 4) {
                    const CGFloat *components2 = CGColorGetComponents(colorref2);
                    Second = components2[2];
                }
                break;
                
            default:
                break;
        }
        // end switch
        
        if ( First > Second ) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if ( First < Second ) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    
    return [sortedArray mutableCopy];
}

// Return array for all subview
-(NSMutableArray *)getViewsForView:(UIView *)view {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.countView; i ++) {
        [views addObject:[view viewWithTag:i]];
    }
    NSLog(@"return array: %@", views);
    return views;
}

// Return color array of all view
-(NSMutableArray *)getColorFromViews:(NSMutableArray *)viewArray {
    NSMutableArray *colorArray = [[NSMutableArray alloc] init];
    
    for (UIView *view in viewArray) {
        UIColor *color = [view backgroundColor];
        [colorArray addObject:color];
    }
    return colorArray;
}

// Apply sorted color to array allSubview
-(void)applyColor:(NSArray *)colorArray toViewArray:(NSArray *)viewArray {
    for (int i = 0; i < [viewArray count]; i ++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view setBackgroundColor:[colorArray objectAtIndex:i]];
    }
}

@end