//
//  TopView.m
//  test
//
//  Created by Andrey Starostenko on 20.05.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "TopView.h"

@implementation TopView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        [self setBackgroundColor:[UIColor colorWithRed:183/255.0f green:190/255.0f blue:255/255.0f alpha:0.7f]];
        // Button "R"
        self.buttonR = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.buttonR addTarget:self action:@selector(deadMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonR setTitle:@"R" forState:UIControlStateNormal];
        self.buttonR.backgroundColor = [UIColor colorWithRed:64/255.0f green:120/255.0f blue:129/255.0f alpha:0.8f];
        self.buttonR.tintColor = [UIColor redColor];
//        self.buttonR.frame = CGRectMake(10.0, 17.0, 40.0, 40.0);
        self.buttonR.frame = CGRectMake(10.0, 5.0, 40.0, 40.0);

        self.buttonR.tag = 1;
        [self addSubview:self.buttonR];
        
        // Button "G"
        self.buttonG = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.buttonG addTarget:self action:@selector(deadMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonG setTitle:@"G" forState:UIControlStateNormal];
        self.buttonG.backgroundColor = [UIColor colorWithRed:64/255.0f green:120/255.0f blue:129/255.0f alpha:0.8f];
        self.buttonG.tintColor = [UIColor greenColor];
        self.buttonG.frame = CGRectMake(60.0, 5.0, 40.0, 40.0);
        self.buttonG.tag = 2;
        [self addSubview:self.buttonG];
        
        // Button "B"
        self.buttonB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.buttonB addTarget:self action:@selector(deadMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonB setTitle:@"B" forState:UIControlStateNormal];
        self.buttonB.backgroundColor = [UIColor colorWithRed:64/255.0f green:120/255.0f blue:129/255.0f alpha:0.8f];
        self.buttonB.tintColor = [UIColor blueColor];
        self.buttonB.frame = CGRectMake(110.0, 5.0, 40.0, 40.0);
        self.buttonB.tag = 3;
        [self addSubview:self.buttonB];
        
        // TextField
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(200.0, 5.0, 100.0, 40.0)];
        self.textField.backgroundColor = [UIColor colorWithRed:64/255.0f green:120/255.0f blue:129/255.0f alpha:0.8f];
        self.textField.textColor = [UIColor whiteColor];
        self.textField.tintColor = [UIColor whiteColor];
        self.textField.delegate = self;
        [self addSubview:self.textField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSLog(@"You entered %@", textField.text);
    if (textField.text && textField.text.length == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"ACHTUNG!!!" message:@"You didnt not put number in text field. Please get back and write something" delegate:nil cancelButtonTitle:@"M'kay" otherButtonTitles: nil];
        [alert show];
        return NO;
    } else {
       [self.delegate changeCountView:[textField.text intValue]];
       [textField resignFirstResponder];
        
        return YES;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(![string intValue] && ![string isEqualToString:@""] && ![string isEqualToString:@"0"]) { return NO; } else { return YES; }
}

-(void)deadMethod:(UIButton *)sender {
    NSLog(@"Button press %@", sender.titleLabel.text);
    [self.delegate pressRGB:sender.tag];
}

@end
