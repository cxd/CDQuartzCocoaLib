//
//  QLine.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QLine.h"


@implementation QLine

@synthesize start;
@synthesize end;
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

-(id)initX: (float)x Y: (float)y X2: (float)xx Y2:(float)yy
{
	self = [super init];
	self.start = [[QPoint alloc] initX:x Y:y];
	self.end = [[QPoint alloc] initX:xx Y:yy];
	self.isStart = NO;
	self.isEnd = NO;
	return self;
}

-(id)initX: (float)x Y:(float)y X2:(float)xx Y2:(float) yy START:(BOOL) s END:(BOOL) e
{
	self = [super init];
	self.start = [[QPoint alloc] initX:x Y:y];
	self.end = [[QPoint alloc] initX:xx Y:yy];
	self.isStart = s;
	self.isEnd = e;
	return self;
}

-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to
{
	self = [super init];
	self.start = [[QPoint alloc] initX:from.x Y:from.y];
	self.end = [[QPoint alloc] initX:to.x Y:to.y];
	self.isStart = NO;
	self.isEnd = NO;
	return self;
}

-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to START:(BOOL) s END:(BOOL) e
{
	self = [super init];
	self.start = [[QPoint alloc] initX:from.x Y:from.y];
	self.end = [[QPoint alloc] initX:to.x Y:to.y];
	self.isStart = s;
	self.isEnd = e;
	return self;
}

-(void)dealloc {
	[self.start autorelease];
	[self.end autorelease];
	[super dealloc];
}

-(void)update:(QContext *)context
{
	if (self.isStart)
	{
		CGContextBeginPath(context.context);
		CGContextMoveToPoint(context.context, self.start.x, self.start.y);
	}
	CGContextAddLineToPoint(context.context, self.end.x, self.end.y);
	if (self.isEnd)
	{
		CGContextClosePath(context.context);	
	}
}


-(QRectangle*)getBoundary
{
	float width = [self.start horizontalDistanceTo:self.end];
	float height = [self.start verticalDistanceTo:self.end];
	return [[QRectangle alloc] initX:self.start.x Y:self.start.y WIDTH:width HEIGHT:height];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.start = [aDecoder decodeObjectForKey:@"start"];
	self.end = [aDecoder decodeObjectForKey:@"end"];
	self.isStart = [aDecoder decodeBoolForKey:@"isStart"];
	self.isEnd = [aDecoder decodeBoolForKey:@"isEnd"];	
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.start forKey:@"start"];
	[aCoder encodeObject:self.end forKey:@"end"];
	[aCoder encodeBool:self.isStart forKey:@"isStart"];
	[aCoder encodeBool:self.isEnd forKey:@"isEnd"];
}
@end
