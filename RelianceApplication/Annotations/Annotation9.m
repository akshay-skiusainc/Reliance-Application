//
//  Annotation9.m
//  iAgentProduct
//
//  Created by Ankush Gupta on 05/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Annotation9.h"

@implementation Annotation9

@synthesize title;
@synthesize subtitle;
@synthesize coordinate=_coordinate;


- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andID:(NSUInteger)pinID{
	self = [super init];
	if (self != nil) {
		_coordinate = coordinate;
		_pinID = pinID;
	}
	return self;
}

- (NSString *)title {
	return [NSString stringWithFormat:@"%@", title];
}

- (NSString *)subtitle {
	return [NSString stringWithFormat:@"%@", subtitle];
}
@end
