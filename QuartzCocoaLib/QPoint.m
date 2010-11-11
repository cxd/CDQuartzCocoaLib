//
//  QPoint.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QPoint.h"


@implementation QPoint

@synthesize x;
@synthesize y;

-(id)init
{
	self = [super init];
	self.x = 0.0;
	self.y = 0.0;
	return self;
}

-(id)initX:(float)x1 Y:(float)y1
{
	self = [super init];
	self.x = x1;
	self.y = y1;
	return self;
}

-(QPoint *)midPoint:(QPoint *)other
{
	QPoint *mid = [[QPoint alloc] initX: (self.x + other.x)/2.0 
										 Y: (self.y + other.y)/2.0];
	return mid;
}

-(float)distanceTo:(QPoint *)other
{
	return sqrt(pow((other.x - self.x),2) + pow((other.y - self.y),2));
}

-(float)horizontalDistanceTo:(QPoint *)other
{
	return other.x - self.x;
}

-(float)verticalDistanceTo:(QPoint *)other
{
	return other.y - self.y;
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self.x = [aDecoder decodeFloatForKey:@"x"];
	self.y = [aDecoder decodeFloatForKey:@"y"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeFloat:self.x forKey:@"x"];
	[aCoder encodeFloat:self.y forKey:@"y"];
}

@end
