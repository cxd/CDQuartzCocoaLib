//
//  QCircle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 10/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QCircle.h"


@implementation QCircle


/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init
{
	self = [super init];
	return self;
}


-(id)initX:(float)cx Y:(float)cy Radius:(float)rad
{
	self = [super initX:cx 
					  Y:cy 
				 Radius:rad
			 StartAngle:0.0 
			   EndAngle:360.0
				  START:YES 
					END:YES];
	return self;
}

-(id)initWithCentre:(QPoint *)cp Radius:(float)rad
{
self = [super initWithCentre:cp
					  Radius:rad
				  StartAngle:0.0
					EndAngle:0.0
					   START:YES
						 END:YES];
	return self;
}

-(void)dealloc
{
	[super dealloc];	
}

-(void)update:(QContext *)context
{
	[super update:context];	
}

#pragma mark Encoder.
-(id)initWithCoder:(NSCoder *)aDecoder
{
	return [super initWithCoder:aDecoder];	
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];	
}


@end
