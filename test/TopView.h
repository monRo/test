//
//  TopView.h
//  test
//
//  Created by Andrey Starostenko on 20.05.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopViewDelegate <NSObject>

- (void)changeCountView:(int)count;
- (void)pressRGB:(int)changerTag;

@end

@interface TopView : UIView <UITextFieldDelegate>

@property UITextField *textField;
@property UIButton *buttonR;
@property UIButton *buttonG;
@property UIButton *buttonB;
@property (assign) id <TopViewDelegate> delegate;

@end
