//
//  BehindTheScene.h
//  RelianceApplication
//
//  Created by Akshay on 8/10/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseClass.h"
#import "AsyncImageView.h"
#import "SynopsisViewController.h"
#import "BVideos.h"
#import "BPhotos.h"
@interface BehindTheScene : DatabaseClass<UIGestureRecognizerDelegate>
{
    
    CGFloat start;
    BOOL directionUp;
    
}
@property (strong, nonatomic) IBOutlet UIView *footerMainView;
@property (strong, nonatomic) NSString *TAG;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *footerView;
- (IBAction)merchandise:(id)sender;
-(IBAction)toRelApp:(id)sender;
- (IBAction)myProfile:(id)sender;
-(IBAction)chat:(id)sender;
@end
