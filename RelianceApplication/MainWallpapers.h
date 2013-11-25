//
//  MainWallpapers.h
//  RelianceApplication
//
//  Created by Akshay on 8/9/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "GlobalClass.h"
#import "DatabaseClass.h"
#import "AsyncImageView.h"

#import "Social/Social.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "JSON.h"
#import <Socialize/Socialize.h>

@interface MainWallpapers :DatabaseClass<iCarouselDelegate, iCarouselDataSource,UIWebViewDelegate,UIScrollViewDelegate, UIGestureRecognizerDelegate,MFMailComposeViewControllerDelegate,SocializeServiceDelegate>
{
    
    UIView          *vw_CollectionView;
    
    UIView *vw_BigCollectionView;
    
    iCarousel       *ic_CoverFlow;
    
    iCarousel *ic_BigCoverFlow;
    
    UIWebView       *webwall;
    
    UIWebView       *bigWallImage;
    
    NSString        *strr;
    
    UIImageView  *view2[1000];
    
    
    
    UIButton *downloadButton[1000];
    UIButton *downloadHD[1000];
    UIButton *shareButton[1000];
    
    UIView *shareView[1000];
    
    UIButton *fbButton[1000];
    
    UIButton *twtButton[1000];
    
    UIButton *mailButton[1000];
    
    // UIView *view3;
    
    NSString        *shareText;
    
    NSString        *shareTWEET[1000];
    
    int	sendtitle;
    
    
    
    
    CGFloat start;
    
    BOOL directionUp;
    
    UIImageView                 *ActIndImage1[1000];
    
    UIActivityIndicatorView     *activityIndicator1[1000];
    
    NSString    *fbsharetext;
    
    NSString    *twtsharetext;
    
    NSString    *mailsharesub;
    
    
    
    NSString    *mailsharetext;
    UIImageView *lockImage;
    NSArray *_products;
    NSNumberFormatter * _priceFormatter;
    UIView *premiumView;
    SZActionBar *actionBar[1000];
    NSString *FBID;
    NSString *ACCESSTOKEN;
    NSString *fbFeedId[1000];
     UIView *socializeBg[1000];
    UIButton *faceBookBtn;
    UIButton *twitterBtn;
    UIButton *emailBtn;
    
    
}
@property (nonatomic, retain) UIButton *faceBookBtn;
@property (nonatomic, retain) UIButton *twitterBtn;
@property (nonatomic, retain) UIButton *emailBtn;


//@property (nonatomic, retain) SZActionBar *actionBar;
@property (nonatomic, retain) id<SZEntity> entity;
@property (nonatomic, retain) SZLikeButton *likeButton;
@property (nonatomic, strong) Socialize *socialize;
@property (weak, nonatomic) IBOutlet UIView *IAPVIEW;
@property (weak, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelbutton;

-(IBAction)IAPCANCELED;
-(IBAction)IAPCALLED;
- (IBAction)RESTORE:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *okaybutton;

@property(nonatomic,retain) NSTimer *logoTimer ;

@property (nonatomic)int imgIndex;

@property (strong, nonatomic) IBOutlet UIView *footerMainView;

@property (strong, nonatomic) NSString *TAG;

@property (weak, nonatomic) IBOutlet UIButton *closebtn;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@property(nonatomic,strong) UIScrollView *imageScroller;

@property(nonatomic,strong) IBOutlet UIScrollView *IAPVIEWScroller;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activictyIndicator;

@property (strong, nonatomic) IBOutlet UIProgressView *dwnloadProgress;

@property (weak, nonatomic) IBOutlet UIButton *sharebtn;

- (IBAction)openFooter:(id)sender;

- (IBAction)merchandise:(id)sender;

-(IBAction)toRelApp:(id)sender;

- (IBAction)myProfile:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *closeButtonView;

- (IBAction)closeButton:(id)sender;

-(IBAction)chat:(id)sender;



@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;

@property (strong, nonatomic) IBOutlet UILabel *headerLabel;





@end