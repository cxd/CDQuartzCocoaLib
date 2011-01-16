//
//  QStrokedCurvedRectangle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QStrokedCurvedRectangle.h"


@implementation QStrokedCurvedRectangle


/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init
{
	self = [super init];
	return self;
}

-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h
{
	self = [super initX:xcoord Y:ycoord	WIDTH:w HEIGHT:h];
	return self;
}


-(id)initWithRect:(CGRect) rect
{
	self = [super initWithRect:rect];
	return self;
}

-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h RADIUS:(float)r
{
	self = [super initX:xcoord Y:ycoord	WIDTH:w HEIGHT:h RADIUS:r];
	return self;
}


-(id)initWithRect:(CGRect) rect RADIUS:(float)r
{
	self = [super initWithRect:rect RADIUS:r];
	return self;
}


-(void)update:(QContext*) context
{
	[super update:context];
	CGContextStrokePath(context.context);
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
}

@end
