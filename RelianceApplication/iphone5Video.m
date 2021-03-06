//
//  Video.m
//  YJHD
//
//  Created by Akshay Band on 19/03/13.
//  Copyright (c) 2013 SKI USA 35. All rights reserved.
//

#import "iphone5Video.h"
#import "CustomAlertView.h"
#import "AppDelegate.h"
#import "iphone5GroupViewController.h"
#import "Merchandise.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface iphone5Video ()

@end

@implementation iphone5Video
@synthesize Scroller = _Scroller;
@synthesize LOGINVIEW,sharebtn,IAPVIEWScroller;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)fbShare:(id)sender
{
    
}
-(void)restoreDone
{
    //	dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    GlobalClass *obj=[GlobalClass getInstance];
    
    NSString* post = [NSString stringWithFormat:@"http://apps.medialabs24x7.com/besharam/ios_purchase.php?deviceno=%@",obj.dev];
    
    NSLog(@"post=%@",post);
    
    
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:post] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
    
    
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    NSError *errorReturned = nil;
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];
    
    
    if (errorReturned) {
        NSLog(@"errorReturned=%@",errorReturned);
        
        
        //			UIAlertView* alertBox = [[ UIAlertView alloc]initWithTitle:@"Network Error" message:@"Network Not Connected" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil ];
        //			alertBox.tag=3;
        //			alertBox.delegate=self;
        //			[alertBox show];
        
        
        
    }
    else
    {
        
        
        
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                             options:kNilOptions
                                                               error:&error];
        NSLog(@"json=%@",json);
        
        
        [self getAllData];
        
        
    }
}

-(void)getAllData{
    
    
	
    GlobalClass *obj=[GlobalClass getInstance];
    
    NSString* post = [NSString stringWithFormat:@"http://apps.medialabs24x7.com/besharam/fetch_data_all_downloads_ios.php?deviceno=%@",obj.dev];
	
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:post] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
	
	
	//  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://110.175.19.95/SCMIpadDemoWebApp/CustomerList.aspx?username=02&BeginRowNo=0&LastRowNo=10"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
	
	[request setHTTPMethod:@"GET"];
	//[request setValue:@"application/x-www-form-urlencodeQBCd" forHTTPHeaderField:@"Current-Type"];
	NSError *errorReturned = nil;
	
	
	
	
	
	if (errorReturned) {
		NSLog(@"errorReturned=%@",errorReturned);
		
		
		UIAlertView* alertBox = [[ UIAlertView alloc]initWithTitle:@"Network Error" message:@"Network Not Connected" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Retry", nil ];
		//alertBox.tag=3;
		alertBox.delegate=self;
		[alertBox show];
		
		
		// Handle error.
	}
	else
	{
		
		
		NSLog(@"POSTING=%@",post);
		
		
		
		NSError *errorReturned = nil;
		NSURLResponse *theResponse =[[NSURLResponse alloc]init];
		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&errorReturned];
		
        
        if (!errorReturned) {
            NSLog(@"errorReturned=%@",errorReturned);
            
            
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data //1
                                                                 options:kNilOptions
                                                                   error:&error];
            
            
            
            NSLog(@"json=%@",json);
            
            
            NSDictionary* interviewdata = [json objectForKey:@"bs_video"]; //2
            
            NSDictionary* onsetdata = [json objectForKey:@"bs_photo"]; //2
            
            NSDictionary* videodata = [json objectForKey:@"video_links"]; //2
            
            
            NSDictionary* wallpaperdata = [json objectForKey:@"small_wallpaper"]; //2
            NSDictionary* book = [json objectForKey:@"bookmyshow"]; //2
            NSDictionary* feedback1 = [json objectForKey:@"feedback"]; //2
            NSDictionary* music = [json objectForKey:@"music"]; //2
            NSDictionary* notifications = [json objectForKey:@"notifications"]; //2
            NSDictionary* cnc = [json objectForKey:@"castncrew"];
            NSDictionary* dirnote = [json objectForKey:@"directors_note"];
            NSDictionary    *category = [json objectForKey:@"cat_items"];
            NSDictionary    *BS_COVER = [json objectForKey:@"bs_cover"];
            NSDictionary    *banner = [json objectForKey:@"banner"];
            NSDictionary *appData = [json objectForKey:@"app_data"];
            NSDictionary *productionForCNC = [json objectForKey:@"production"];
            NSDictionary *sharetext = [json objectForKey:@"share_txt"];
            NSDictionary *fbtoken = [json objectForKey:@"facebook"];
            NSDictionary *iapp = [json objectForKey:@"arr_ios_keys"];
            
            NSDictionary *bookmyshow = [json objectForKey:@"bookmyshow"];
            
            
            GlobalClass *obj=[GlobalClass getInstance];
            for (NSDictionary *actoAgent in bookmyshow)
            {
                obj.bms_link= [actoAgent objectForKey:@"web_link"];
                
            }
            obj.str = interviewdata;
            obj.onset = onsetdata;
            obj.videolinks = videodata;
            obj.Dwall = wallpaperdata;
            obj.Bookmyshow = book;
            obj.Feedback=feedback1;
            obj.music=music;
            obj.CNC=cnc;
            obj.directorsNote=dirnote;
            obj.category=category;
            obj.BTS=BS_COVER;
            obj.Banner = banner;
            obj.appData=appData;
            obj.productionImage = productionForCNC;
            obj.groups = [json objectForKey:@"groups"];
            obj.fbtoken=fbtoken;
            obj.Notifications=notifications;
            //  obj.Contests=Contests;
            
            for (NSDictionary *actoAgent in dirnote)
            {
                obj.dirnote= [actoAgent objectForKey:@"image"];
                
            }
            for (NSDictionary *actoAgent in iapp)
            {
                obj.IAPProduct1= [actoAgent objectForKey:@"wall_key"];
                NSLog(@"IAPProduct1=%@",obj.IAPProduct1);
                
            }
            
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.videosharetext= [actoAgent objectForKey:@"videos"];
                NSLog(@"sharetext=%@",obj.videosharetext);
                
            }
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.wallpapers= [actoAgent objectForKey:@"wallpapers"];
                NSLog(@"sharetext=%@",obj.wallpapers);
                
            }
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.behindscene_video= [actoAgent objectForKey:@"behindscene_video"];
                NSLog(@"behindscene_video=%@",obj.behindscene_video);
                
            }
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.behindscene_images= [actoAgent objectForKey:@"behindscene_images"];
                NSLog(@"behindscene_images=%@",obj.behindscene_images);
                
            }
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.newsshare= [actoAgent objectForKey:@"news"];
                NSLog(@"newsshare=%@",obj.newsshare);
                
            }
            
            
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.twitter= [actoAgent objectForKey:@"twitter"];
                NSLog(@"twitter=%@",obj.twitter);
                
            }
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.facebook= [actoAgent objectForKey:@"facebook"];
                NSLog(@"facebook=%@",obj.facebook);
                
            }
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.mug= [actoAgent objectForKey:@"mug"];
                NSLog(@"mug=%@",obj.mug);
                
            }
            
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.Tshirt= [actoAgent objectForKey:@"Tshirt"];
                NSLog(@"Tshirt=%@",obj.Tshirt);
                
            }
            
            for (NSDictionary *actoAgent in sharetext)
            {
                obj.movie_poster= [actoAgent objectForKey:@"movie_poster"];
                NSLog(@"movie_poster=%@",obj.movie_poster);
                
            }
            
            
            
            //            obj.iapreceived=@"1";
            
        }
    }
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    NSLog(@"proo===%@",productIdentifier);
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            NSLog(@"PROCT PURCHAED");
            [self performSelector:@selector(restoreDone) withObject:nil afterDelay:0.0];
            [self performSelector:@selector(timercalled) withObject:nil afterDelay:0.0];            //   [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];
    
}

- (void)buyButtonTapped:(id)sender {
    
    UIButton *buyButton = (UIButton *)sender;
    SKProduct *product = _products[buyButton.tag];
    NSLog(@"_products[buyB=%@",_products[buyButton.tag]);
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
}
-(void)timercalled
{
    // GlobalClass *obj= [GlobalClass getInstance];
    
    [[VideoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [VideoScroller removeFromSuperview];
    VideoScroller=nil;
    [self DisplayVideos];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _okaybutton.enabled=NO;
    _IAPVIEW.alpha=0.0;
    _priceFormatter = [[NSNumberFormatter alloc] init];
    [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            NSLog(@"PPRO=%@",products);
            
            _products = [products copy];
            
            NSLog(@"PPRO=%@",_products);
            
            SKProduct * product = (SKProduct *) _products[0];
            //    cell.textLabel.text = product.localizedTitle;
            //    cell.textLabel.numberOfLines=5;
            NSLog(@"product==%@",product.localizedTitle);
            _okaybutton.enabled=YES;
            
            [_priceFormatter setLocale:product.priceLocale];
            
            
            _pricelabel.text = [NSString stringWithFormat:@"fee of . %@ \n to see become a premium member!",[_priceFormatter stringFromNumber:product.price]];
            NSLog(@"_products[buyB=%@", _pricelabel.text);

        }
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
  //  NSString    *STR=[NSString stringWithFormat:@"com.skiusainc.RelianceEntertainment.Videos"];
     IAPVIEWScroller.contentSize = CGSizeMake(320, 500);
    
    
   
	
    
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.trackedViewName=@"Video Screen";

	
    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_bg_image"];
    UIImage* app_bg_image = [UIImage imageWithData:imageData];
    self.view.backgroundColor = [UIColor colorWithPatternImage:app_bg_image];
    
    _footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg.png"]];
	[_Scroller setContentSize:CGSizeMake(320, 173*3)];
   
    [self DisplayVideos];
    
//    UIImage *relAppImage = [UIImage imageNamed:@"home_right_rel_icon.png"];
//    UIButton *buttonChat = [UIButton buttonWithType:UIButtonTypeCustom];
//    [buttonChat setImage:relAppImage forState:UIControlStateNormal];
//    buttonChat.frame = CGRectMake(0, 0, relAppImage.size.width, relAppImage.size.height);
//    [buttonChat addTarget:self action:@selector(toRelApp:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *customBarItem1 = [[UIBarButtonItem alloc] initWithCustomView:buttonChat];
//    self.navigationItem.RightBarButtonItem = customBarItem1;
    
	

    if([_TAG isEqual: @"LEFT"])
    {
        
    }
    else
    {
        UIImage *buttonImage = [UIImage imageNamed:@"back-btn.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:buttonImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = customBarItem;
        
    }
    
  
    
}
-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    UITouch *touch = (UITouch *)[touches anyObject];
    start = [touch locationInView:self.view].y;
    
    NSLog(@"start = %f",start);
    if(start < 400 && _footerMainView.center.y > 400)//touch was not in upper area of view AND pulldownView not visible
    {
        start = -1; //start is a CGFloat member of this view
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    if(start < 0)
    {
        return;
    }
    UITouch *touch = (UITouch *)[touches anyObject];
    CGFloat now = [touch locationInView:self.view].y;
    CGFloat diff = now - start;
    directionUp = diff > 0;//directionUp is a BOOL member of this view
    //    float nuCenterY = footerMainView.center.y + diff;
    //    footerMainView.center = CGPointMake(footerMainView.center.x, nuCenterY);
    start = now;
}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (directionUp)
    {
        NSLog(@"touchesEnded    ----    directionUp");
        //animate pulldownView out of visibel area
        [UIView animateWithDuration:.3 animations:^{_footerMainView.center = CGPointMake(320/2, 524);}];
    }
    else if(start>=0)
    {
        NSLog(@"touchesEnded    ----    start");
        //animate pulldownView with top to mainviews top
        [UIView animateWithDuration:.3 animations:^{_footerMainView.center = CGPointMake(320/2, 468);}];
    }
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    // [self performSelector:@selector(openFooter1:) withObject:nil afterDelay:0.01 ];
    _footerMainView.frame = CGRectMake(0, 487, _footerMainView.frame.size.width, _footerMainView.frame.size.height);

}


- (IBAction)myProfile:(id)sender {
    iphone5Settings *setting = [[iphone5Settings alloc]initWithNibName:@"iphone5Settings" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
    
}
//Ashwini
- (IBAction)merchandise:(id)sender
{
       Merchandise *merchandise = [[Merchandise alloc]initWithNibName:@"Merchandise" bundle:nil];
      [self.navigationController pushViewController:merchandise animated:YES];
   
}
- (IBAction)chat:(id)sender
{
    iphone5GroupViewController *group = [[iphone5GroupViewController alloc]initWithNibName:@"iphone5GroupViewController" bundle:nil];
    [self.navigationController pushViewController:group animated:YES];
}

//Ashwini
- (IBAction)toRelApp:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Under construction" message:@"Check Back Soon" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_header_bg.jpg"] forBarMetrics:UIBarMetricsDefault];
    }

//    GlobalClass *obj1=[GlobalClass getInstance];
    //    obj.coming = @"1";
    
   
//    if ([obj1.coming isEqualToString:@"1"])
//    {
//        
//        if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
//        {
//			[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bar.png"] forBarMetrics:UIBarMetricsDefault];
//            
//	    }
//    }
//	else {
//        if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_clean.png"] forBarMetrics:UIBarMetricsDefault];
//            
//            
//            UIImage *buttonImage = [UIImage imageNamed:@"c&c_top_back_btn.png"];
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setImage:buttonImage forState:UIControlStateNormal];
//            button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
//            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//            UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//            self.navigationItem.leftBarButtonItem = customBarItem;
//        }
//        
//        
//    }
    
  //  obj1.coming=@"2";
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:YES];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
    [_timer invalidate];
    _timer = nil;
    
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    //[[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeRight];
}

-(void)getdata
{
	GlobalClass *obj=[GlobalClass getInstance];
	NSLog(@"ddata=%@",obj.videolinks);
  	int i=0;
	for (NSDictionary *actoAgent in obj.videolinks)
	{
		data1[i]= [actoAgent objectForKey:@"youtube_link"];
		NSLog(@"video_link=%@",data1[i]);
		
		data2[i]= [actoAgent objectForKey:@"image"];
		NSLog(@"image=%@",data2[i]);
		
		
		data3[i]= [actoAgent objectForKey:@"music_director"];
		NSLog(@"music_director=%@",data3[i]);
		
		
		data4[i]= [actoAgent objectForKey:@"video_title"];
		NSLog(@"video_title=%@",data4[i]);
		
		data5[i]= [actoAgent objectForKey:@"time"];
		NSLog(@"time=%@",data5[i]);
		
		
		data6[i]= [actoAgent objectForKey:@"singer"];
		NSLog(@"singer=%@",data6[i]);
		
		
		
		data7[i]= [actoAgent objectForKey:@"lyrics"];
		NSLog(@"lyrics=%@",data7[i]);
		
		data8[i]= [actoAgent objectForKey:@"link_id"];
		NSLog(@"link_id=%@",data8[i]);
		
        
        
		data9[i]= [actoAgent objectForKey:@"music_label"];
		NSLog(@"music_label=%@",data9[i]);

        data11[i]= [actoAgent objectForKey:@"status"];
		NSLog(@"status=%@",data11[i]);
        
		data10[i]= [actoAgent objectForKey:@"premium"];
		NSLog(@"premium=%@",data10[i]);
		
		
		i++;
	}
	TotalData=i;
	
}

-(IBAction)share:(id)sender
{
	sharebtn.alpha=0.0;
	[UIView beginAnimations:@"Animate Text Field Up" context:nil];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	LOGINVIEW.frame = CGRectMake(LOGINVIEW.frame.origin.x,
						    413-110,
						    LOGINVIEW.frame.size.width,
						    LOGINVIEW.frame.size.height);
	
	[UIView commitAnimations];
	
	
	
	
	
}


-(IBAction)FinishedSharing:(id)sender
{
	sharebtn.alpha=1.0;
	[UIView beginAnimations:@"Animate Text Field Up" context:nil];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
	
	LOGINVIEW.frame = CGRectMake(LOGINVIEW.frame.origin.x,
						    413,
						    LOGINVIEW.frame.size.width,
						    LOGINVIEW.frame.size.height);
	
	[UIView commitAnimations];
	
	
	
	
	
}

-(void)DisplayVideos
{
    //  [[NSURLCache sharedURLCache] removeAllCachedResponses];

	
 

	[self getdata];

  
    
    
//    NSString *q = [NSString stringWithFormat:@"select youtube_link , image , music_director, video_title , time ,  singer ,lyrics ,id,music_label  From MOVIEVIDEO"];
//
//    
//	[self displayVideoData:q];

	
	VideoScroller			= [[UIScrollView alloc] initWithFrame:CGRectMake(10,5,299,499)];
	VideoScroller.userInteractionEnabled	=YES;
	VideoScroller.showsHorizontalScrollIndicator = YES;
	VideoScroller.pagingEnabled = NO;
	[self.view addSubview:VideoScroller];
	
	int m=0;
	NSLog(@"hi");
	for (int i =0; i<TotalData; i++) {
		
		NSLog(@"data2=%@",data2[i]);
		
		webwall[i]                    = [[UIWebView alloc] initWithFrame:CGRectMake(0, m, 299,232)];
		webwall[i].userInteractionEnabled=YES;
		webwall[i].delegate =self;
		webwall[i].tag=i;
		NSURL *url = [NSURL URLWithString:data2[i]];
		//            //URL Requst Object
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
		//            //Load the request in the UIWebView.
		[webwall[i] loadRequest:requestObj];
		webwall[i].scrollView.bounces = NO;
		webwall[i].scrollView.scrollEnabled = NO;
        webwall[i].backgroundColor= [UIColor clearColor];
        webwall[i].opaque = NO;
		[VideoScroller addSubview:webwall[i]];
		
        
		
		
//		UITapGestureRecognizer *tapped123 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
//		tapped123.numberOfTapsRequired = 1;
//		tapped123.delegate=self;
//		[webwall[i] addGestureRecognizer:tapped123];
		

		
		
		        ImagePatch[i]                    = [[UIImageView alloc] initWithFrame:CGRectMake(0,232-40, 320,40)];
		        ImagePatch[i].userInteractionEnabled=YES;
        ImagePatch[i].backgroundColor=[UIColor blackColor];
        ImagePatch[i].alpha=0.7;
				ImagePatch[i].image= [UIImage imageNamed:@"video_song_title.jpg"];
		//       // ImagePatch[i].backgroundColor= [UIColor blueColor];
				[webwall[i] addSubview:ImagePatch[i]];
		    //    [ImagePatch[i] release];
		        ImagePatch[i].tag= i;
		
		
		
		
		MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(5, 232-25, 320-25-5, 20)];
		MusicLabel[i].backgroundColor =[UIColor clearColor];
		MusicLabel[i].textColor= [UIColor whiteColor];
      //  MusicLabel[i].alpha=0.3;

	//	MusicLabel[i].sizeToFit=YES;
		MusicLabel[i].text=data4[i];
		MusicLabel[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 21.0];
		[webwall[i] addSubview:MusicLabel[i]];

		
		//            UIImage *dwn = [UIImage imageNamed:@"info_icon1.png"];
		//            UIImage *dwn1 = [UIImage imageNamed:@"hover_info.png"];
		
		
	//	if ([data3[i] isEqualToString:@"1" ]) {
			
			
			UITapGestureRecognizer *tapped123 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
			tapped123.numberOfTapsRequired = 1;
			tapped123.delegate=self;
			[webwall[i] addGestureRecognizer:tapped123];
			
			
			
			
			
			
        infoVideo[i]					= [UIButton buttonWithType:UIButtonTypeInfoLight];
        infoVideo[i].frame				= CGRectMake(299-25,232-30,25,25);
        //          [infoVideo[i] setBackgroundImage:dwn forState:UIControlStateNormal];
        //          [infoVideo[i] setBackgroundImage:dwn1 forState:UIControlStateHighlighted];
        infoVideo[i].userInteractionEnabled = YES;
        // [infoVideo[i] addTarget:self action:@selector(openInfoAlert:)forControlEvents:UIControlEventTouchUpInside];
        infoVideo[i].tag=i;
        
        [webwall[i] addSubview:infoVideo[i]];
        
        //
        
        gapView[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m+232, 299,1)];
        gapView[i].backgroundColor = [UIColor whiteColor];
        [VideoScroller addSubview:gapView[i]];
        
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openInfoAlert:)];
        tapped.numberOfTapsRequired = 1;
        [infoVideo[i] addGestureRecognizer:tapped];
        
         if ([data11[i] isEqualToString:@"1"])
         {
             lockImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 299,232)];
             lockImage.image = [UIImage imageNamed:@"premi_video.png"];
             [webwall[i] addSubview:lockImage];
         }
//		if ([data10[i] isEqualToString:@"1"])
//        {
//            premiumImage = [[UIImageView alloc]initWithFrame:CGRectMake(299-40, 0, 40,40)];
//            premiumImage.image = [UIImage imageNamed:@"magnify.png"];
//            [webwall[i] addSubview:premiumImage];
//        }
		m+=233;
		
				 
	}
	
	VideoScroller.contentSize = CGSizeMake(299,233*(TotalData+0)+10);
	[self.view addSubview:_footerMainView];
	//    ImagePatch[0].image = [UIImage imageNamed:@"v4.png"];
	//    ImagePatch[1].image = [UIImage imageNamed:@"v1.png"];
	//    ImagePatch[2].image = [UIImage imageNamed:@"v3.png"];
	//    ImagePatch[3].image = [UIImage imageNamed:@"v2.png"];
	
	//    AlbumImages[0] = [[NSString stringWithFormat:@"v4.png"] retain];
	//    AlbumImages[1] = [[NSString stringWithFormat:@"v1.png"] retain];
	//    AlbumImages[2] = [[NSString stringWithFormat:@"v3.png"] retain];
	//    AlbumImages[3] = [[NSString stringWithFormat:@"v2.png"] retain];
	
//	[self.view addSubview:LOGINVIEW];
//	[self.view addSubview:sharebtn];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
	return YES;
}

-(IBAction)RESTORE:(id)sender
{
    [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
    _IAPVIEW.alpha=0.0;
    
    
}

-(IBAction)IAPCANCELED
{
    _IAPVIEW.alpha=0.0;
    
}
-(IBAction)IAPCALLED
{
    SKProduct *product = _products[0];
    
    [_priceFormatter setLocale:product.priceLocale];
    
    
    _pricelabel.text = [NSString stringWithFormat:@"fee of . %@ \n to see become a premium member!",[_priceFormatter stringFromNumber:product.price]];
    NSLog(@"_products[buyB=%@", _pricelabel.text);
    NSLog(@"Buying %@...", product.productIdentifier);
    [[RageIAPHelper sharedInstance] buyProduct:product];
    
    _IAPVIEW.alpha=0.0;
    
    
}

-(IBAction)navigate:(id)sender
{
	
	UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    if ([data11[gesture.view.tag] isEqualToString:@"1"]) {
        _IAPVIEW.alpha=1.0;
        [self.view addSubview:_IAPVIEW];
        
        
        SKProduct *product = _products[0];
        
        [_priceFormatter setLocale:product.priceLocale];
        
        
        _pricelabel.text = [NSString stringWithFormat:@"fee of . %@ \n to see become a premium member!",[_priceFormatter stringFromNumber:product.price]];
        NSLog(@"_products[buyB=%@", _pricelabel.text);
        
        
    }
    else
    {
    
    iphone5PlayVideo *loginViewController = [[iphone5PlayVideo alloc] initWithNibName:@"iphone5PlayVideo" bundle:nil];
	loginViewController.idis =data1[gesture.view.tag];
	loginViewController.songTitle = data4[gesture.view.tag];
	loginViewController.time = data5[gesture.view.tag];
	loginViewController.singer = data6[gesture.view.tag];
	loginViewController.lyrics = data7[gesture.view.tag];
    loginViewController.musicDirector = data3[gesture.view.tag];
    loginViewController.premiumType = data10[gesture.view.tag];
    loginViewController.musicLabel = data9[gesture.view.tag];
    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Video Clicked"
                                                    withAction:data1[gesture.view.tag]
                                                     withLabel:@"Video"
                                                     withValue:nil];
	[self.navigationController pushViewController:loginViewController animated:NO];
    }
	
	
}

-(IBAction)info:(id)sender
{
	
	//UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
	
//	iphone5VideoInfoViewController *loginViewController = [[iphone5VideoInfoViewController alloc] initWithNibName:@"iphone5VideoInfoViewController" bundle:nil];
//	loginViewController.strURL =VideoLinksfromServer[gesture.view.tag];
//	loginViewController.titlesong = data4[gesture.view.tag];
//	loginViewController.time = data5[gesture.view.tag];
//	loginViewController.singer = data6[gesture.view.tag];
//	loginViewController.lyrics = data7[gesture.view.tag];
//	loginViewController.Videoid = data8[gesture.view.tag];
//
//	[self.navigationController pushViewController:loginViewController animated:NO];
	
	
}

-(void)VideoInfo:(id)sender
{
   // UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
	
//	iphone5VideoInfoViewController *loginViewController = [[iphone5VideoInfoViewController alloc] initWithNibName:@"iphone5VideoInfoViewController" bundle:nil];
//	loginViewController.strURL =VideoLinksfromServer[gesture.view.tag];
//	loginViewController.titlesong = data4[gesture.view.tag];
//	loginViewController.time = data5[gesture.view.tag];
//	loginViewController.singer = data6[gesture.view.tag];
//	loginViewController.lyrics = data7[gesture.view.tag];
//	loginViewController.Videoid = data8[gesture.view.tag];
//
//    
//	[self.navigationController pushViewController:loginViewController animated:NO];
//	

    
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"yes");
	for (int i =0; i<TotalData; i++) {
		
		
		if (webView.tag==i) {
			
			
			ActIndImage1[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,173)];
			//  ActIndImage1[i].center = CGPointMake(320/2, 460/2);
			ActIndImage1[i].image = [UIImage imageNamed:@"color_pacth_400x400.png"];
			ActIndImage1[i].opaque=0.5;
			[webwall[i] addSubview:ActIndImage1[i]];
			
			activityIndicator1[i] = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
			activityIndicator1[i].center=CGPointMake(320/2, 173/2);
			//activityIndicator1[i].transform = CGAffineTransformMakeScale(1.0, 1.0);
			[activityIndicator1[i] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
			[ActIndImage1[i] addSubview:activityIndicator1[i]];
			
			
			[activityIndicator1[i] startAnimating];
			
		}
		
		
		
		else {
			
		}
	}
	
	//[self performSelector:@selector(unloadAct) withObject:nil afterDelay:0.2];
	
	
}


-(void)openInfoAlert:(UITapGestureRecognizer *)sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    int i= gesture.view.tag;
    NSString *alertsStr=[NSString stringWithFormat:@"Title: %@\nTime: %@\nSinger: %@\nLyrics: %@\nMusic Director: %@\nMusic Lable: %@",data4[i],data5[i],data6[i],data7[i],data3[i],data9[i]];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.customAlert=2;
    CustomAlertView *alert = [[CustomAlertView alloc]
							  initWithTitle:@"Info"
							  message:alertsStr
							  delegate:self
							  cancelButtonTitle:nil
							  otherButtonTitles:@"Done", nil];
    
    [alert show];
    [alert release];
}


-(void)unloadAct:(int)i
{
	
	NSLog(@"unloadAct=%d",i);
	[activityIndicator1[i] stopAnimating];
	if (activityIndicator1[i]!=nil) {
		[activityIndicator1[i] removeFromSuperview];
		activityIndicator1[i] = nil;
	}
	if (ActIndImage1[i]!=nil) {
		[ActIndImage1[i] removeFromSuperview];
		ActIndImage1[i] = nil;
	}
	
}
- (void)webViewDidFinishLoad:(UIWebView *)webView

{
	
	for (int i =0; i<TotalData; i++) {
		
		if (webView.tag == i) {
			[self unloadAct:i];
			
		}
	}
	
	
	
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	for (int i =0; i<TotalData; i++) {
		if (webView.tag == i) {
			[self unloadAct:i];
			
		}
	}
}

//-(IBAction)VideoComments:(id)sender
//{
//	
//	GlobalClass *obj1=[GlobalClass getInstance];
//
//	NSString* sTR= [NSString stringWithFormat:@"http://apps.micrositeads.com/yjhd/comments/comment_reterive.php?deviceno=%@&type=%@&id=%@",obj1.dev,@"wallpaper",wallpaperid];
//	
//	NSLog(@"comment to str =%@",sTR);
//CommentsViewController *loginViewController = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
//loginViewController.geturl=sTR;
//[self.navigationController pushViewController:loginViewController animated:NO];
//
//
//}
- (void)viewDidUnload
{
    [self setScroller:nil];
	[self setLOGINVIEW:nil];
	[self setSharebtn:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(BOOL)shouldAutorotate
{
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
