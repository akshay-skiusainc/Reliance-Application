//
//  RightViewController.m
//  RelianceApplication
//
//  Created by Akshay Jain on 9/19/13.
//  Copyright (c) 2013 Akshay. All rights reserved.
//

#import "RightViewController.h"
#import "R_Home_5.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 //
//    NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_bg_image"];
//    UIImage* app_bg_image = [UIImage imageWithData:imageData];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:app_bg_image];
//    
    
    _VIEW1.backgroundColor=[UIColor clearColor];
    
    
    _Scroller.contentSize = CGSizeMake(215, 698+10);

    // Do any additional setup after loading the view from its nib.
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getdata];

    GlobalClass *obj=[GlobalClass getInstance];
    

    
    if([obj.Leftcheck isEqualToString:@"1"])
    {
        
        _Scroller.contentSize = CGSizeMake(215, 400);
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg_548.jpg"]];

        _Scroller.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"right_nav_bg.jpg"]];
        _SONG_BTN.alpha=0.0;
        if (_logo == nil)
            
        {
            
            _logo = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 215, 98)];
            
            
            
            _logo.contentMode = UIViewContentModeScaleToFill;
            
        }
        
        //   _logo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
        _logo.userInteractionEnabled = YES;
        
        
        
        //cancel any previously loading images for this view
        
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_logo];
        
        
        
        //set image URL. AsyncImageView class will then dynamically load the image
        
        NSURL *url1 = [NSURL URLWithString:data1];
        
        
        
        ((AsyncImageView *)_logo).imageURL =url1;
        
        [_VIEW1 addSubview:_logo];
        
        
        UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toRelApp:)];
        
        webViewTapped.numberOfTapsRequired = 1;
        webViewTapped.delegate = self;
        [_logo addGestureRecognizer:webViewTapped];
        [_merchandise_btn setImage:[UIImage imageNamed:@"right_nav-2.jpg"] forState:UIControlStateNormal];
        [_chat_btn setImage:[UIImage imageNamed:@"right_nav-3.jpg"] forState:UIControlStateNormal];
        [_profile_btn setImage:[UIImage imageNamed:@"right_nav-4.jpg"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        
        
        _Scroller.backgroundColor = [UIColor clearColor];
        
        _Scroller.contentSize = CGSizeMake(215, 500);
        
        NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"app_bg_image"];
        UIImage* app_bg_image = [UIImage imageWithData:imageData];
        self.view.backgroundColor = [UIColor colorWithPatternImage:app_bg_image];
        _SONG_BTN.alpha=1.0;
        
        if (_logo == nil)
            
        {
            
            _logo = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 215, 98)];
            
            
            
            _logo.contentMode = UIViewContentModeScaleToFill;
            
        }
        
        //  _logo.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"color_pacth_400x400.png"]];
        _logo.userInteractionEnabled = YES;
        
        
        
        //cancel any previously loading images for this view
        
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:_logo];
        
        
        
        //set image URL. AsyncImageView class will then dynamically load the image
        
        //  NSURL *url1 = [NSURL URLWithString:data1];
        
        
        
        ((AsyncImageView *)_logo).image = [UIImage imageNamed:@"right_nav_reliance_btn.png"];
        
        [_VIEW1 addSubview:_logo];
        
        
        UITapGestureRecognizer *webViewTapped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toRelApp:)];
        
        webViewTapped.numberOfTapsRequired = 1;
        webViewTapped.delegate = self;
        [_logo addGestureRecognizer:webViewTapped];
        [_merchandise_btn setImage:[UIImage imageNamed:@"right_nav_merchandise_btn.png"] forState:UIControlStateNormal];
        [_chat_btn setImage:[UIImage imageNamed:@"right_nav_chat_btn.png"] forState:UIControlStateNormal];
        [_profile_btn setImage:[UIImage imageNamed:@"right_nav_myprofile_btn.png"] forState:UIControlStateNormal];
        
    }

}

-(IBAction)merchandise:(id)sender
{
    
    
    GlobalClass *obj=[GlobalClass getInstance];
    
    obj.coming = @"1";
    
    
    //    [obj.Mid_added removeAllObjects];
    //    [obj.QtyOfProducts removeAllObjects];
    //    obj.Mid_added =nil;
    //    obj.QtyOfProducts =nil;
    
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    Merchandise *controller = [[Merchandise alloc] init];
    //controller.title = selectedCountry;
    controller.TAG = @"LEFT";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [menuController setRootController:navController animated:YES];
    
    //
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Under construction" message:@"Check Back Soon" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //    [alert show];
    //
    
    
}

-(IBAction)chat:(id)sender
{
    GlobalClass *obj=[GlobalClass getInstance];
    
    obj.coming = @"1";
    
    
    [obj.Mid_added removeAllObjects];
    [obj.QtyOfProducts removeAllObjects];
    obj.Mid_added =nil;
    obj.QtyOfProducts =nil;
    
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    iphone5GroupViewController *controller = [[iphone5GroupViewController alloc] init];
    //controller.title = selectedCountry;
    controller.TAG = @"LEFT";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [menuController setRootController:navController animated:YES];
    
}

-(IBAction)songs:(id)sender
{
    
    GlobalClass *obj=[GlobalClass getInstance];
    
    obj.coming = @"1";
    
    
    [obj.Mid_added removeAllObjects];
    [obj.QtyOfProducts removeAllObjects];
    obj.Mid_added =nil;
    obj.QtyOfProducts =nil;
    
    
    DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    iPhoneStreamingPlayerViewController *controller = [[iPhoneStreamingPlayerViewController alloc] init];
    //controller.title = selectedCountry;
    controller.TAG = @"LEFT";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [menuController setRootController:navController animated:YES];
}
-(IBAction)settings:(id)sender
{
    GlobalClass *obj=[GlobalClass getInstance];
    
    obj.coming = @"1";
    
    [obj.Mid_added removeAllObjects];
    [obj.QtyOfProducts removeAllObjects];
    obj.Mid_added =nil;
    obj.QtyOfProducts =nil;
    
    
     
    
    if([obj.Leftcheck isEqualToString:@"1"])
    {
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        R_iPhone5Settings *controller = [[R_iPhone5Settings alloc] init];
        //controller.title = selectedCountry;
        controller.TAG = @"LEFT";
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [menuController setRootController:navController animated:YES];

              
        
    }
    else
    {
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        iphone5Settings *controller = [[iphone5Settings alloc] init];
        //controller.title = selectedCountry;
        controller.TAG = @"LEFT";
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [menuController setRootController:navController animated:YES];

        
        
    }
    

    
}

-(void)getdata
{
    GlobalClass *obj=[GlobalClass getInstance];
	NSLog(@"ddata=%@",obj.rel_RightNavMovieLogo);
    
	for (NSDictionary *actoAgent in obj.rel_RightNavMovieLogo)
	{
		data1= [actoAgent objectForKey:@"m_img_ios"];
		NSLog(@"m_img_ios=%@",data1);
        
    }
}


-(void)toRelApp:(UITapGestureRecognizer *)sender
{
    
    GlobalClass *obj=[GlobalClass getInstance];
    obj.fetchall = @"0";
    if([obj.Leftcheck isEqualToString:@"1"])
    {
        obj.Leftcheck = @"0";
        UIImage *image = [UIImage imageNamed:@"home_header_bg.jpg"];
        [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        obj.coming = @"1";
        
        [obj.Mid_added removeAllObjects];
        [obj.QtyOfProducts removeAllObjects];
        obj.Mid_added =nil;
        obj.QtyOfProducts =nil;
        
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        HomeController *controller = [[HomeController alloc] init];
        //controller.title = selectedCountry;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [menuController setRootController:navController animated:YES];
        
        
    }
    else
    {
        obj.Leftcheck=@"1";
        UIImage *image = [UIImage imageNamed:@"home_header_bg1.jpg"];
        [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        obj.coming = @"1";
        
        [obj.Mid_added removeAllObjects];
        [obj.QtyOfProducts removeAllObjects];
        obj.Mid_added =nil;
        obj.QtyOfProducts =nil;
        
        
        DDMenuController *menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
        R_Home_5 *controller = [[R_Home_5 alloc] init];
        //controller.title = selectedCountry;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        
        [menuController setRootController:navController animated:YES];
        
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
