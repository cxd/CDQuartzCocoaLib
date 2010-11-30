//
//  QShape.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QShape.h"


@implementation QShape

@synthesize queue;

-(id)init {
	self = [super init];
	self.queue = [[[QModifierQueue alloc] init] autorelease];
	return self;
}
-(void)dealloc
{
	[self.queue autorelease];
	[super dealloc];
}
-(void)add:(QAbstractContextModifier *)modifier
{
	[self.queue enqueue:modifier];	
}
-(void)clear
{
	[self.queue clear];
}
-(void)update:(QContext *)context
{
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:self.queue];
	// the modifier queue will autorelease the self queue reference.
	self.queue = copy;
}

-(QRectangle*)getBoundary
{
	QRectangle *args = [[QRectangle alloc] initX:INFINITY Y:INFINITY WIDTH:0 HEIGHT:0];
	QModifierQueue *copy = [QModifierQueue traverseQueue:self.queue Visitor:self Args:args];
	self.queue = copy;
	return [args autorelease];
}

-(void)visit:(id <QContextModifier>)modifier data:(id)arguments
{
	if (!([(id)modifier respondsToSelector:@selector(getBoundary:)])) 
		return;
	QRectangle* rect = (QRectangle*)arguments;
	QRectangle* bounds = [(id)modifier getBoundary];
	if (bounds == nil) return;
	if (rect.x == INFINITY)
	{
		rect.x = bounds.x;	
	} 
	else if (rect.x > bounds.x) 
	{
		rect.x = bounds.x;
	}
	if (rect.y == INFINITY) 
	{
		rect.y = bounds.y;	
	} 
	else if (rect.y > bounds.y) 
	{
		rect.y = bounds.y;	
	}
	if (rect.width < bounds.width)
	{
		rect.width = bounds.width;	
	}
	if (rect.height < bounds.height)
	{
		rect.height = bounds.height;	
	}
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.queue = [aDecoder decodeObjectForKey:@"queue"];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.queue forKey:@"queue"];
}
@end
