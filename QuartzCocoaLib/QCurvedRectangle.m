//
//  QCurvedRectangle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QCurvedRectangle.h"


@implementation QCurvedRectangle

@synthesize radius;

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
	self.radius = 5;
	return self;
}


-(id)initWithRect:(CGRect) rect
{
	self = [super initWithRect:rect];
	self.radius = 5;
	return self;
}

-(id)initX:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h RADIUS:(float)r
{
	self = [super initX:xcoord Y:ycoord	WIDTH:w HEIGHT:h];
	self.radius = r;
	return self;
}


-(id)initWithRect:(CGRect) rect RADIUS:(float)r
{
	self = [super initWithRect:rect];
	self.radius = r;
	return self;
}


-(void)update:(QContext*) context
{
	CGRect rect = CGRectMake(self.x, self.y, self.width, self.height);
	CGFloat minX = CGRectGetMinX(rect);
	CGFloat minY = CGRectGetMinY(rect); 
	CGFloat maxX = CGRectGetMaxX(rect); 
	CGFloat maxY = CGRectGetMaxY(rect);
	
	CGContextBeginPath(context.context);
	CGContextMoveToPoint(context.context, (minX + maxX) / 2.0, minY);
	CGContextAddArcToPoint(context.context, minX, minY, minX, maxY, self.radius);
	CGContextAddArcToPoint(context.context, minX, maxY, maxX, maxY, self.radius);
	CGContextAddArcToPoint(context.context, maxX, maxY, maxX, minY, self.radius);
	CGContextAddArcToPoint(context.context, maxX, minY, minX, minY, self.radius);
	CGContextClosePath(context.context);
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.radius = [aDecoder decodeFloatForKey:@"QCURVEDRECTANGLE_radius"];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeFloat:self.radius forKey:@"QCURVEDRECTANGLE_radius"];
}

@end
