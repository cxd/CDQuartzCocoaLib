//
//  QFilledCircle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QFilledCircle.h"

@implementation QFilledCircle


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
	self = [super initX:cx Y:cy Radius:rad];
	return self;
}

-(id)initWithCentre:(QPoint *)cp Radius:(float)rad
{
	self = [super initWithCentre:cp Radius:rad];
	return self;
}

-(void)dealloc
{
	[super dealloc];
}

-(void)update:(QContext *)context
{
	[super update:context];
	CGContextFillPath(context.context);
}


#pragma mark Encoder.
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
}


@end
