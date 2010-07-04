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


-(id)initWithX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float) sa EndAngle:(float)ea
{
	self = [super init];
	self.centre = [[QPoint alloc] initWithX:cx Y:cy];
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
	self.centre = [[QPoint alloc] initWithX:cp.x Y:cp.y];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = YES;
	self.isStart = NO;
	self.isEnd	= NO;
	return self;
}

-(id)initWithX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e
{
	self = [super init];
	self.centre = [[QPoint alloc] initWithX:cx Y:cy];
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
	self.centre = [[QPoint alloc] initWithX:cp.x Y:cp.y];
	self.radius = rad;
	self.startAngle = sa;
	self.endAngle = ea;
	self.isClockwise = YES;
	self.isStart = s;
	self.isEnd	= e;
	return self;
	
}

-(id)initWithX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e CLOCKWISE:(BOOL)cw 
{
	self = [super init];
	self.centre = [[QPoint alloc] initWithX:cx Y:cy];
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
	self.centre = [[QPoint alloc] initWithX:cp.x Y:cp.y];
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
	if (self.isStart)
	{
		CGContextBeginPath(context.context);
		// calculate the beginning of the arc using radius and angle 
		// and move to that point.
		float startX = self.centre.x + self.radius * cos(self.startAngle * (M_PI/180.0));
		float startY = self.centre.y + self.radius * sin(self.startAngle * (M_PI/180.0));
		CGContextMoveToPoint(context.context, startX, startY);
	}
	CGContextAddArc(context.context, 
					self.centre.x, 
					self.centre.y,
					self.radius,
					self.startAngle * (M_PI/180.0),
					self.endAngle * (M_PI/180.0),
					self.isClockwise);
	if (self.isEnd)
	{
		CGContextClosePath(context.context);	
	}
	
}

-(QRectangle*)getBoundary
{
	// determine the starting point.
	float startX = self.centre.x + self.radius * cos(self.startAngle * (M_PI/180.0));
	float startY = self.centre.y + self.radius * sin(self.startAngle * (M_PI/180.0));
	
	// the end point.
	float endX = self.centre.x + self.radius * cos(self.endAngle * (M_PI/180.0));
	float endY = self.centre.y + self.radius * sin(self.endAngle * (M_PI/180.0));
	
	// the mid point
	// the end point.
	float midX = self.centre.x + self.radius * cos((self.startAngle + (self.endAngle - self.startAngle)/2.0) * (M_PI/180.0));
	float midY = self.centre.y + self.radius * sin((self.startAngle + (self.endAngle - self.startAngle)/2.0) * (M_PI/180.0));

	QPoint *start = [[QPoint alloc]initWithX:startX Y:startY];
	QPoint *mid = [[QPoint alloc]initWithX:midX Y:midY];
	QPoint *end = [[QPoint alloc] initWithX:endX Y:endY];
	
	float width =  fabs([start distanceTo:end]);
	float height = fabs([start distanceTo:mid]);
	
	[start autorelease];
	[mid autorelease];
	[end autorelease];
	
	return [[QRectangle alloc] initWithX:startX Y:startY WIDTH:width HEIGHT:height];	
}

@end
