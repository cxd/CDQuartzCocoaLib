//
//  QArc.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QArc.h"


@implementation QArc


@synthesize centre;
@synthesize radius;
@synthesize startAngle;
@synthesize endAngle;
@synthesize isClockwise;
@synthesize isStart;
@synthesize isEnd;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init
{
	self = [super init];
	return self;
}

-(id)initX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float) sa EndAngle:(float)ea
{
	self = [super init];
	self.centre = [[QPoint alloc] initX:cx Y:cy];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = YES;
	self.isStart = NO;
	self.isEnd	= NO;
	return self;
}

-(id)initWithCentre:(QPoint *)cp Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea
{
	self = [super init];
	self.centre = [[QPoint alloc] initX:cp.x Y:cp.y];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = YES;
	self.isStart = NO;
	self.isEnd	= NO;
	return self;
}

-(id)initX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e
{
	self = [super init];
	self.centre = [[QPoint alloc] initX:cx Y:cy];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = YES;
	self.isStart = s;
	self.isEnd	= e;
	return self;
	
}

-(id)initWithCentre:(QPoint *)cp Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e
{
	self = [super init];
	self.centre = [[QPoint alloc] initX:cp.x Y:cp.y];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = YES;
	self.isStart = s;
	self.isEnd	= e;
	return self;
	
}

-(id)initX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e CLOCKWISE:(BOOL)cw 
{
	self = [super init];
	self.centre = [[QPoint alloc] initX:cx Y:cy];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = cw;
	self.isStart = s;
	self.isEnd	= e;
	return self;	
}
-(id)initWithCentre:(QPoint *)cp Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e CLOCKWISE:(BOOL)cw 
{
	self = [super init];
	self.centre = [[QPoint alloc] initX:cp.x Y:cp.y];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = cw;
	self.isStart = s;
	self.isEnd	= e;
	return self;
	
}

-(void)dealloc
{
	[self.centre autorelease];
	[super dealloc];
}

-(void)update:(QContext*)context
{
	float pi = M_PI;
	if (self.isStart)
	{
		CGContextBeginPath(context.context);
		// calculate the beginning of the arc using radius and angle 
		// and move to that point.
		float startX = self.centre.x + self.radius * cos(self.startAngle * (pi/180.0));
		float startY = self.centre.y + self.radius * sin(self.startAngle * (pi/180.0));
		CGContextMoveToPoint(context.context, startX, startY);
	}
	CGContextAddArc(context.context, 
					self.centre.x, 
					self.centre.y,
					self.radius,
					self.startAngle * (pi/180.0),
					self.endAngle * (pi/180.0),
					self.isClockwise);
	if (self.isEnd)
	{
		CGContextClosePath(context.context);	
	}
	
}

-(QRectangle*)getBoundary
{
	float pi = M_PI;
	// determine the starting point.
	float startX = self.centre.x + self.radius * cos(self.startAngle * (pi/180.0));
	float startY = self.centre.y + self.radius * sin(self.startAngle * (pi/180.0));
	
	// the end point.
	float endX = self.centre.x + self.radius * cos(self.endAngle * (pi/180.0));
	float endY = self.centre.y + self.radius * sin(self.endAngle * (pi/180.0));
	
	// the mid point
	// the end point.
	float midX = self.centre.x + self.radius * cos((self.startAngle + (self.endAngle - self.startAngle)/2.0) * (pi/180.0));
	float midY = self.centre.y + self.radius * sin((self.startAngle + (self.endAngle - self.startAngle)/2.0) * (pi/180.0));

	QPoint *start = [[QPoint alloc] initX:startX Y:startY];
	QPoint *mid = [[QPoint alloc] initX:midX Y:midY];
	QPoint *end = [[QPoint alloc] initX:endX Y:endY];
	
	float width =  fabs([start distanceTo:end]);
	float height = fabs([start distanceTo:mid]);
	
	[start autorelease];
	[mid autorelease];
	[end autorelease];
	
	return [[[QRectangle alloc] initX:startX Y:startY WIDTH:width HEIGHT:height] autorelease];	
}

#pragma mark Encoder and Decoder.

-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.centre = [aDecoder decodeObjectForKey:@"centre"];
	self.radius = [aDecoder decodeFloatForKey:@"radius"];
	self.startAngle = [aDecoder decodeFloatForKey:@"startAngle"];
	self.endAngle = [aDecoder decodeFloatForKey:@"endAngle"];
	self.isClockwise = [aDecoder decodeBoolForKey:@"isClockwise"];
	self.isStart = [aDecoder decodeBoolForKey:@"isStart"];
	self.isEnd	= [aDecoder decodeBoolForKey:@"isEnd"];
	return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.centre forKey:@"centre"];
	[aCoder encodeFloat:self.radius forKey:@"radius"];
	[aCoder encodeFloat:self.startAngle forKey:@"startAngle"];
	[aCoder encodeFloat:self.endAngle forKey:@"endAngle"];
	[aCoder encodeBool:self.isClockwise forKey:@"isClockwise"];
	[aCoder encodeBool:self.isStart forKey:@"isStart"];
	[aCoder encodeBool:self.isEnd forKey:@"isEnd"];
}

@end
