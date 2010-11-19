//
//  QRectangle.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QRectangle.h"


@implementation QRectangle


@synthesize x;
@synthesize y;
@synthesize width;
@synthesize height;

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
	self = [super init];
	self.x = xcoord;
	self.y = ycoord;
	self.width = w;
	self.height = h;
	return self;
}

-(id)initWithRect:(CGRect) rect {
	self = [super init];
	self.x = rect.origin.x;
	self.y = rect.origin.y;
	self.width = rect.size.width;
	self.height = rect.size.height;
	return self;
}

-(void)update:(QContext*) context
{
}


-(QRectangle*)getBoundary
{
	return self;	
}


/**
 Calculate the midpoint of this rectangle.
 **/
-(QPoint *)midPoint
{
	return [[QPoint alloc] initX:self.x + (self.width/ 2.0f) Y:self.y + (self.height/2.0f)];	
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.x = [aDecoder decodeFloatForKey:@"x"];
	self.y = [aDecoder decodeFloatForKey:@"y"];
	self.width = [aDecoder decodeFloatForKey:@"width"];
	self.height = [aDecoder decodeFloatForKey:@"height"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeFloat:self.x forKey:@"x"];
	[aCoder encodeFloat:self.y forKey:@"y"];
	[aCoder encodeFloat:self.width forKey:@"width"];
	[aCoder encodeFloat:self.height forKey:@"height"];
}



/**
 Determine whether the supplied point resides within
 the rectangle.
 **/
-(BOOL)contains:(QPoint *)point
{
	QPoint *topLeft = [[QPoint alloc] initX:self.x Y:self.y];
	QPoint *bottomRight = [[QPoint alloc] initX:self.x + self.width Y:self.y + self.height];
	[topLeft retain];
	[bottomRight retain];
	// distance should be positive as point is greater than top left.
	float xTop = [topLeft horizontalDistanceTo:point];
	float yTop = [topLeft verticalDistanceTo:point];
	
	// distance should be negative as point is less than bottom right.
	float xBottom = [bottomRight horizontalDistanceTo:point];
	float yBottom = [bottomRight verticalDistanceTo:point];
	
	[topLeft release];
	[bottomRight release];
	
	return (xTop >= 0.0 && yTop >= 0.0 && xBottom <= 0.0 && yBottom <= 0.0);
}


/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other
{
	// very simple collision detection the rectangular intersection.
	float left = self.x;
	float left2 = other.x;
	float right = self.x + self.width;
	float right2 = other.x + other.width;
	float top = self.y;
	float top2 = other.y;
	float bottom = self.y + self.height;
	float bottom2 = other.y + other.height;
	if ((left > right2) || 
		(right < left2) ||
		(top > bottom2) ||
		(bottom < top2))
		return NO;
	return YES;	
}



@end
