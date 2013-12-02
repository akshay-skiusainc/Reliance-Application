//
//  ShortScenesVC.m
//  RelianceApplication
//
//  Created by Ashwini Pawar on 12/10/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import "ShortScenesVC.h"
#import "AppDelegate.h"
#import "CustomAlertView.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "iphone4PlayVideo.h"

@interface ShortScenesVC ()

@end

@implementation ShortScenesVC
@synthesize Scroller = _Scroller;
@synthesize LOGINVIEW,sharebtn,footerView,IAPVIEWScroller,movieSearch,movieNameArray,movieTable,imgIndex;

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
    obj.rel_videolinks=nil;

//    if ([obj.REL_DATA isEqualToString:@"0"]) {
    
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
//    }
    
}

- (void)productPurchased:(NSNotification *)notification {
    
    NSString * productIdentifier = notification.object;
    NSLog(@"proo===%@",productIdentifier);
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            NSLog(@"PROCT PURCHAED");
            [self performSelector:@selector(restoreDone) withObject:nil afterDelay:0.0];
            [self performSelector:@selector(timercalled) withObject:nil afterDelay:1.0];            //   [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
    //
    [self getsharetext];
       
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
    
    
    movieNameArray = [[NSMutableArray alloc]init];
    [movieNameArray insertObject:@"All" atIndex:0];
    
	[self.navigationController setNavigationBarHidden:NO animated:NO];
    [self DisplayVideos];
    
    self.trackedViewName=@"Video Screen";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg.jpg"]];
    
    movieTable.hidden = YES;
    [movieTable setSeparatorColor:[self colorWithHexString:@"1f3a55"]];
    movieTable.backgroundColor  =[self colorWithHexString:@"13202d"];

	[_Scroller setContentSize:CGSizeMake(320, 173*3)];
    footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg.png"]];
    
    if([_TAG isEqual: @"REL_LEFT"])
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
    
    self.trackedViewName=@"Reliance Short Scenes";
    
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
 	[self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:YES];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
    [_timer invalidate];
    _timer = nil;
    movieTable.hidden=YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [movieNameArray count];
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    movieSearch.text = @"All";
//    tapped123[i] = nil;
 
    [[VideoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [VideoScroller removeFromSuperview];
    VideoScroller=nil;
   
    [self performSelector:@selector(DisplayVideos) withObject:nil afterDelay:0.0];
    movieSearch.text=[NSString stringWithFormat:@"%@",[movieNameArray objectAtIndex:indexPath.row]];
    
    movieTable.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FilmStills";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.backgroundColor  =[self colorWithHexString:@"13202d"];

    
    cell.textLabel.textColor = [UIColor whiteColor];
     cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    NSLog(@"MovieArray in cellForRow = %@",movieNameArray);
    
    cell.textLabel.text=[movieNameArray objectAtIndex:indexPath.row];
    
    
    return cell;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if(textField == movieSearch)
    {
        NSLog(@"Ashwini");
        [self.view endEditing:YES]; // added this in for case when keyboard was already on screen
        
        if (movieTable.hidden) {
            movieTable.hidden = NO;
            
        }
        else
            movieTable.hidden = YES;
        
        [movieSearch resignFirstResponder];
        
    }
    return NO;
}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getdata
{
	GlobalClass *obj=[GlobalClass getInstance];
	NSLog(@"ddata=%@",obj.rel_videolinks);
  	int i=0;
	for (NSDictionary *actoAgent in obj.rel_videolinks)
	{
        data1[i]= [actoAgent objectForKey:@"shortscene_video"];
		NSLog(@"shortscene_video=%@",data1[i]);
		
		data2[i]= [actoAgent objectForKey:@"shortscene_img"];
		NSLog(@"shortscene_img=%@",data2[i]);
		
		
		data3[i]= [actoAgent objectForKey:@"movie_id"];
		NSLog(@"movie_id=%@",data3[i]);
		
		
		data4[i]= [actoAgent objectForKey:@"shortscene_name"];
		NSLog(@"shortscene_name=%@",data4[i]);
		
		data5[i]= [actoAgent objectForKey:@"shortscene_time"];
		NSLog(@"shortscene_time=%@",data5[i]);
		
		
		data6[i]= [actoAgent objectForKey:@"movie_name"];
		NSLog(@"movie_name=%@",data6[i]);
        if (![movieNameArray containsObject:data6[i]])
        {
            
            [movieNameArray addObject:data6[i]];
        }
        
        [movieNameArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		data7[i]= [actoAgent objectForKey:@"shortscene_desc"];
		NSLog(@"shortscene_desc=%@",data7[i]);
		
		data8[i]= [actoAgent objectForKey:@"shortscene_views"];
		NSLog(@"shortscene_views=%@",data8[i]);
		
        NSString *timeZone =[actoAgent objectForKey:@"link_id"];
        NSArray *newArray=[timeZone componentsSeparatedByString:@"_"];
        fbFeedId[i] = [actoAgent objectForKey:@"shortscene_id"];
        
		data9[i]= [actoAgent objectForKey:@"shortscene_desc"];
		NSLog(@"shortscene_desc=%@",data9[i]);
        
		data11[i]= [actoAgent objectForKey:@"status"];
		NSLog(@"status=%@",data11[i]);
        
		data10[i]= [actoAgent objectForKey:@"premium"];
		NSLog(@"premium=%@",data10[i]);
		
		
		i++;
	}
	TotalData=i;
	
}
-(void)DisplayVideos
{
    
    [[VideoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [VideoScroller removeFromSuperview];
    VideoScroller=nil;
    
	[self getdata];
    if(![movieNameArray containsObject:movieSearch.text] )
    {
        UIAlertView *noMovieAlert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"There are no posts for selected movie!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        noMovieAlert.tag = 5;
        [noMovieAlert show];
    }
    else
    {
    

    
	VideoScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0,50,320,366)];
	VideoScroller.userInteractionEnabled	=YES;
	VideoScroller.showsHorizontalScrollIndicator = YES;
	VideoScroller.pagingEnabled = NO;
	[self.view addSubview:VideoScroller];
	
	int m=0;
	NSLog(@"hi");
	for (int i =0; i<TotalData; i++)
    {
		if([data6[i] isEqualToString:movieSearch.text])
        {
            NSLog(@"data2=%@",data2[i]);
            backgroundView[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 320,220)];
            backgroundView[i].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shortscene.png"]];
            [VideoScroller addSubview:backgroundView[i]];
            
            
            
            if (webwall[i] == nil)
                
            {
                
                webwall[i] = [[AsyncImageView alloc] initWithFrame:CGRectMake(8, 30, 306,180)];
                
                
                
                webwall[i].contentMode = UIViewContentModeScaleToFill;
                
            }
            
            webwall[i].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
            webwall[i].userInteractionEnabled = YES;

            webwall[i].tag = i;

            
            //cancel any previously loading images for this view
            
            [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:webwall[i]];
            
            
            
            //set image URL. AsyncImageView class will then dynamically load the image
            
            NSURL *url1 = [NSURL URLWithString:data2[i]];
            
            
            
            ((AsyncImageView *)webwall[i]).imageURL =url1;
            [backgroundView[i] addSubview:webwall[i]];
            if(!tapped123[i])
            {
            
            tapped123[i] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
            tapped123[i].numberOfTapsRequired = 1;
            tapped123[i].delegate=self;
            [webwall[i] addGestureRecognizer:tapped123[i]];
                
            
            }
    		
            UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(114, 50, 70, 70)];
            playIcon.image = [UIImage imageNamed:@"video-play-btnRel.png"];
            [webwall[i] addSubview:playIcon];
            
            MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(8, 7, 308-100, 20)];
            MusicLabel[i].backgroundColor =[UIColor clearColor];
            MusicLabel[i].textColor= [UIColor blackColor];
            MusicLabel[i].text=data6[i];
            MusicLabel[i].font = [UIFont boldSystemFontOfSize: 18.0];
            [backgroundView[i] addSubview:MusicLabel[i]];
            
            timeLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(299-50, 7, 50, 20)];
            timeLabel[i].backgroundColor =[UIColor clearColor];
            timeLabel[i].textColor= [UIColor blackColor];
            timeLabel[i].text=data5[i];
            timeLabel[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
            [backgroundView[i] addSubview:timeLabel[i]];
           
            UILabel* timeName = [[UILabel alloc] initWithFrame:CGRectMake(299-100,7, 70, 20)];
            timeName.backgroundColor =[UIColor clearColor];
            timeName.textColor= [UIColor blackColor];
            timeName.text=@"Time : ";
            timeName.font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
            [backgroundView[i] addSubview:timeName];

                      
            if ([data11[i] isEqualToString:@"1"])
            {
                if (!lockImage[i]) {
                    
                lockImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 306,180)];
                lockImage[i].image = [UIImage imageNamed:@"premi_video.png"];
                [webwall[i] addSubview:lockImage[i]];
                }

            }
            else{
                lockImage[i].image = [UIImage imageNamed:@""];
              
                }

            
            m+=220;
        }
        
        
        else if([movieSearch.text isEqualToString:@"All"])
        {
            NSLog(@"data2=%@",data2[i]);
            backgroundView[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 320,220)];
            backgroundView[i].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shortscene.png"]];
            [VideoScroller addSubview:backgroundView[i]];
            
            
            
            if (webwall[i] == nil)
                
            {
                
                webwall[i] = [[AsyncImageView alloc] initWithFrame:CGRectMake(8, 30, 306,180)];
                
                
                
                webwall[i].contentMode = UIViewContentModeScaleToFill;
                
            }
            
            webwall[i].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
            
            webwall[i].tag = i;
            webwall[i].userInteractionEnabled = YES;
            
            
            //cancel any previously loading images for this view
            
            [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:webwall[i]];
            
            
            
            //set image URL. AsyncImageView class will then dynamically load the image
            
            NSURL *url1 = [NSURL URLWithString:data2[i]];
            
            
            
            ((AsyncImageView *)webwall[i]).imageURL =url1;
            [backgroundView[i] addSubview:webwall[i]];
            if(!tapped123[i])
            {

            tapped123[i] = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
            tapped123[i].numberOfTapsRequired = 1;
            tapped123[i].delegate=self;
            [webwall[i] addGestureRecognizer:tapped123[i]];
            }
            
            UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(114, 50, 70, 70)];
            playIcon.image = [UIImage imageNamed:@"video-play-btnRel.png"];
            [webwall[i] addSubview:playIcon];
            
            MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(8, 7, 308-100, 20)];
            MusicLabel[i].backgroundColor =[UIColor clearColor];
            MusicLabel[i].textColor= [UIColor blackColor];
            MusicLabel[i].text=data6[i];
            MusicLabel[i].font = [UIFont boldSystemFontOfSize: 18.0];
            [backgroundView[i] addSubview:MusicLabel[i]];
            
            timeLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(299-50, 7, 50, 20)];
            timeLabel[i].backgroundColor =[UIColor clearColor];
            timeLabel[i].textColor= [UIColor blackColor];
            timeLabel[i].text=data5[i];
            timeLabel[i].font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
            [backgroundView[i] addSubview:timeLabel[i]];
            
            UILabel* timeName = [[UILabel alloc] initWithFrame:CGRectMake(299-100,7, 70, 20)];
            timeName.backgroundColor =[UIColor clearColor];
            timeName.textColor= [UIColor blackColor];
            timeName.text=@"Time : ";
            timeName.font = [UIFont fontWithName:@"Helvetica Neue" size: 17.0];
            [backgroundView[i] addSubview:timeName];

            
            if ([data11[i] isEqualToString:@"1"])
            {
                NSLog(@"dataPAID");
                if (!lockImage[i]) {

                lockImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 306,180)];
                lockImage[i].image = [UIImage imageNamed:@"premi_video.png"];
                [webwall[i] addSubview:lockImage[i]];
                }
            }
            else{
                lockImage[i].image = [UIImage imageNamed:@""];
                
            }

            m+=220;
        }
       
	}
    
	
	VideoScroller.contentSize = CGSizeMake(299,m+30);
	[self.view addSubview:movieTable];
    }
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


- (IBAction)openFooter:(id)sender
{
    if(self.view.frame.origin.y == 0)
    {
        [UIView beginAnimations:@"Animate Text Field Up" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -57,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else if(self.view.frame.origin.y == -57)
    {
        [UIView beginAnimations:@"Animate Text Field Up" context:nil];
        [UIView setAnimationDuration:.3];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     0,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
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
	NSLog(@"gesturs");
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
        
        iphone4PlayVideo *loginViewController = [[iphone4PlayVideo alloc] initWithVCTag:@"FromBehindScene"];
        loginViewController.idis =data1[gesture.view.tag];
        loginViewController.entity_name=data4[gesture.view.tag];
        loginViewController.entity_Key=fbFeedId[gesture.view.tag];
        //        loginViewController.songTitle = data4[gesture.view.tag];
        //        loginViewController.time = data5[gesture.view.tag];
        //        loginViewController.singer = data6[gesture.view.tag];
        //        loginViewController.lyrics = data7[gesture.view.tag];
        //        loginViewController.musicDirector = data3[gesture.view.tag];
        //       loginViewController.premiumType = data10[gesture.view.tag];
        //       loginViewController.musicLabel = data9[gesture.view.tag];
        [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Video Clicked"
                                                        withAction:data1[gesture.view.tag]
                                                         withLabel:@"Video"
                                                         withValue:nil];
        [self.navigationController pushViewController:loginViewController animated:NO];
        
    }

	
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    // [self performSelector:@selector(openFooter1:) withObject:nil afterDelay:0.01 ];
    _footerMainView.frame = CGRectMake(0, 398, _footerMainView.frame.size.width, _footerMainView.frame.size.height);
    
}



- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"yes");
	for (int i =0; i<TotalData; i++) {
		
		
		if (webView.tag==i) {
			
			
			ActIndImage1[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,299,187)];
			//  ActIndImage1[i].center = CGPointMake(320/2, 460/2);
			ActIndImage1[i].image = [UIImage imageNamed:@"color_pacth_400x400.png"];
			ActIndImage1[i].alpha = 0.7;
			[webwall[i] addSubview:ActIndImage1[i]];
			
			activityIndicator1[i] = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
			activityIndicator1[i].center=CGPointMake(299/2, 187/2);
			//activityIndicator1[i].transform = CGAffineTransformMakeScale(1.0, 1.0);
			[activityIndicator1[i] setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
			[ActIndImage1[i] addSubview:activityIndicator1[i]];
			
			
			[activityIndicator1[i] startAnimating];
			
		}
		
		
		
		else {
			
		}
	}
	
	//[self performSelector:@selector(unloadAct) withObject:nil afterDelay:0.2];
	
	
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

- (void)viewDidUnload
{
    [self setScroller:nil];
	[self setLOGINVIEW:nil];
	[self setSharebtn:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark Compose Mail

-(IBAction)mailCompose:(UIButton *)sender

{
    
    imgIndex=sender.tag;
    
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
        
    {
        
        // We must always check whether the current device is configured for sending emails
        
        
        if ([mailClass canSendMail])
            
        {
            
            [self displayComposerSheet:shareText];
            
        }
        
        
        else
            
        {
            
            [self launchMailAppOnDevice:shareText];
            
        }
        
    }
    
    
    else
        
    {
        
        [self launchMailAppOnDevice:shareText];
        
    }
    
    
}

// Displays an email composition interface inside the application. Populates all the Mail fields.

-(void)displayComposerSheet:(NSString*)String

{
    
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self;
    
    
    
    [picker setSubject:mailsharesub];
    
    
    
    
    // Set up recipients
    
    NSArray *toRecipients = [NSArray arrayWithObject:@""];
    
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil];
    
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    
    [picker setToRecipients:toRecipients];
    
    [picker setCcRecipients:ccRecipients];
    
    ///   NSString *emailBody = str;
    //
    //    [picker setMessageBody:emailBody isHTML:NO];
    
    
    
    
    
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

-(void)getsharetext

{
    GlobalClass *obj=[GlobalClass getInstance];
    
    
    fbsharetext = [obj.rel_behindscene_video objectForKey:@"fb_share"];
    NSLog(@"fb_share=%@",fbsharetext);
    
    twtsharetext = [obj.rel_behindscene_video objectForKey:@"twitter_share"];
    NSLog(@"twitter_share=%@",twtsharetext);
    
    
    mailsharesub = [obj.rel_behindscene_video objectForKey:@"email_subject"];
    NSLog(@"email_subject=%@",mailsharesub);
    
    
    mailsharetext = [obj.rel_behindscene_video objectForKey:@"email_share"];
    NSLog(@"email_share=%@",mailsharetext);
    
    
    
    
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



- (IBAction)twitter:(UIButton *)sender {
    
    
    
    NSUInteger check1 = [[NSUserDefaults standardUserDefaults] integerForKey:@"twtSwitch"];
    if (check1==1 || check1==2)
    {
        NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
        [setUserDefaults setInteger:1 forKey:@"twtSwitch"];
        
        imgIndex=sender.tag;
        
        strr= [NSString stringWithFormat:@"%@",data3[imgIndex]];
        
        shareText= strr;
        
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
        
        //	 NSLog(@"Unable to add the image!");
        
        //	}
        
        
        //  Add an URL to the Tweet.  You can add multiple URLs.
        
        if (![tweetSheet addURL:[NSURL URLWithString:shareText]]){
            
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
    
    NSUInteger check1 = [[NSUserDefaults standardUserDefaults] integerForKey:@"fbSwitch"];
    if (check1==1 || check1==2)
    {
        NSUserDefaults *setUserDefaults=[NSUserDefaults standardUserDefaults];
        [setUserDefaults setInteger:1 forKey:@"fbSwitch"];
        
        int a =sender.tag;
        
        //	NSString *str=[NSString stringWithFormat:@"Downloaded this amazing wallpaper: %@ from official YJHD App. Get free copy of the App @<tiny url>",titleMusic.text];
        
        //	post = [[FBFeedPost alloc] initWithLinkPath:@"http://ow.ly/g4bRR" caption:str];
        
        strr= [NSString stringWithFormat:@"%@",data3[a]];
        
        shareText= strr;
        
        
        
        NSString *ver = [[UIDevice currentDevice] systemVersion];
        
        float ver_float = [ver floatValue];
        
        if (ver_float < 6.0)
            
        {
            
            
        }
        
        else{
            
            
            
            
            
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                
                
                
                
                
                [self fbios6:shareText];
                
                
                
                
                
            }
            
            
            
            else
                
            {
                
                UIAlertView* logoutalertbox = [[ UIAlertView alloc]initWithTitle:@"Facebook login required!" message:@"To continue, please log into your Facebook Account through device settings." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil ];
                
                //   logoutalertbox.tag=5;
                
                logoutalertbox.delegate=self;
                
                [logoutalertbox show];
                
                
                
            }
            
            
            
            
            
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
        
        
        ;
        
        [fbController setInitialText:fbsharetext];
        
        [fbController addURL:[NSURL URLWithString:stringis]];
        
        [fbController setCompletionHandler:completionHandler];
        
        [self presentViewController:fbController animated:YES completion:nil];
        
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag ==5)
    {
    if(buttonIndex == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
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
