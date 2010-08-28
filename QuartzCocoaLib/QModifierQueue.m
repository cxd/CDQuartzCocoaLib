//
//  QModifierQueue.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QModifierQueue.h"


@implementation QModifierQueue


-(id)init
{
	self = [super init];
	sequence = [[NSMutableArray alloc] init];
	[sequence retain];
	return self;
}

-(void)enqueue:(id<QContextModifier>) modifier 
{
	[modifier retain];
	[sequence addObject:(id)modifier];
}
-(id<QContextModifier>)dequeue 
{
	id<QContextModifier> obj = [self top];
	if (obj != nil) {
		[sequence removeObjectAtIndex:0];
		[obj autorelease];
	}
	return obj;
}

-(id<QContextModifier>)top
{
	if ([self isEmpty])
		return nil;
	return [sequence objectAtIndex:0];
}
-(id<QContextModifier>)tail
{
	if ([self isEmpty])
		return nil;
	return [sequence objectAtIndex:([sequence count] - 1)];
}
-(BOOL)isEmpty
{
	return [sequence count] <= 0;	
}
-(void)clear
{
	while(![self isEmpty]) {
		[self dequeue];
	}
	[sequence removeAllObjects];
}
-(void)dealloc
{
	[self clear];
	[sequence release];
	[super dealloc];
}

+(QModifierQueue *)updateContext:(QContext *)context SourceQueue:(QModifierQueue *)source;
{
	QModifierQueue *queue = [[QModifierQueue alloc] init];
	while(![source isEmpty])
	{
		id<QContextModifier> modifier = [source dequeue];
		[modifier update:context];
		[queue enqueue:modifier];
	}
	return queue;
}

/**
 Traverse and copy the queue.
 **/
+(QModifierQueue *)traverseQueue:(QModifierQueue *)source Visitor:(id <QVisitor>)visitor Args:(id)arguments
{
	QModifierQueue *queue = [[QModifierQueue alloc] init];
	while(![source isEmpty])
	{
		id<QContextModifier> modifier = [source dequeue];
		[visitor visit:modifier data:arguments];
		[queue enqueue:modifier];
	}
	return queue;	
}

@end
