//
//  R_Trailers_5.m
//  RelianceApplication
//
//  Created by Ashwini Pawar on 23/10/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import "R_Trailers_5.h"
#import "DatabaseClass.h"
#import "GlobalClass.h"
#import "R_OpenStills_5.h"

@interface R_Trailers_5 ()

@end

@implementation R_Trailers_5


@synthesize Scroller;
@synthesize LOGINVIEW,IAPVIEWScroller,stillTable,imgIndex,movieTagFromOpenMv;
@synthesize TotalData1,movieSearch,movieTable,movieNameArray,movieNameArrayForStills,moviename,tagg;
@synthesize b,newTag,nX,nY,loaderCount,currentScrollPosition,finalCount,m;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStr:(NSString *)_str
{
    self = [super init];
    if (self)
    {
        movieSearch.text = _str;
        
    }
    return self;
}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:YES];
//    movieTable.hidden=YES;
//    stillTable.hidden=YES;
//    
//    
//    
//}
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
        NSLog(@"restoreDone json=%@",json);
        
        
        [self getAllData];
        // [self getdata];
        
    }
}

-(void)getAllData{
    
    
	
    NSLog(@"iphone4viewcontroller called ***************************");
	
	GlobalClass *obj=[GlobalClass getInstance];
        
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
                NSDictionary *RightNavMovieLogo = [json objectForKey:@"movie_icon"];
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
                obj.rel_RightNavMovieLogo = RightNavMovieLogo;
                
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
    
    [[Scroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [Scroller removeFromSuperview];
    Scroller=nil;

    [self DisplayVideos];
    [self DisplayFilmStills];
    if (check==1) {
        VideoScroller.alpha=0.0;
        [_trailersButton setBackgroundImage:[UIImage imageNamed:@"trailers_btn.png"] forState:UIControlStateNormal];
        [_filmStillButton setBackgroundImage:[UIImage imageNamed:@"stills_btn.png"] forState:UIControlStateNormal];
        //        [self DisplayFilmStills];
        check=1;
        
    }
    else if(check==0){
        Scroller.alpha = 0.0;
        [_trailersButton setBackgroundImage:[UIImage imageNamed:@"trailers_btn_h.png"] forState:UIControlStateNormal];
        [_filmStillButton setBackgroundImage:[UIImage imageNamed:@"stills_btn_h.png"] forState:UIControlStateNormal];
        
    }
    
    

    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    check=0;
    if (moviename ==nil)
    {
        movieSearch.text = @"All";
    }
    else
    {
        movieSearch.text =moviename;
        
    }

    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
	activityIndicator.center=CGPointMake(320/2, 504/2);
	[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
	[self.view addSubview:activityIndicator];
	[activityIndicator startAnimating];
    
      
    
    movieTable.hidden = YES;
    stillTable.hidden = YES;
    [movieTable setSeparatorColor:[self colorWithHexString:@"1f3a55"]];
    [stillTable setSeparatorColor:[self colorWithHexString:@"1f3a55"]];
    movieTable.backgroundColor  =[self colorWithHexString:@"13202d"];
    stillTable.backgroundColor  =[self colorWithHexString:@"13202d"];
    movieNameArray=[[NSMutableArray alloc]init];
    movieNameArrayForStills=[[NSMutableArray alloc]init];
    
    [movieNameArray insertObject:@"All" atIndex:0];
    [movieNameArrayForStills insertObject:@"All" atIndex:0];
    
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
    
    
    
	
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg.jpg"]];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.trackedViewName=@"Reliance trailers";
    
	
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue()	, ^{
            [self DisplayVideos];
            
            if ([tagg isEqualToString:@"1"]) {
                VideoScroller.alpha=0.0;
                [_trailersButton setBackgroundImage:[UIImage imageNamed:@"trailers_btn.png"] forState:UIControlStateNormal];
                [_filmStillButton setBackgroundImage:[UIImage imageNamed:@"stills_btn.png"] forState:UIControlStateNormal];
                [self DisplayFilmStills];
                check=1;

            }
            else{
                Scroller.alpha = 0.0;
                [_trailersButton setBackgroundImage:[UIImage imageNamed:@"trailers_btn_h.png"] forState:UIControlStateNormal];
                [_filmStillButton setBackgroundImage:[UIImage imageNamed:@"stills_btn_h.png"] forState:UIControlStateNormal];
                
            }
        });
        
        
    });
	
    
    
    
    
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
    
    activityIndicator2 = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    activityIndicator2.center=CGPointMake(320/2, 488);
    [activityIndicator2 setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:activityIndicator2];
    activityIndicator2.alpha = 0.0;
    
}
-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger intCount = 0;
    if(tableView == movieTable)
    {
        intCount = [movieNameArray count];
    }
    if(tableView == stillTable)
    {
        intCount = [movieNameArrayForStills count];
    }
    return intCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for(int a=0;a<TotalData1;a++)
        
    {
        actionBar[a] = nil;
    }
    for(int a=0;a<TotalData;a++)
        
    {
        actionBarStills[a] = nil;
    }
    
    
    [[VideoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [VideoScroller removeFromSuperview];
    VideoScroller=nil;
    
    [[Scroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [Scroller removeFromSuperview];
    Scroller=nil;
    
//    if(movieTable.hidden == NO)
    if(check==0)

    {
        [self performSelector:@selector(DisplayVideos) withObject:nil afterDelay:0.0];
        movieSearch.text=[NSString stringWithFormat:@"%@",[movieNameArray objectAtIndex:indexPath.row]];
        
    }
//    else if(stillTable.hidden == NO)
    if(check==1)

    {
        [self performSelector:@selector(DisplayFilmStills) withObject:nil afterDelay:0.0];
        
        movieSearch.text=[NSString stringWithFormat:@"%@",[movieNameArrayForStills objectAtIndex:indexPath.row]];
        
    }
    movieTable.hidden = YES;
    stillTable.hidden = YES;
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
    
    if(tableView == movieTable)
    {
        NSLog(@"MovieArray in cellForRow = %@",movieNameArray);
        
        cell.textLabel.text=[movieNameArray objectAtIndex:indexPath.row];
        
        
    }
    else if(tableView == stillTable)
    {
        NSLog(@"MovieArrayForStill in cellForRow = %@",movieNameArrayForStills);
        
        cell.textLabel.text=[movieNameArrayForStills objectAtIndex:indexPath.row];
    }
    
    
    
    return cell;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if(textField == movieSearch)
    {
        NSLog(@"Ashwini");
        [self.view endEditing:YES]; // added this in for case when keyboard was already on screen
        if(VideoScroller.alpha == 1.0)
        {
            
            if (movieTable.hidden) {
                movieTable.hidden = NO;
                
            }
            else
                movieTable.hidden = YES;
            
            
            
            
            if (stillTable.hidden) {
                stillTable.hidden = NO;
                
            }
            else
                stillTable.hidden = YES;
        }
        if(Scroller.alpha == 1.0)
        {
            if (stillTable.hidden) {
                stillTable.hidden = NO;
                
            }
            else
                stillTable.hidden = YES;
            
            if (movieTable.hidden) {
                movieTable.hidden = NO;
                
            }
            else
                movieTable.hidden = YES;
        }        [movieSearch resignFirstResponder];
        
    }
    return NO;
    
    
    
    [movieTable scrollToRowAtIndexPath: // use the method
     [NSIndexPath indexPathForRow:1     // get 2nd row (nth row...)
                        inSection:0]    // in 1st section (...)
     // set position: you can use bottom, middle or top.
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES]; // YES or NO.
    
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
    stillTable.hidden=YES;
    [activityIndicator2 stopAnimating];
    activityIndicator2.alpha=  0.0;
}

-(void)getdata
{
    
    
    NSLog(@"GetData Called *****");
	GlobalClass *obj=[GlobalClass getInstance];
	NSLog(@"ddata=%@",obj.rel_trailers);
  	int i=0;
	for (NSDictionary *actoAgent in obj.rel_trailers)
	{
		data1[i]= [actoAgent objectForKey:@"trail_video"];
		NSLog(@"trail_video=%@",data1[i]);
		
		data2[i]= [actoAgent objectForKey:@"trail_img"];
		NSLog(@"trail_img=%@",data2[i]);
		
		
		data3[i]= [actoAgent objectForKey:@"trail_id"];
		NSLog(@"trail_id=%@",data3[i]);
		
		
		data4[i]= [actoAgent objectForKey:@"movie_id"];
		NSLog(@"movie_id=%@",data4[i]);
		
		data5[i]= [actoAgent objectForKey:@"trail_rating"];
		NSLog(@"trail_rating=%@",data5[i]);
		
		
		data6[i]= [actoAgent objectForKey:@"trail_type"];
		NSLog(@"trail_type=%@",data6[i]);
        
        data7[i]= [actoAgent objectForKey:@"trail_desc"];
		NSLog(@"trail_desc=%@",data7[i]);
        
        data8[i]= [actoAgent objectForKey:@"trail_title"];
		NSLog(@"trail_title=%@",data8[i]);
        
		data9[i]= [actoAgent objectForKey:@"movie_name"];
		NSLog(@"movie_name=%@",data9[i]);
        
        if (![movieNameArray containsObject:data9[i]])
        {
            
            [movieNameArray addObject:data9[i]];
        }
        
        data11[i]= [actoAgent objectForKey:@"status"];
		NSLog(@"status=%@",data11[i]);
        
        data110[i]= [actoAgent objectForKey:@"premium"];
		NSLog(@"premium=%@",data110[i]);
        
		i++;
        
	}
    
    NSLog(@"movieNameArray..i = %@",movieNameArray);
    
	TotalData1=i;
    
    int j=0;
    
    for (NSDictionary *actoAgent in obj.rel_Dwall)
        
    {
        
        data12[j]= [actoAgent objectForKey:@"wall_big_img"];
        NSLog(@"wall_big_img=%@",data12[j]);
        
        data13[j]= [actoAgent objectForKey:@"wall_big_img"];
        NSLog(@"wall_big_img=%@",data13[j]);
        
        
        NSString *timeZone =[actoAgent objectForKey:@"wall_id"];
        NSArray *newArray=[timeZone componentsSeparatedByString:@"_"];
        fbFeedId[j] = [actoAgent objectForKey:@"wall_id"];
        NSLog(@"data4  id ==== =====   %@",fbFeedId[j]);
        
        
        data14[j]= [actoAgent objectForKey:@"wall_tiny"];
        NSLog(@"wall_tiny=%@",data14[j]);
        
        
        
        data15[j]= [actoAgent objectForKey:@"status"];
        
        NSLog(@"status=%@",data15[j]);
        
        data16[j]= [actoAgent objectForKey:@"premium"];
        NSLog(@"premium=%@",data16[j]);
        
        data17[j]= [actoAgent objectForKey:@"movie_name"];
		NSLog(@"movie_name=%@",data17[j]);
        
        data18[j]= [actoAgent objectForKey:@"wall_name"];
		NSLog(@"movie_name=%@",data18[j]);
        
        if (![movieNameArrayForStills containsObject:data17[j]])
        {
            
            [movieNameArrayForStills addObject:data17[j]];
        }
        

        j++;
        
    }
    
    
    TotalData = j;
    NSLog(@"movieNameArrayForStill..i = %@",movieNameArrayForStills);
    [movieNameArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [movieNameArrayForStills sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    
}
-(void)ScrollLazyLoading1
{
    if(TotalData1-loaderCount<5)
    {
        
        finalCount=TotalData1-loaderCount;
    }
    
	for (int i =loaderCount; i<loaderCount+finalCount; i++)
    {
        if([movieSearch.text isEqualToString:@"All"])
        {
            bgView[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 320, 267)];
            bgView[i].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-2.jpg"]];
            [VideoScroller addSubview:bgView[i]];
            
            MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 300, 30)];
            MusicLabel[i].backgroundColor =[UIColor clearColor];
            MusicLabel[i].textColor= [self colorWithHexString:@"e42477"];
            MusicLabel[i].text=data8[i];
            MusicLabel[i].font = [UIFont boldSystemFontOfSize:21.0f];
            [socializeBg[i] addSubview:MusicLabel[i]];
            
            MovieTextViewvideo[i] = [[UITextView alloc] initWithFrame:CGRectMake(5,220, 300, 43)];
            MovieTextViewvideo[i].backgroundColor =[UIColor clearColor];
            MovieTextViewvideo[i].textColor= [UIColor darkGrayColor];
            MovieTextViewvideo[i].text=data7[i];
            MovieTextViewvideo[i].font = [UIFont boldSystemFontOfSize:18.0f];
            [bgView[i] addSubview:MovieTextViewvideo[i]];
            
            
            
            webwall[i] = [[UIWebView alloc] initWithFrame:CGRectMake(5, 44, 315,176)];
            webwall[i].userInteractionEnabled=YES;
            webwall[i].delegate =self;
            webwall[i].tag=i;
            NSURL *url = [NSURL URLWithString:data2[i]];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [webwall[i] loadRequest:requestObj];
            webwall[i].scrollView.bounces = NO;
            webwall[i].scrollView.scrollEnabled = NO;
            webwall[i].backgroundColor= [UIColor clearColor];
            webwall[i].opaque = NO;
            webwall[i].scalesPageToFit = YES;
            [bgView[i] addSubview:webwall[i]];
            
            
            ImagePatch[i] = [[UIImageView alloc] initWithFrame:CGRectMake(2,220, 315,45)];
            ImagePatch[i].userInteractionEnabled=YES;
            ImagePatch[i].backgroundColor=[UIColor clearColor];
            ImagePatch[i].alpha=0.7;
            [bgView[i] addSubview:ImagePatch[i]];
            ImagePatch[i].tag= i;
            
            UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(117, 54, 70, 70)];
            playIcon.image = [UIImage imageNamed:@"video-play-btnRel.png"];
            [webwall[i] addSubview:playIcon];
            
            UITapGestureRecognizer *tapped123 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
            tapped123.numberOfTapsRequired = 1;
            tapped123.delegate=self;
            webwall[i].tag = i;
            [webwall[i] addGestureRecognizer:tapped123];
            
            
            
            
            
            if ([data11[i] isEqualToString:@"1"])
            {
                if (!lockImage[i]) {
                    
                    lockImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 315,176)];
                    lockImage[i].image = [UIImage imageNamed:@"premi_video.png"];
                    [webwall[i] addSubview:lockImage[i]];
                }
            }
            else
            {
                lockImage[i].image=[UIImage imageNamed:@""];
            }
            m+=275;
            
        }
        
	}
    
    if(m==0)
    {
        UIAlertView *noMovieAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Oops! No movies matching your search" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        noMovieAlert.tag = 5;
        [noMovieAlert show];
    }
    
    
	VideoScroller.contentSize = CGSizeMake(299,m);
    [movieTable reloadData];
    
    [self.view addSubview:movieTable];
    
    [activityIndicator stopAnimating];
    
    activityIndicator.hidden = YES;
    
    
}

-(void)DisplayVideos
{
    checksection=0;
    [[VideoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [VideoScroller removeFromSuperview];
    VideoScroller=nil;
    
   	[self getdata];
    [self getsharetext];
    
	VideoScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(5,110,320,396)];
	VideoScroller.userInteractionEnabled	=YES;
    VideoScroller.backgroundColor = [UIColor clearColor];
	VideoScroller.showsVerticalScrollIndicator = YES;
    VideoScroller.delegate = self;
	VideoScroller.pagingEnabled = NO;
    VideoScroller.tag=2;
	[self.view addSubview:VideoScroller];
	
    finalCount=5;
    m=0;
	NSLog(@"hi");
    loaderCount=0;
    if([movieSearch.text isEqualToString:@"All"])
    {
        for (int i =0; i<5; i++)
        {
            bgView[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 320, 267)];
            bgView[i].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-2.jpg"]];
            [VideoScroller addSubview:bgView[i]];
            
            MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 300, 30)];
            MusicLabel[i].backgroundColor =[UIColor clearColor];
            MusicLabel[i].textColor= [self colorWithHexString:@"e42477"];
            MusicLabel[i].text=data8[i];
            MusicLabel[i].font = [UIFont boldSystemFontOfSize:21.0f];
            [socializeBg[i] addSubview:MusicLabel[i]];
            
            MovieTextViewvideo[i] = [[UITextView alloc] initWithFrame:CGRectMake(5,220, 300, 43)];
            MovieTextViewvideo[i].backgroundColor =[UIColor clearColor];
            MovieTextViewvideo[i].textColor= [UIColor darkGrayColor];
            MovieTextViewvideo[i].text=data7[i];
            MovieTextViewvideo[i].font = [UIFont boldSystemFontOfSize:18.0f];
            [bgView[i] addSubview:MovieTextViewvideo[i]];
            
            
            
            webwall[i] = [[UIWebView alloc] initWithFrame:CGRectMake(5, 44, 315,176)];
            webwall[i].userInteractionEnabled=YES;
            webwall[i].delegate =self;
            webwall[i].tag=i;
            NSURL *url = [NSURL URLWithString:data2[i]];
            NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
            [webwall[i] loadRequest:requestObj];
            webwall[i].scrollView.bounces = NO;
            webwall[i].scrollView.scrollEnabled = NO;
            webwall[i].backgroundColor= [UIColor clearColor];
            webwall[i].opaque = NO;
            webwall[i].scalesPageToFit = YES;
            [bgView[i] addSubview:webwall[i]];
            
            
            ImagePatch[i] = [[UIImageView alloc] initWithFrame:CGRectMake(2,220, 315,45)];
            ImagePatch[i].userInteractionEnabled=YES;
            ImagePatch[i].backgroundColor=[UIColor clearColor];
            ImagePatch[i].alpha=0.7;
            [bgView[i] addSubview:ImagePatch[i]];
            ImagePatch[i].tag= i;
            
            UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(117, 54, 70, 70)];
            playIcon.image = [UIImage imageNamed:@"video-play-btnRel.png"];
            [webwall[i] addSubview:playIcon];
            
            UITapGestureRecognizer *tapped123 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
            tapped123.numberOfTapsRequired = 1;
            tapped123.delegate=self;
            webwall[i].tag = i;
            [webwall[i] addGestureRecognizer:tapped123];
            
            
            
            
            
            if ([data11[i] isEqualToString:@"1"])
            {
                if (!lockImage[i]) {
                    
                    lockImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 315,176)];
                    lockImage[i].image = [UIImage imageNamed:@"premi_video.png"];
                    [webwall[i] addSubview:lockImage[i]];
                }
            }
            else
            {
                lockImage[i].image=[UIImage imageNamed:@""];
            }
            m+=275;
            
        }
        VideoScroller.contentSize = CGSizeMake(299,5*275);
        loaderCount=loaderCount+5;
        
    }
    
    
    else
    {
        
        for (int i =0; i<TotalData1; i++) {
            if([data9[i] isEqualToString:movieSearch.text])
            {
                bgView[i] = [[UIView alloc]initWithFrame:CGRectMake(0, m, 320, 267)];
                bgView[i].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-2.jpg"]];
                [VideoScroller addSubview:bgView[i]];
                
                MusicLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 300, 30)];
                MusicLabel[i].backgroundColor =[UIColor clearColor];
                MusicLabel[i].textColor= [self colorWithHexString:@"e42477"];
                MusicLabel[i].text=data8[i];
                MusicLabel[i].font = [UIFont boldSystemFontOfSize:21.0f];
                [socializeBg[i] addSubview:MusicLabel[i]];
                
                MovieTextViewvideo[i] = [[UITextView alloc] initWithFrame:CGRectMake(5,220, 300, 43)];
                MovieTextViewvideo[i].backgroundColor =[UIColor clearColor];
                MovieTextViewvideo[i].textColor= [UIColor darkGrayColor];
                MovieTextViewvideo[i].text=data7[i];
                MovieTextViewvideo[i].font = [UIFont boldSystemFontOfSize:18.0f];
                [bgView[i] addSubview:MovieTextViewvideo[i]];
                webwall[i] = [[UIWebView alloc] initWithFrame:CGRectMake(5, 44, 315,176)];
                webwall[i].userInteractionEnabled=YES;
                webwall[i].delegate =self;
                webwall[i].tag=i;
                NSURL *url = [NSURL URLWithString:data2[i]];
                NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                [webwall[i] loadRequest:requestObj];
                webwall[i].scrollView.bounces = NO;
                webwall[i].scrollView.scrollEnabled = NO;
                webwall[i].backgroundColor= [UIColor clearColor];
                webwall[i].opaque = NO;
                webwall[i].scalesPageToFit = YES;
                [bgView[i] addSubview:webwall[i]];
                
                
                ImagePatch[i] = [[UIImageView alloc] initWithFrame:CGRectMake(2,220, 315,45)];
                ImagePatch[i].userInteractionEnabled=YES;
                ImagePatch[i].backgroundColor=[UIColor clearColor];
                ImagePatch[i].alpha=0.7;
                [bgView[i] addSubview:ImagePatch[i]];
                ImagePatch[i].tag= i;
                
                UIImageView *playIcon = [[UIImageView alloc]initWithFrame:CGRectMake(117, 54, 70, 70)];
                playIcon.image = [UIImage imageNamed:@"video-play-btnRel.png"];
                [webwall[i] addSubview:playIcon];
                
                UITapGestureRecognizer *tapped123 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigate:)];
                tapped123.numberOfTapsRequired = 1;
                
                tapped123.delegate=self;
                [webwall[i] addGestureRecognizer:tapped123];
                
                
                
                
                
                if ([data11[i] isEqualToString:@"1"])
                {
                    if (!lockImage[i]) {
                        
                        lockImage[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 315,176)];
                        lockImage[i].image = [UIImage imageNamed:@"premi_video.png"];
                        [webwall[i] addSubview:lockImage[i]];
                    }
                }
                else
                {
                    lockImage[i].image=[UIImage imageNamed:@""];
                }
                m+=275;
                
            }
            
        }
        VideoScroller.contentSize = CGSizeMake(299,m);
        loaderCount=TotalData1;
    }
    
    
    
    if(m==0)
    {
        UIAlertView *noMovieAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Oops! No movies matching your search" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        noMovieAlert.tag = 5;
        [noMovieAlert show];
    }
    
    
	
    [movieTable reloadData];
    
    [self.view addSubview:movieTable];
    
    [activityIndicator stopAnimating];
    
    activityIndicator.hidden = YES;
    
}

-(void)ScrollLazyLoading
{
    
    if(TotalData-loaderCount<5)
    {
        
        finalCount=TotalData-loaderCount;
    }
    
    
    
    
	for (int a =loaderCount; a<loaderCount+finalCount; a++)
    {
        for (int a =0; a<TotalData; a++)
            
        {
            NSLog(@"newtag=%d",newTag);
            if([data17[a]isEqualToString:movieSearch.text])
            {
                
                nX=160*(b%2);
                nY=226 * (b/2);
                
                bgViewStills[a] = [[UIView alloc]initWithFrame:CGRectMake(nX, nY, 150, 207)];
                bgViewStills[a].backgroundColor = [UIColor clearColor];
                [Scroller addSubview:bgViewStills[a]];
                
                
                if (view3[a] == nil)
                    
                {
                    
                    view3[a] = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 207.0f)];
                    
                    
                    view3[a].contentMode = UIViewContentModeScaleToFill;
                    
                }
                
                view3[a].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
                view3[a].userInteractionEnabled = YES;
                
                
                
                //cancel any previously loading images for this view
                
                [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view3[a]];
                
                
                
                //set image URL. AsyncImageView class will then dynamically load the image
                
                NSURL *url1 = [NSURL URLWithString:data13[a]];
                
                
                
                ((AsyncImageView *)view3[a]).imageURL =url1;
                
                [bgViewStills[a] addSubview:view3[a]];
                
                
                UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouched:)];
                
                webViewTapped.numberOfTapsRequired = 1;
                view3[a].tag = newTag;
                webViewTapped.delegate = self;
                
                [view3[a] addGestureRecognizer:webViewTapped];
                
                
                
                
                MovieLabelStills[a] = [[UILabel alloc] initWithFrame:CGRectMake(0,207-23, 150, 23)];
                MovieLabelStills[a].backgroundColor =[UIColor clearColor];
                MovieLabelStills[a].textColor= [UIColor whiteColor];
                MovieLabelStills[a].backgroundColor= [UIColor blackColor];
                MovieLabelStills[a].text=data17[a];
                MovieLabelStills[a].font = [UIFont boldSystemFontOfSize:18.0f];
                [bgViewStills[a] addSubview:MovieLabelStills[a]];
                
                
                grayImage[a] = [[UIImageView alloc]initWithFrame:CGRectMake(150-39, 10, 39, 38)];
                grayImage[a].image = [UIImage imageNamed:@"magny.png"];
                [bgViewStills[a] addSubview:grayImage[a]];
                
                
                grayImage1[a] = [[UIImageView alloc]initWithFrame:CGRectMake(8, 210+nY, 297, 16)];
                grayImage1[a].image = [UIImage imageNamed:@"divder.png"];
                [Scroller addSubview:grayImage1[a]];
                
                
                
                if ([data15[a] isEqualToString:@"1"])
                {
                    if (!lockImageStills[a]) {

                    lockImageStills[a] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150,207)];
                    lockImageStills[a].image = [UIImage imageNamed:@"premi_video.png"];
                    [view3[a] addSubview:lockImageStills[a]];
                    }
                }
                else
                {
                    lockImageStills[a].image=[UIImage imageNamed:@""];
                }

                nX = nX+160;
                nY = nY+226;
                
                b++;
                newTag++;
                //Scroller.contentSize = CGSizeMake(320, ((b*226)/2)+113);
                
            }
            
            if([movieSearch.text isEqualToString:@"All"])
            {
                nX=160*(a%2);
                nY=226 * (a/2);
                
                bgViewStills[a] = [[UIView alloc]initWithFrame:CGRectMake(nX, nY, 150, 207)];
                bgViewStills[a].backgroundColor = [UIColor clearColor];
                [Scroller addSubview:bgViewStills[a]];
                
                
                if (view3[a] == nil)
                    
                {
                    
                    view3[a] = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 207.0f)];
                    
                    
                    
                    view3[a].contentMode = UIViewContentModeScaleToFill;
                    
                }
                
                view3[a].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
                view3[a].userInteractionEnabled = YES;
                
                
                
                //cancel any previously loading images for this view
                
                [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view3[a]];
                
                
                
                //set image URL. AsyncImageView class will then dynamically load the image
                
                NSURL *url1 = [NSURL URLWithString:data13[a]];
                
                
                
                ((AsyncImageView *)view3[a]).imageURL =url1;
                
                [bgViewStills[a] addSubview:view3[a]];
                
                
                UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouched:)];
                
                webViewTapped.numberOfTapsRequired = 1;
                view3[a].tag = a;
                webViewTapped.delegate = self;
                
                [view3[a] addGestureRecognizer:webViewTapped];
                
                
                
                MovieLabelStills[a] = [[UILabel alloc] initWithFrame:CGRectMake(0,207-23, 150, 23)];
                MovieLabelStills[a].backgroundColor =[UIColor clearColor];
                MovieLabelStills[a].textColor= [UIColor whiteColor];
                MovieLabelStills[a].backgroundColor= [UIColor blackColor];
                MovieLabelStills[a].text=data17[a];
                MovieLabelStills[a].font = [UIFont boldSystemFontOfSize:18.0f];
                [bgViewStills[a] addSubview:MovieLabelStills[a]];
                
                
                grayImage[a] = [[UIImageView alloc]initWithFrame:CGRectMake(150-39, 10, 39, 38)];
                grayImage[a].image = [UIImage imageNamed:@"magny.png"];
                [bgViewStills[a] addSubview:grayImage[a]];
                
                grayImage1[a] = [[UIImageView alloc]initWithFrame:CGRectMake(8, 210+nY, 297, 16)];
                grayImage1[a].image = [UIImage imageNamed:@"divder.png"];
                [Scroller addSubview:grayImage1[a]];
                
                
                
                if ([data15[a] isEqualToString:@"1"])
                {
                    if (!lockImageStills[a]) {

                    lockImageStills[a] = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 150,207)];
                    lockImageStills[a].image = [UIImage imageNamed:@"premi_video.png"];
                    [view3[a] addSubview:lockImageStills[a]];
                    }
                }
                else
                {
                    lockImageStills[a].image=[UIImage imageNamed:@""];
                }

                
                
                nX = nX+160;
                nY = nY+226;
                
                
                //      m=m+207;
              //  Scroller.contentSize = CGSizeMake(320, ((TotalData*226)/2)+113);
                
                
            }
            
        }
        
        
        
        
        [stillTable reloadData];
        
        [self.view addSubview:stillTable];
        [activityIndicator stopAnimating];
        
        activityIndicator.hidden = YES;
        
        if(nY==0 )
        {
            UIAlertView *noMovieAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Oops! No movies matching your search" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [noMovieAlert show];
        }

        
    }
}

-(void)DisplayFilmStills
{
    checksection=1;
    
    [[Scroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [Scroller removeFromSuperview];
    Scroller=nil;
    
        
    
    [self getdata];
    [self getsharetext];
    
   
    
    Scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(5,110,320,396)];
	Scroller.userInteractionEnabled	=YES;
    Scroller.backgroundColor = [UIColor clearColor];
	Scroller.showsVerticalScrollIndicator = YES;
    Scroller.delegate = self;
	Scroller.pagingEnabled = NO;
	[self.view addSubview:Scroller];
	
	//int m=0;
    finalCount=5;
    b=0;
    newTag=0;
    nX = 0;
    nY = 0;
    loaderCount=0;
    
    if([movieSearch.text isEqualToString:@"All"])
    {
        for (int a =0; a<5; a++)
        {
            nX=160*(a%2);
            nY=226 * (a/2);
            
            bgViewStills[a] = [[UIView alloc]initWithFrame:CGRectMake(nX, nY, 150, 207)];
            bgViewStills[a].backgroundColor = [UIColor clearColor];
            [Scroller addSubview:bgViewStills[a]];
            
            
            if (view3[a] == nil)
                
            {
                
                view3[a] = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 207.0f)];
                
                
                
                view3[a].contentMode = UIViewContentModeScaleToFill;
                
            }
            
            view3[a].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
            view3[a].userInteractionEnabled = YES;
            
            
            
            //cancel any previously loading images for this view
            
            [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view3[a]];
            
            
            
            //set image URL. AsyncImageView class will then dynamically load the image
            
            NSURL *url1 = [NSURL URLWithString:data13[a]];
            
            
            
            ((AsyncImageView *)view3[a]).imageURL =url1;
            
            [bgViewStills[a] addSubview:view3[a]];
            
            
            UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouched:)];
            
            webViewTapped.numberOfTapsRequired = 1;
            view3[a].tag = a;
            webViewTapped.delegate = self;
            
            [view3[a] addGestureRecognizer:webViewTapped];
            
            
            
            MovieLabelStills[a] = [[UILabel alloc] initWithFrame:CGRectMake(0,207-23, 150, 23)];
            MovieLabelStills[a].backgroundColor =[UIColor clearColor];
            MovieLabelStills[a].textColor= [UIColor whiteColor];
            MovieLabelStills[a].backgroundColor= [UIColor blackColor];
            MovieLabelStills[a].text=data17[a];
            MovieLabelStills[a].font = [UIFont boldSystemFontOfSize:18.0f];
            [bgViewStills[a] addSubview:MovieLabelStills[a]];
            
            
            grayImage[a] = [[UIImageView alloc]initWithFrame:CGRectMake(150-39, 10, 39, 38)];
            grayImage[a].image = [UIImage imageNamed:@"magny.png"];
            [bgViewStills[a] addSubview:grayImage[a]];
            
            grayImage1[a] = [[UIImageView alloc]initWithFrame:CGRectMake(8, 210+nY, 297, 16)];
            grayImage1[a].image = [UIImage imageNamed:@"divder.png"];
            [Scroller addSubview:grayImage1[a]];
            
            
            
            if ([data15[a] isEqualToString:@"1"])
            {
                if (!lockImageStills[a]) {

                lockImageStills[a] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150,207)];
                lockImageStills[a].image = [UIImage imageNamed:@"premi_video.png"];
                [view3[a] addSubview:lockImageStills[a]];
                }
            }
            else
            {
                lockImageStills[a].image=[UIImage imageNamed:@""];
            }

           //
            
            nX = nX+160;
            nY = nY+226;
            Scroller.contentSize = CGSizeMake(320, ((5*226)/2)+226);
            
            
        }
        loaderCount=loaderCount+5;
        }

    else
    {
	for (int a =0; a<TotalData; a++)
        
    {
        NSLog(@"newtag=%d",newTag);
        if([data17[a]isEqualToString:movieSearch.text])
        {
           
            nX=160*(b%2);
            nY=226 * (b/2);
            
            bgViewStills[a] = [[UIView alloc]initWithFrame:CGRectMake(nX, nY, 150, 207)];
            bgViewStills[a].backgroundColor = [UIColor clearColor];
            [Scroller addSubview:bgViewStills[a]];
            
            
            if (view3[a] == nil)
                
            {
                
                view3[a] = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 207.0f)];
                
                
                view3[a].contentMode = UIViewContentModeScaleToFill;
                
            }
            
            view3[a].backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
            view3[a].userInteractionEnabled = YES;
            
            
            
            //cancel any previously loading images for this view
            
            [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:view3[a]];
            
            
            
            //set image URL. AsyncImageView class will then dynamically load the image
            
            NSURL *url1 = [NSURL URLWithString:data13[a]];
            
            
            
            ((AsyncImageView *)view3[a]).imageURL =url1;
            
            [bgViewStills[a] addSubview:view3[a]];
            
            
                    UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTouched:)];
           
                  webViewTapped.numberOfTapsRequired = 1;
                  view3[a].tag = newTag;
                    webViewTapped.delegate = self;
            
                   [view3[a] addGestureRecognizer:webViewTapped];
            
            

            
            MovieLabelStills[a] = [[UILabel alloc] initWithFrame:CGRectMake(0,207-23, 150, 23)];
            MovieLabelStills[a].backgroundColor =[UIColor clearColor];
            MovieLabelStills[a].textColor= [UIColor whiteColor];
            MovieLabelStills[a].backgroundColor= [UIColor blackColor];
            MovieLabelStills[a].text=data17[a];
            MovieLabelStills[a].font = [UIFont boldSystemFontOfSize:18.0f];
            [bgViewStills[a] addSubview:MovieLabelStills[a]];
            
            
            grayImage[a] = [[UIImageView alloc]initWithFrame:CGRectMake(150-39, 10, 39, 38)];
            grayImage[a].image = [UIImage imageNamed:@"magny.png"];
            [bgViewStills[a] addSubview:grayImage[a]];
            
            
            grayImage1[a] = [[UIImageView alloc]initWithFrame:CGRectMake(8, 210+nY, 297, 16)];
            grayImage1[a].image = [UIImage imageNamed:@"divder.png"];
            [Scroller addSubview:grayImage1[a]];

            
            
            if ([data15[a] isEqualToString:@"1"])
            {
                if (!lockImageStills[a]) {

                lockImageStills[a] = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150,207)];
                lockImageStills[a].image = [UIImage imageNamed:@"premi_video.png"];
                [view3[a] addSubview:lockImageStills[a]];
                }
            }
            else
            {
                lockImageStills[a].image=[UIImage imageNamed:@""];
            }

            nX = nX+160;
            nY = nY+226;
            
                  b++;       
            newTag++;
            Scroller.contentSize = CGSizeMake(320, ((b*226)/2)+226);
            loaderCount=TotalData;

        }
        }

       
    }
    

    
    
    [stillTable reloadData];
    
    [self.view addSubview:stillTable];
    [activityIndicator stopAnimating];
    
    activityIndicator.hidden = YES;
    
    if(nY==0 )
    {
        UIAlertView *noMovieAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Oops! No movies matching your search" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [noMovieAlert show];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    if (scrollView == Scroller) {
        
          [activityIndicator2 stopAnimating];
         activityIndicator2.alpha = 0.0;
        if (TotalData -loaderCount >0) {
            NSLog(@"lazy loading called");
            
            currentScrollPosition= Scroller.contentOffset.y;
            if ( (currentScrollPosition = Scroller.contentSize.height)) {
                Scroller.contentSize = CGSizeMake(320, ((loaderCount*226)/2)+226);
                
                [self ScrollLazyLoading];
                loaderCount=loaderCount+finalCount;
            }
            
        }
    }
    
    if (scrollView==VideoScroller) {
        
          [activityIndicator2 stopAnimating];
         activityIndicator2.alpha = 0.0;
        if (TotalData1 -loaderCount >0) {
            NSLog(@"lazy loading called");
            
            currentScrollPosition= VideoScroller.contentOffset.y;
            if ( (currentScrollPosition = VideoScroller.contentSize.height)) {
                // VideoScroller.contentSize = CGSizeMake(320, loaderCount*275);
                
                [self ScrollLazyLoading1];
                loaderCount=loaderCount+finalCount;
            }
            
        }
    }
    
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView

{
        activityIndicator2.alpha = 1.0;
        [activityIndicator2 startAnimating];
    
    
    
}


- (void)imageTouched:(UITapGestureRecognizer *)sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    NSLog(@"gesture.view = %d",gesture.view.tag);
    
    if ([data15[gesture.view.tag] isEqualToString:@"1"]) {
        _IAPVIEW.alpha=1.0;
        [self.view addSubview:_IAPVIEW];
        
        
        SKProduct *product = _products[0];
        
        [_priceFormatter setLocale:product.priceLocale];
        
        
        _pricelabel.text = [NSString stringWithFormat:@"fee of . %@ \n to see become a premium member!",[_priceFormatter stringFromNumber:product.price]];
        NSLog(@"_products[buyB=%@", _pricelabel.text);
        
        
    }
    else
    {

    R_OpenStills_5 *openStills = [[R_OpenStills_5 alloc]initWithNibName:@"R_OpenStills_5" bundle:nil];
    openStills.stillIndex = gesture.view.tag;
    openStills.movieName = movieSearch.text;
    openStills.modalTransitionStyle= UIModalTransitionStyleCrossDissolve;
    [self presentViewController:openStills animated:YES completion:nil];
    }
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
    
    
    
    
    if(Scroller.alpha == 1.0)
    {
        UIGraphicsBeginImageContext(view3[imgIndex].frame.size);
        
        [view3[imgIndex].layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
        
        NSData *imageData = UIImageJPEGRepresentation(image,1);
        
        [picker addAttachmentData:imageData mimeType:@"image/jpg" fileName:data12[imgIndex]];
    }
    else
    {
        
    }
    
    
    
    
    
    // Set up recipients
    
    NSArray *toRecipients = [NSArray arrayWithObject:@""];
    
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", nil];
    
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
    
    NSString	*str= [NSString stringWithFormat:@"%@  \n\n You can also download HD image from %@",mailsharetext,data2[imgIndex]];
    
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

-(void)getsharetext

{
    GlobalClass *obj=[GlobalClass getInstance];
    
    if(check== 1)
    {
        
        
        
        NSLog(@"images=%@",obj.rel_wallpapers);
        
        
        
        fbsharetext = [obj.rel_wallpapers objectForKey:@"fb_share"];
        
        NSLog(@"fb_share=%@",fbsharetext);
        
        
        
        twtsharetext = [obj.rel_wallpapers objectForKey:@"twitter_share"];
        
        NSLog(@"twitter_share=%@",twtsharetext);
        
        
        
        
        
        mailsharesub = [obj.rel_wallpapers objectForKey:@"email_subject"];
        
        NSLog(@"email_subject=%@",mailsharesub);
        
        
        
        
        
        mailsharetext = [obj.rel_wallpapers objectForKey:@"email_share"];
        
        NSLog(@"email_share=%@",mailsharetext);
        
    }
    if(check ==1)
    {
        
        fbsharetext = [obj.rel_videosharetext objectForKey:@"fb_share"];
        NSLog(@"fb_share=%@",fbsharetext);
        
        twtsharetext = [obj.rel_videosharetext objectForKey:@"twitter_share"];
        NSLog(@"twitter_share=%@",twtsharetext);
        
        
        mailsharesub = [obj.rel_videosharetext objectForKey:@"email_subject"];
        NSLog(@"email_subject=%@",mailsharesub);
        
        
        mailsharetext = [obj.rel_videosharetext objectForKey:@"email_share"];
        NSLog(@"email_share=%@",mailsharetext);
        
        
    }
    
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
    if (check==1 || check==2)
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
- (IBAction)fbshare:(UIButton *)sender

{
    NSUInteger check1 = [[NSUserDefaults standardUserDefaults] integerForKey:@"fbSwitch"];
    if (check==1 || check==2)
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
            
            //        sharepost = [[FBFeedPost alloc] initWithLinkPath:shareText caption:fbsharetext];
            //
            //        [self sharefeedonfb1:sharepost];
            
            
            
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
        
        
        
        //        NSString	 *STR= [NSString stringWithFormat:@"%@ - Use official Reliance Entertainment App to see all Besharam Wallpapers",data1[sendtitle]];
        
        
        
        //   [fbController addImage:[UIImage imageNamed:@"114x114.png"]];
        
        [fbController setInitialText:fbsharetext];
        
        [fbController addURL:[NSURL URLWithString:stringis]];
        
        [fbController setCompletionHandler:completionHandler];
        
        [self presentViewController:fbController animated:YES completion:nil];
        
    }
    
    
    
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
        loginViewController.entity_name=data8[gesture.view.tag];
        loginViewController.entity_Key=data3[gesture.view.tag];
        //        loginViewController.songTitle = data4[gesture.view.tag];
        //        loginViewController.time = data5[gesture.view.tag];
        //        loginViewController.singer = data6[gesture.view.tag];
        //        loginViewController.lyrics = data7[gesture.view.tag];
        //        loginViewController.musicDirector = data3[gesture.view.tag];
        loginViewController.premiumType = data110[gesture.view.tag];
        //       loginViewController.musicLabel = data9[gesture.view.tag];
        [[GAI sharedInstance].defaultTracker sendEventWithCategory:@"Video Clicked"
                                                        withAction:data1[gesture.view.tag]
                                                         withLabel:@"Video"
                                                         withValue:nil];
       [self.navigationController pushViewController:loginViewController animated:NO];
        //[self presentViewController:loginViewController animated:YES completion:nil];
    }
	
	
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"yes");
	for (int i =0; i<TotalData1; i++) {
		
		
		if (webView.tag==i) {
			
			
			ActIndImage1[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,173)];
			//  ActIndImage1[i].center = CGPointMake(320/2, 460/2);
			ActIndImage1[i].image = [UIImage imageNamed:@"color_pacth_400x400.png"];
			ActIndImage1[i].opaque=0.5;
			[webwall[i] addSubview:ActIndImage1[i]];
			
			activityIndicator1[i] = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
			activityIndicator1[i].center=CGPointMake(320/2, 173/2);
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
    //    CustomAlertView *alert = [[CustomAlertView alloc]
    //							  initWithTitle:@"Info"
    //							  message:alertsStr
    //							  delegate:self
    //							  cancelButtonTitle:nil
    //							  otherButtonTitles:@"Done", nil];
    //
    //    [alert show];
    //    [alert release];
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
	
	for (int i =0; i<TotalData1; i++) {
		
		if (webView.tag == i) {
			[self unloadAct:i];
			
		}
	}
	
	
	
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	for (int i =0; i<TotalData1; i++) {
		if (webView.tag == i) {
			[self unloadAct:i];
			
		}
	}
}

- (void)viewDidUnload
{
    [self setScroller:nil];
	[self setLOGINVIEW:nil];
    
    [super viewDidUnload];
}

- (IBAction)trailers:(id)sender {
    check=0;
    [[VideoScroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [VideoScroller removeFromSuperview];
    VideoScroller=nil;
    
    [activityIndicator startAnimating];
    
    for(int a=0;a<TotalData1;a++)
        
    {
        actionBar[a] = nil;
    }
    
    [self performSelector:@selector(DisplayVideos) withObject:nil afterDelay:0.0];
    
    [_trailersButton setBackgroundImage:[UIImage imageNamed:@"trailers_btn_h.png"] forState:UIControlStateNormal];
    [_filmStillButton setBackgroundImage:[UIImage imageNamed:@"stills_btn_h.png"] forState:UIControlStateNormal];
    
    movieTable.hidden =YES;
    stillTable.hidden = YES;
    Scroller.alpha = 0.0;
    VideoScroller.alpha = 1.0;
    //  [movieTable reloadData];
    
}

- (IBAction)filmStills:(id)sender {
    
    check=1;

    [[Scroller subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [Scroller removeFromSuperview];
    Scroller=nil;
    
    [activityIndicator startAnimating];
    for(int a=0;a<TotalData;a++)
        
    {
        actionBarStills[a] = nil;
    }
    Scroller.alpha = 1.0;
    VideoScroller.alpha = 0.0;
    movieTable.hidden =YES;
    stillTable.hidden = YES;
    [self performSelector:@selector(DisplayFilmStills) withObject:nil afterDelay:0.0];
    
    [_trailersButton setBackgroundImage:[UIImage imageNamed:@"trailers_btn.png"] forState:UIControlStateNormal];
    [_filmStillButton setBackgroundImage:[UIImage imageNamed:@"stills_btn.png"] forState:UIControlStateNormal];
    // [movieTable reloadData];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    movieTable.hidden=YES;
}

@end
