//
//  R_OpenMovie_4.m
//  RelianceApplication
//
//  Created by Akshay Jain on 10/24/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import "R_OpenMovie_4.h"
#import "ShortScenesVC.h"

@interface R_OpenMovie_4 ()

@end

@implementation R_OpenMovie_4
@synthesize getiID,movieNameArray,socializeBgView;
@synthesize faceBookBtn,twitterBtn,emailBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    
	
    NSLog(@"iphone4viewcontroller called ***************************");
	
	GlobalClass *obj=[GlobalClass getInstance];
    if ([obj.REL_DATA isEqualToString:@"0"]) {
        
        NSString*   post = [NSString stringWithFormat:@"http://apps.medialabs24x7.com/besharam/fetch_all_rel_ios.php?deviceno=%@",obj.dev];
        
        
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
                
                NSDictionary* videodata = [json objectForKey:@"shortscenes"]; //2
                
                
                NSDictionary* wallpaperdata = [json objectForKey:@"wallpapers"]; //2
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
                NSDictionary *sharetext = [json objectForKey:@"share_text"];
                NSDictionary *fbtoken = [json objectForKey:@"facebook_feed"];
                NSDictionary *iapp = [json objectForKey:@"arr_ios_keys"];
                
                NSDictionary *bookmyshow = [json objectForKey:@"bookmyshow"];
                NSDictionary *movie = [json objectForKey:@"movie"];
                NSDictionary *trailers = [json objectForKey:@"trailers"];
                NSDictionary *award_cat = [json objectForKey:@"award_cat"];
                NSDictionary *award_movie = [json objectForKey:@"award_movie"];
                NSDictionary *movie_Category = [json objectForKey:@"movie_cat"];
                NSDictionary *award_info = [json objectForKey:@"award_info"];
                ///////
                GlobalClass *obj=[GlobalClass getInstance];
                for (NSDictionary *actoAgent in bookmyshow)
                {
                    obj.rel_bms_link= [actoAgent objectForKey:@"web_link"];
                    
                }
                
                obj.rel_trailers = trailers;
                obj.rel_awardCat = award_cat;
                obj.rel_awardInfo = award_info;
                obj.rel_awardMovie = award_movie;
                obj.rel_movieCategory = movie_Category;
                obj.rel_moviedata = movie;
                obj.rel_str = interviewdata;
                obj.rel_onset = onsetdata;
                obj.rel_videolinks = videodata;
                obj.rel_Dwall = wallpaperdata;
                obj.rel_Bookmyshow = book;
                obj.rel_Feedback=feedback1;
                obj.rel_music=music;
                obj.rel_CNC=cnc;
                obj.rel_directorsNote=dirnote;
                obj.rel_category=category;
                obj.rel_BTS=BS_COVER;
                obj.rel_Banner = banner;
                obj.rel_appData=appData;
                obj.rel_productionImage = productionForCNC;
                obj.rel_groups = [json objectForKey:@"groups"];
                obj.rel_fbtoken=fbtoken;
                obj.rel_Notifications=notifications;
                //  obj.Contests=Contests;
                //
                for (NSDictionary *actoAgent in dirnote)
                {
                    obj.rel_dirnote= [actoAgent objectForKey:@"image"];
                    
                }
                
                
                for (NSDictionary *actoAgent in iapp)
                {
                    obj.IAPProduct1= [actoAgent objectForKey:@"wall_key"];
                    NSLog(@"IAPProduct1=%@",obj.IAPProduct1);
                    
                }
                
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_videosharetext= [actoAgent objectForKey:@"trailer"];
                    NSLog(@"trailer=%@",obj.rel_videosharetext);
                    
                }
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_moviesharetxt= [actoAgent objectForKey:@"movie_catalogue"];
                    NSLog(@"trailer=%@",obj.rel_moviesharetxt);
                    
                }
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_wallpapers= [actoAgent objectForKey:@"wallpapers"];
                    NSLog(@"wallpapers=%@",obj.rel_wallpapers);
                    
                }
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_behindscene_video= [actoAgent objectForKey:@"shortscene"];
                    NSLog(@"shortscene=%@",obj.rel_behindscene_video);
                    
                }
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_behindscene_images= [actoAgent objectForKey:@"behindscene_images"];
                    NSLog(@"behindscene_images=%@",obj.behindscene_images);
                    
                }
                
                //            for (NSDictionary *actoAgent in sharetext)
                //            {
                //                obj.newsshare= [actoAgent objectForKey:@"news"];
                //                NSLog(@"newsshare=%@",obj.newsshare);
                //
                //            }
                
                
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_twitter= [actoAgent objectForKey:@"twitter"];
                    NSLog(@"twitter=%@",obj.rel_twitter);
                    
                }
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_facebook= [actoAgent objectForKey:@"facebook"];
                    NSLog(@"facebook=%@",obj.rel_facebook);
                    
                }
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_mug= [actoAgent objectForKey:@"mug"];
                    NSLog(@"mug=%@",obj.rel_mug);
                    
                }
                
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_Tshirt= [actoAgent objectForKey:@"Tshirt"];
                    NSLog(@"Tshirt=%@",obj.rel_Tshirt);
                    
                }
                
                for (NSDictionary *actoAgent in sharetext)
                {
                    obj.rel_movie_poster= [actoAgent objectForKey:@"movie_poster"];
                    NSLog(@"movie_poster=%@",obj.rel_movie_poster);
                    
                }
                
                
                
                
                GlobalClass *OBJ=[GlobalClass getInstance];
                OBJ.fetchall=@"1";
                
                
            }
            
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
    [self getcastncrewdata];
    
    
    
}


-(void)getdata
{
    
    [self getsharetext];
    GlobalClass *obj=[GlobalClass getInstance];
    NSLog(@"moviedata=%@",obj.rel_moviedata);
    
    
    int i=0;
	for (NSDictionary *actoAgent in obj.rel_moviedata)
	{
        
        data1[i]= [actoAgent objectForKey:@"m_id"];
        NSLog(@"m_id=%@",data1[i]);
        NSLog(@"getiID123=%@",getiID);

        if ([data1[i] isEqualToString:getiID])
        {
            data1[i]=getiID;
            idis=i;
        data2[i]= [actoAgent objectForKey:@"m_name"];
        
        data9[i] =  [data2[i] substringToIndex:1];
        
        NSLog(@"m_name=%@",data9[i]);
        
        
        
        data3[i]= [actoAgent objectForKey:@"m_short_name"];
        NSLog(@"m_short_name=%@",data3[i]);
        
        
        data4[i]= [actoAgent objectForKey:@"m_img"];
        
        
        
        data5[i]= [actoAgent objectForKey:@"m_img_thumb"];
        
        
        data6[i]= [actoAgent objectForKey:@"m_desc"];
        
        
        data7[i]= [actoAgent objectForKey:@"m_date"];
        
//        data7[i]= [data7[i] substringToIndex:4];
//        NSLog(@"date=%@",data7[i]);
        
        
        data8[i]= [actoAgent objectForKey:@"m_type"];
            
          
            if (actionBar[i] == nil) {
                NSString *entity_Key= [NSString stringWithFormat:@"%@",data1[i]];
                NSString *entity_name= [NSString stringWithFormat:@"%@",data2[i]];
                self.entity = [SZEntity entityWithKey:entity_Key name:entity_name];
                actionBar[i] = [SZActionBar defaultActionBarWithFrame:CGRectZero entity:self.entity viewController:self];
                actionBar[i].itemsLeft = [NSArray arrayWithObjects:[SZActionButton viewsButton], [actionBar[i].itemsRight objectAtIndex:0], [actionBar[i].itemsRight objectAtIndex:1], nil];
                
                faceBookBtn = [[UIButton alloc] initWithFrame:CGRectZero];
                [faceBookBtn setImage:[UIImage imageNamed:@"facebook_icon.png"] forState:UIControlStateNormal];
                [faceBookBtn sizeToFit];
                [faceBookBtn addTarget:self action:@selector(fbShare:) forControlEvents:UIControlEventTouchUpInside];
                
                
                twitterBtn = [[UIButton alloc] initWithFrame:CGRectZero];
                [twitterBtn setImage:[UIImage imageNamed:@"twitter_icon.png"] forState:UIControlStateNormal];
                [twitterBtn sizeToFit];
                [twitterBtn addTarget:self action:@selector(tweetShare:) forControlEvents:UIControlEventTouchUpInside];
                
                
                emailBtn = [[UIButton alloc] initWithFrame:CGRectZero];
                [emailBtn setImage:[UIImage imageNamed:@"email_icon.png"] forState:UIControlStateNormal];
                [emailBtn sizeToFit];
                [emailBtn addTarget:self action:@selector(mailCompose:) forControlEvents:UIControlEventTouchUpInside];
                
                actionBar[i].betweenButtonsPadding=5.0;
                actionBar[i].backgroundImageView.alpha = 1.0;
                actionBar[i].itemsRight = [NSArray arrayWithObjects:faceBookBtn, twitterBtn,emailBtn, nil];
                
                [socializeBgView addSubview:actionBar[i]];
            }

            
            
            
            
            
            
            _movie_label.text=data2[i];
            _Description.text=data6[i];
            
            if (_image1 == nil)
            {
                _image1 = [[AsyncImageView alloc] initWithFrame:CGRectMake(7, 10, 122, 125)];
                
                _image1.contentMode = UIViewContentModeScaleToFill;
            }
            
            _image1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
            
            _image1.contentMode = UIViewContentModeScaleToFill;
            _image1.userInteractionEnabled=YES;
            
            [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_image1];
            
            _image1.tag=i;
            NSURL *url1 = [NSURL URLWithString:data5[i]];
            NSLog(@"nsurl = %@",url1);
            ((AsyncImageView *)_image1).imageURL =url1;
            [self.view addSubview:_image1];
            //	TotalData=i;
            
        
       }

    }
    [self.view addSubview:socializeBgView];

}

-(void)getcastncrewdata                                                                            
{
    
    GlobalClass *obj=[GlobalClass getInstance];
    NSLog(@"moviedata=%@",obj.rel_CNC);
    
    
    int i=0;
    int j=0;

	for (NSDictionary *actoAgent in obj.rel_CNC)
	{
        
        data1[i]= [actoAgent objectForKey:@"movie_id"];
        NSLog(@"movie_id=%@",data1[i]);
        
        
        if ([data1[i] isEqualToString:getiID]) {
//            data1[i]=getiID;


        
        
        data6[j]= [actoAgent objectForKey:@"cnc_img"];
        
        data8[j]= [actoAgent objectForKey:@"cnc_header_name"];

            NSLog(@"cnc_header_name=%@",data7[j]);

        
        data7[j]= [actoAgent objectForKey:@"cnc_original_name"];
            j++;
        }
        TotalData=j;

    i++;

    
    }
    
    NSLog(@"totaldata=%d",TotalData);
    [_castncrewtable reloadData];

    int k=0;
	for (NSDictionary *actoAgent in obj.rel_videolinks)
	{
        data10[k]= [actoAgent objectForKey:@"shortscene_video"];
		NSLog(@"shortscene_video=%@",data1[k]);
		
		data20[k]= [actoAgent objectForKey:@"shortscene_img"];
		NSLog(@"shortscene_img=%@",data2[k]);
		
		
		data30[k]= [actoAgent objectForKey:@"movie_id"];
		NSLog(@"movie_id=%@",data3[k]);
		
		
		data40[k]= [actoAgent objectForKey:@"shortscene_name"];
		NSLog(@"shortscene_name=%@",data4[k]);
		
		data50[k]= [actoAgent objectForKey:@"shortscene_time"];
		NSLog(@"shortscene_time=%@",data5[k]);
		
		
		data60[k]= [actoAgent objectForKey:@"movie_name"];
		NSLog(@"movie_name=%@",data6[k]);
        if (![movieNameArray containsObject:data6[k]])
        {
            
            [movieNameArray addObject:data6[k]];
        }
        
        
		data70[k]= [actoAgent objectForKey:@"shortscene_desc"];
		NSLog(@"shortscene_desc=%@",data7[k]);
		
		data80[k]= [actoAgent objectForKey:@"shortscene_views"];
		NSLog(@"shortscene_views=%@",data8[k]);
		
        NSString *timeZone =[actoAgent objectForKey:@"link_id"];
        NSArray *newArray=[timeZone componentsSeparatedByString:@"_"];
        fbFeedId[k] = [actoAgent objectForKey:@"shortscene_id"];
        
		data90[k]= [actoAgent objectForKey:@"shortscene_desc"];
		NSLog(@"shortscene_desc=%@",data9[k]);
        
		data110[k]= [actoAgent objectForKey:@"status"];
		NSLog(@"status=%@",data110[k]);
        
		data100[k]= [actoAgent objectForKey:@"premium"];
		NSLog(@"premium=%@",data100[k]);
		
		
		k++;
	}
	TotalShortScene=k;
    
    [self displayShortClips];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    m=0;
    [self getdata];
    [self getcastncrewdata];
    movieNameArray = [[NSMutableArray alloc]init];
    
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
            
            
            [_priceFormatter setLocale:product.priceLocale];
            
            
            _pricelabel.text = [NSString stringWithFormat:@"fee of Rs. %@ \n to see become a premium member!",[_priceFormatter stringFromNumber:product.price]];
            NSLog(@"_products[buyB=%@", _pricelabel.text);
            
            NSLog(@"_products[buyB=%@", _pricelabel.text);
            
            
            
            
        }
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
    
    _IAPVIEWScroller.contentSize = CGSizeMake(320, 500);
    
    //socializeBgView.alpha = 0.0;
    [_castncrewbtn setBackgroundImage:[UIImage imageNamed:@"castcrew_h.png"] forState:UIControlStateNormal];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rel_i4home_bg.jpg"]];

//  [_shortclipsbtn setBackgroundImage:[UIImage imageNamed:@"shortclips_h.png"] forState:UIControlStateNormal];

    VideoScroller.alpha = 0.0;
    // Do any additional setup after loading the view from its nib.
    UIImage *buttonImage = [UIImage imageNamed:@"back-btn.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
	
    
}

-(void)displayShortClips
{
    
    VideoScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(6,224,308,192)];
	VideoScroller.userInteractionEnabled	=YES;
	VideoScroller.showsHorizontalScrollIndicator = YES;
	VideoScroller.pagingEnabled = NO;
    VideoScroller.delegate = self;
	[self.view addSubview:VideoScroller];
	
	 m=0;
	NSLog(@"hi");
	for (int i =0; i<TotalShortScene; i++)
    {
		if([data60[i] isEqualToString:data2[idis]])
        {
            NSLog(@"data2=%@",data2[i]);
            backgroundView[i] = [[UIView alloc]initWithFrame:CGRectMake(6, m, 308,177)];
            backgroundView[i].backgroundColor = [UIColor clearColor];
            backgroundView[i].userInteractionEnabled = YES;

            [VideoScroller addSubview:backgroundView[i]];
            
            
            
            if (webwall[i] == nil)
                
            {
                
                webwall[i] = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 308,140)];
                
                
                
                webwall[i].contentMode = UIViewContentModeScaleToFill;
                
            }
            
            webwall[i].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
            webwall[i].tag = i;
            webwall[i].userInteractionEnabled = YES;
            
            
            //cancel any previously loading images for this view
            
            [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:webwall[i]];
            
            
            
            //set image URL. AsyncImageView class will then dynamically load the image
            
            NSURL *url1 = [NSURL URLWithString:data20[i]];
            
            
            
            ((AsyncImageView *)webwall[i]).imageURL =url1;
            [backgroundView[i] addSubview:webwall[i]];
            
            UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(114, 30, 70, 70)];
            playIcon.image = [UIImage imageNamed:@"video-play-btnRel.png"];
            [webwall[i] addSubview:playIcon];
    		
            MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 308-100, 20)];
            MusicLabel[i].backgroundColor =[UIColor clearColor];
            MusicLabel[i].textColor= [self colorWithHexString:@"314c6a"];
            MusicLabel[i].text=data60[i];
            MusicLabel[i].font = [UIFont boldSystemFontOfSize: 18.0];
            [backgroundView[i] addSubview:MusicLabel[i]];
            
            timeLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(299-50, 140, 50, 20)];
            timeLabel[i].backgroundColor =[UIColor clearColor];
            timeLabel[i].textColor= [self colorWithHexString:@"314c6a"];
            timeLabel[i].text=data50[i];
            timeLabel[i].font = [UIFont boldSystemFontOfSize:17.0];
            [backgroundView[i] addSubview:timeLabel[i]];
            
            UILabel* timeName = [[UILabel alloc] initWithFrame:CGRectMake(299-100,140, 70, 20)];
            timeName.backgroundColor =[UIColor clearColor];
            timeName.textColor= [self colorWithHexString:@"314c6a"];
            timeName.text=@"Time : ";
            timeName.font = [UIFont boldSystemFontOfSize:17.0];
            [backgroundView[i] addSubview:timeName];
            
//            viewsLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(50, 165, 230, 20)];
//            viewsLabel[i].backgroundColor =[UIColor clearColor];
//            viewsLabel[i].textColor= [UIColor blackColor];
//            viewsLabel[i].text=data80[i];
//            viewsLabel[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
//            [backgroundView[i] addSubview:viewsLabel[i]];
//            
//            views[i] = [[UILabel alloc] initWithFrame:CGRectMake(0, 165, 70, 20)];
//            views[i].backgroundColor =[UIColor clearColor];
//            views[i].textColor= [UIColor blackColor];
//            views[i].text=@"Views :";
//            views[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
//            [backgroundView[i] addSubview:views[i]];
            
            gapview[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 165, 308, 12)];
            gapview[i].image = [UIImage imageNamed:@"divder.png"];
            [backgroundView[i] addSubview:gapview[i]];
            
            UITapGestureRecognizer *tapped123 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
            tapped123.numberOfTapsRequired = 1;
            tapped123.delegate=self;
            [webwall[i] addGestureRecognizer:tapped123];
            
            if ([data110[i] isEqualToString:@"1"])
            {
                 lockImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 308,140)];
                lockImage.image = [UIImage imageNamed:@"premi_video.png"];
                [webwall[i] addSubview:lockImage];
            }
            m+=179;
        }
    }
   	VideoScroller.contentSize = CGSizeMake(308,m+30);
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
	NSLog(@"gesturs");
	UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    
    if ([data110[gesture.view.tag] isEqualToString:@"1"]) {
        _IAPVIEW.alpha=1.0;
        [self.view addSubview:_IAPVIEW];
        
        
        SKProduct *product = _products[0];
        
        [_priceFormatter setLocale:product.priceLocale];
        
        
        _pricelabel.text = [NSString stringWithFormat:@"fee of . %@ \n to see become a premium member!",[_priceFormatter stringFromNumber:product.price]];
        NSLog(@"_products[buyB=%@", _pricelabel.text);
        
        
    }
    else
    {

    
    iphone4PlayVideo *loginViewController = [[iphone4PlayVideo alloc] initWithNibName:@"iphone4PlayVideo" bundle:nil];
    loginViewController.idis = [NSString stringWithFormat:@"%@",data10[gesture.view.tag]];
    loginViewController.time = [NSString stringWithFormat:@"%@",data50[gesture.view.tag]];
    loginViewController.entity_name=data40[gesture.view.tag];
    loginViewController.entity_Key=fbFeedId[gesture.view.tag];

   // loginViewController.premiumType = data100[gesture.view.tag];
    loginViewController.musicLabel = [NSString stringWithFormat:@"%@",data40[gesture.view.tag]];
    [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Video Clicked"
                                                    withAction:data1[gesture.view.tag]
                                                     withLabel:@"Video"
                                                     withValue:nil];
    [self.navigationController pushViewController:loginViewController animated:NO];
   
    }
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)castncrewTapped:(id)sender
{
   
    [_castncrewbtn setBackgroundImage:[UIImage imageNamed:@"castcrew_h.png"] forState:UIControlStateNormal];
    
    
    [_shortclipsbtn setBackgroundImage:[UIImage imageNamed:@"shortclips.png"] forState:UIControlStateNormal];
    _castncrewtable.alpha = 1.0;
    VideoScroller.alpha = 0.0;

}
-(IBAction)shortclipsTapped:(id)sender
{
    if(m==0)
    {
        UIAlertView *noMovieAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Oops! No movies matching your search" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        noMovieAlert.tag = 4;
        [noMovieAlert show];
    }

    [_castncrewbtn setBackgroundImage:[UIImage imageNamed:@"castcrew.png"] forState:UIControlStateNormal];
    
    
    [_shortclipsbtn setBackgroundImage:[UIImage imageNamed:@"shortclips_h.png"] forState:UIControlStateNormal];
    _castncrewtable.alpha = 0.0;
    VideoScroller.alpha = 1.0;
    
   
}


- (UIColor *) colorWithHexString: (NSString *) hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
	
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
	
    if ([cString length] != 6) return  [UIColor grayColor];
	
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
	
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
	
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
	
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TotalData;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [[GalleryScroll subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [GalleryScroll removeFromSuperview];
//    GalleryScroll=nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return 104.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Transaction";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    NSURL *url1 = [NSURL URLWithString:data6[indexPath.row]];

    cell.imageView.image=[UIImage imageNamed:@"color_pacth_400x400.png"];
    [cell.imageView setImageURL:url1];
    cell.textLabel.textColor = [self colorWithHexString:@"314c6a"];

    cell.textLabel.text= [NSString stringWithFormat:@"%@",data7[indexPath.row]];
    cell.textLabel.numberOfLines = 2;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];

    cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",data8[indexPath.row]];
    cell.detailTextLabel.numberOfLines = 2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       



    return cell;
}
-(IBAction)OpenTrailers:(id)sender
{
    
//    int m;
//    m = [getiID integerValue];
    NSLog(@"data2=%@",data2[idis]);
    R_Trailers_4 *trailers = [[R_Trailers_4 alloc] initWithNibName:@"R_Trailers_4" bundle:nil];
    trailers.moviename=data2[idis];
//    trailers.tagg=@"1";
    [self.navigationController pushViewController:trailers animated:NO];

    
}
 
-(IBAction)OpenFilmStills:(id)sender
{
    //    int m;
    //    m = [getiID integerValue];
    R_Trailers_4 *trailers = [[R_Trailers_4 alloc] initWithNibName:@"R_Trailers_4" bundle:nil];
    trailers.moviename=data2[idis];
    trailers.tagg=@"1";

    [self.navigationController pushViewController:trailers animated:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getsharetext

{
    
    GlobalClass *obj=[GlobalClass getInstance];
    NSLog(@"images=%@",obj.rel_moviesharetxt);
    
  
        fbsharetext = [obj.rel_moviesharetxt objectForKey:@"fb_share"];
        NSLog(@"fb_share=%@",fbsharetext);
        
        twtsharetext = [obj.rel_moviesharetxt objectForKey:@"twitter_share"];
        NSLog(@"twitter_share=%@",twtsharetext);
        
        
        mailsharesub = [obj.rel_moviesharetxt objectForKey:@"email_subject"];
        NSLog(@"email_subject=%@",mailsharesub);
        
        
        mailsharetext = [obj.rel_moviesharetxt objectForKey:@"email_share"];
        NSLog(@"email_share=%@",mailsharetext);
        
 
}

#pragma mark Compose Mail
-(IBAction)mailCompose:(id)sender
{
	
	//gesture.view.tag);
	
	
	
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet:mailsharetext];
		}
		
		else
		{
			[self launchMailAppOnDevice:mailsharetext];
		}
	}
	
	else
	{
		[self launchMailAppOnDevice:mailsharetext];
	}
	
}
// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayComposerSheet:(NSString*)String
{
    NSLog(@"sharetext in MAIL = %@",mailsharetext);
    
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    
    [picker setSubject:mailsharesub];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@""];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    NSString	*str= [NSString stringWithFormat:@"%@",mailsharetext];
    [picker setToRecipients:toRecipients];
    [picker setCcRecipients:ccRecipients];
    NSString *emailBody = str;
    [picker setMessageBody:emailBody isHTML:NO];
    
    
	[self presentModalViewController:picker animated:YES];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	//	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//[self dismissModalViewControllerAnimated:YES];
			//message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			//[self dismissModalViewControllerAnimated:YES];
			//message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			//message.text = @"Result: sent";
			//[self dismissModalViewControllerAnimated:YES];
			break;
		case MFMailComposeResultFailed:
			//message.text = @"Result: failed";
			//[self dismissModalViewControllerAnimated:YES];
			break;
		default:
			//message.text = @"Result: not sent";
			//[self dismissModalViewControllerAnimated:YES];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice:(NSString*)string
{
	NSString *recipients = @"mailto:?cc=&subject=Check out this awesome Besharam Video ";
	//NSString *body = @"&body=All Dabangg 2 Movie details are Available on Dabangg2 App!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, string];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (IBAction)tweetShare:(UIButton *)sender {
    NSLog(@"str=%@",mailsharetext);
    
    NSUInteger check = [[NSUserDefaults standardUserDefaults] integerForKey:@"twtSwitch"];
        
    if (check==1 || check==2)
    {
        NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
        [setUserDefaults setInteger:1 forKey:@"twtSwitch"];
        
        //  Create an instance of the Tweet Sheet
        TWTweetComposeViewController *tweetSheet =
        [[TWTweetComposeViewController alloc] init];
        
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any UI updates occur
        // on the main queue
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result) {
            switch(result) {
                case TWTweetComposeViewControllerResultCancelled:
                    //  This means the user cancelled without sending the Tweet
                    break;
                case TWTweetComposeViewControllerResultDone:
                    //  This means the user hit 'Send'
                    break;
            }
            
            
            //  dismiss the Tweet Sheet
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    NSLog(@"Tweet Sheet has been dismissed.");
                }];
            });
        };
        //NSString	*str= [NSString stringWithFormat:@"Downloaded wallpaper:%@ from official Besharam App. Get free copy of App @http://tinyurl.com/off-yjhd",shareText];
        
        
        //NSString *strtweet= [NSString stringWithFormat:@"Reading exciting news on the official Yeh Jawaani Hai Deewani App. Get free copy of the App @http://tinyurl.com/off-yjhd"];
        
        //  Set the initial body of the Tweet
        [tweetSheet setInitialText:twtsharetext];
        
        //  Adds an image to the Tweet
        //  For demo purposes, assume we have an image named 'larry.png'
        //  that we wish to attach
        //	if (![tweetSheet addImage:[UIImage imageNamed:shareText]]) {
        //		NSLog(@"Unable to add the image!");
        //	}
        
        //  Add an URL to the Tweet.  You can add multiple URLs.
        if (![tweetSheet addURL:[NSURL URLWithString:mailsharetext]]){
            NSLog(@"Unable to add the URL!");
        }
        
        //  Presents the Tweet Sheet to the user
        [self presentViewController:tweetSheet animated:NO completion:^{
            NSLog(@"Tweet sheet has been presented.");
        }];

        
    }
    
    else
    {
        UIAlertView *twtAlert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please go to the profile section and turn on Facebook / Twitter settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        twtAlert.tag=0;
        [twtAlert show];
        
    }

       
}

- (IBAction)fbShare:(UIButton *)sender
{
    //        NSString *str=[NSString stringWithFormat:@"Downloaded this amazing wallpaper: %@ from official YJHD App. Get free copy of the App @<tiny url>",titleMusic.text];
    //        post = [[FBFeedPost alloc] initWithLinkPath:@"http://ow.ly/g4bRR" caption:str];
    
    NSUInteger check = [[NSUserDefaults standardUserDefaults] integerForKey:@"fbSwitch"];
    if (check==1 || check==2)
    {
        NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
        [setUserDefaults setInteger:1 forKey:@"fbSwitch"];
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            
            
            [self fbios6:fbsharetext];
            
            
        }
        
        else
        {
            UIAlertView* logoutalertbox = [[ UIAlertView alloc]initWithTitle:@"Facebook login required!" message:@"To continue, please log into your Facebook Account through device settings." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil ];
            //   logoutalertbox.tag=5;
            logoutalertbox.delegate=self;
            [logoutalertbox show];
            
        }
        
        

        
    }
    
    else
    {
        UIAlertView *twtAlert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please go to the profile section and turn on Facebook / Twitter settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        twtAlert.tag=0;
        [twtAlert show];
        
    }
    

        
    
    
}

-(void)fbios6:(NSString*)stringis
{
    NSLog(@"stringsis=%@",stringis);
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        
        //   [fbController addImage:[UIImage imageNamed:@"114x114.png"]];
        [fbController setInitialText:fbsharetext];
        [fbController addURL:[NSURL URLWithString:stringis]];
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    
}

- (IBAction)shareButton:(UIButton*)sender
{
    [self.view addSubview:socializeBgView];

    if(socializeBgView.alpha == 0.0)
    {
        socializeBgView.alpha = 1.0;
    }
    else if(socializeBgView.alpha == 1.0)
    {
        socializeBgView.alpha = 0.0;
    }
    


    
   }
@end
