//
//  QFilledEllipse.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QFilledEllipse.h"


@implementation QFilledEllipse

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

-(void)update:(QContext*) context
{
	CGRect rect = CGRectMake(self.x, self.y, self.width, self.height);
	CGContextAddEllipseInRect(context.context, rect);
	CGContextFillPath(context.context);
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
