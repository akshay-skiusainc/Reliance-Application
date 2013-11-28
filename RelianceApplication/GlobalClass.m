//
//  GlobalClass.m
//  Dabaang2Application
//
//  Created by Javed Sunesra on 11/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GlobalClass.h"

@implementation GlobalClass
@synthesize str,onset,videolinks,Dwall,CNC,Bookmyshow,Feedback,coming,dev,Notifications,Contests,rateit,dirnote,checking,appcount,emo,BACK,chatdata,called,loggin,groups,category,DISMISSIT,directorsNote,news,contestData,contest_bg,contest_btn,contestHeader,BTS,Banner,detailCastnCrew,detailCrew,detailCast,appData,newsshare,fetchall,fbtoken,navchecking,moviedata;
@synthesize music,productionImage,wallpapers,behindscene_images,behindscene_video,videosharetext,twitter,facebook,Tshirt,mug,movie_poster,Merchandise,GROUPNAME,Mid_added,TransStatus,QtyOfProducts,IAPProduct1,iapreceived,bms_link,Leftcheck,trailers,awardCat,awardInfo,awardMovie,detailAwards,movieCategory,CHECK_LOADING,CHECK_FETCH,MOVIE_DATA,REL_DATA;

@synthesize xtraDictionary,moviesharetxt,CHECK_CATALOG;

@synthesize rel_appData,rel_awardCat,rel_awardInfo,rel_awardMovie,rel_Banner,rel_bms_link,rel_Bookmyshow,rel_BTS,rel_category,rel_CNC,rel_directorsNote,rel_Dwall,rel_fbtoken,rel_Feedback,rel_groups,rel_movieCategory,rel_moviedata,rel_music,rel_Notifications,rel_onset,rel_productionImage,rel_str,rel_trailers,rel_videolinks,rel_behindscene_images,rel_behindscene_video,rel_dirnote,rel_facebook,rel_IAPProduct1,rel_movie_poster,rel_moviesharetxt,rel_mug,rel_Tshirt,rel_twitter,rel_videosharetext,rel_wallpapers;
static GlobalClass *instance=nil;
static GlobalClass *instance2 =nil; 

+(GlobalClass *)getInstance    
{    
	@synchronized(self)    
	{    
		if(instance==nil)    
		{    
			
			instance= [GlobalClass new];    
		}    
	}    
	return instance;    
}    


+(GlobalClass *)onset    
{    
	@synchronized(self)    
	{    
		if(instance2==nil)    
		{    
			
			instance2= [GlobalClass new];    
		}    
	}    
	return instance2;    
}    



@end
