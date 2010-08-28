//
//  QBezierCurve.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QBezierCurve.h"


@implementation QBezierCurve

@synthesize control1;
@synthesize control2;


-(id)initX: (float)x Y: (float)y X2: (float)xx Y2:(float)yy CX1:(float) cx1 CY1: (float) cy1 CX2:(float) cx2 CY2: (float)cy2
{
	self = [super initX:x Y:y X2:xx Y2:yy];
	self.control1 = [[QPoint alloc] initX:cx1 Y:cy1];
	self.control2 = [[QPoint alloc] initX: cx2 Y:cy2];
	return self;
}

-(id)initX: (float)x Y:(float)y X2:(float)xx Y2:(float) yy CX1:(float) cx1 CY1: (float) cy1 CX2:(float) cx2 CY2: (float)cy2 START:(BOOL) s END:(BOOL) e
{
	self = [super initX:x Y:y X2:xx Y2:yy START:s END:e];
	self.control1 = [[QPoint alloc] initX:cx1 Y:cy1];
	self.control2 = [[QPoint alloc] initX: cx2 Y:cy2];
	return self;
}

-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to CtPoint1: (QPoint *)p1 CtPoint2: (QPoint*) p2
{
	self = [super initWithStart:from Finish:to];
	self.control1 = [[QPoint alloc] initX:p1.x Y:p1.y];
	self.control2 = [[QPoint alloc] initX:p2.x Y:p2.y];
	return self;
}

-(id)initWidthStart: (QPoint *)from Finish: (QPoint *)to CtPoint1: (QPoint *)p1 CtPoint2: (QPoint*) p2 START:(BOOL) s END:(BOOL) e
{
	self = [super initWithStart:from Finish:to START:s END:e];
	self.control1 = [[QPoint alloc] initX:p1.x Y:p1.y];
	self.control2 = [[QPoint alloc] initX:p2.x Y:p2.y];
	return self;
}


-(void)dealloc
{
	[self.control1 autorelease];
	[self.control2 autorelease];
	[super dealloc];
}
-(void)update:(QContext *)context
{
	if (self.isStart)
	{
		CGContextBeginPath(context.context);
		CGContextMoveToPoint(context.context, self.start.x, self.start.y);
	}
	CGContextAddCurveToPoint(context.context, 
							 self.control1.x, 
							 self.control1.y, 
							 self.control2.x,
							 self.control2.y,
							 self.end.x, 
							 self.end.y);
	if (self.isEnd)
	{
		CGContextClosePath(context.context);	
	}
	
}

/**
 sort values in ascending or descending order.
 **/
NSInteger sortValue(id val1, id val2, void* reverse)
{
	if ((BOOL*)reverse && ([val1 floatValue] < [val2 floatValue]))
		return (NSInteger)[NSNumber numberWithInt:1];
	if ([val1 floatValue] < [val2 floatValue])
		return (NSInteger)[NSNumber numberWithInt:-1];
	
	if ((BOOL*)reverse && ([val1 floatValue] > [val2 floatValue]))
		return (NSInteger)[NSNumber numberWithInt:-1];
	
	if ([val1 floatValue] > [val2 floatValue])
		return (NSInteger)[NSNumber numberWithInt:1];
	
	return (NSInteger)[NSNumber numberWithInt:0];
}

/**
 get the rectangle boundary of the bezier curve. 
 **/
-(QRectangle*)getBoundary
{
	float width = 0.0;
	float height = 0.0;
	NSArray *widthArray = [[NSArray alloc] 
						   arrayWithObjects:
						   [NSNumber numberWithFloat: [self.start horizontalDistanceTo:self.end]],
						   [NSNumber numberWithFloat:[self.start horizontalDistanceTo:self.control1]],
						   [NSNumber numberWithFloat:[self.start horizontalDistanceTo:self.control2]],
						   nil];
	
	NSArray *heightArray = [[NSArray alloc] 
							arrayWithObjects:
							[NSNumber numberWithFloat:[self.start verticalDistanceTo:self.end]],
							[NSNumber numberWithFloat:[self.start verticalDistanceTo:self.control1]],
							[NSNumber numberWithFloat:[self.start verticalDistanceTo:self.control2]],
							nil];
	BOOL reverse = YES;
	NSArray *widthSorted = [widthArray sortedArrayUsingFunction:sortValue context:&reverse];
	NSArray *heightSorted = [heightArray sortedArrayUsingFunction:sortValue context:&reverse];
	width = [(NSNumber *)[widthSorted objectAtIndex:0] floatValue];
	height = [(NSNumber *)[heightSorted objectAtIndex:0] floatValue];
	[widthArray autorelease];
	[heightArray autorelease];
	[widthSorted autorelease];
	[heightSorted autorelease];
	return [[QRectangle alloc] initX:self.start.x Y:self.start.y WIDTH:width HEIGHT:height];
}

@end
