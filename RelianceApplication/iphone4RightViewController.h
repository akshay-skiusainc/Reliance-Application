//
//  iphone4RightViewController.h
//  RelianceApplication
//
//  Created by Akshay Jain on 9/20/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupViewController.h"
#import "iphone4Settings.h"
#import "R_iPhone4Settings.h"
#import "R_iPhone5ContestViewController.h"
#import "GlobalClass.h"
#import "DatabaseClass.h"
@interface iphone4RightViewController : UIViewController<UIGestureRecognizerDelegate>
{
    NSString *data1;
}
@property (strong, nonatomic) IBOutlet UIScrollView *Scroller;
@property (weak, nonatomic) IBOutlet UIView *VIEW1;
@property (weak, nonatomic) IBOutlet UIButton *SONG_BTN;
@property (strong, nonatomic) UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIButton *merchandise_btn;
@property (weak, nonatomic) IBOutlet UIButton *chat_btn;
@property (weak, nonatomic) IBOutlet UIButton *profile_btn;

-(IBAction)merchandise:(id)sender;
-(IBAction)chat:(id)sender;
-(IBAction)settings:(id)sender;
@end
