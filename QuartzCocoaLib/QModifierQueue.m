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
	[sequence addObject:[modifier retain]];
}
-(id<QContextModifier>)dequeue 
{
	id<QContextModifier> obj = [self top];
	if (obj != nil) {
		[sequence removeObjectAtIndex:0];
	}
	return [obj autorelease];
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
	[sequence autorelease];
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
	return [queue autorelease];
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
	return [queue autorelease];	
}


#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	sequence = [[NSMutableArray alloc] init];
	int cnt = [aDecoder decodeIntForKey:@"sequenceCount"];
	for(int i=0;i<cnt;i++)
	{
		NSString *name = [NSString stringWithFormat:@"sequence%i", i];
		NSObject *o = [aDecoder decodeObjectForKey:name];
		if (o == nil) continue;
		[sequence addObject:o];
	}
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	NSMutableArray *copy = [[NSMutableArray alloc] init];
	int i=0;
	for(NSObject *o in sequence)
	{
		if (o == nil) continue;
		NSString *name =[NSString stringWithFormat:@"sequence%i", i];
		[copy addObject:o];
		[aCoder encodeObject:o forKey:name];
		i++;
	}
	[copy autorelease];
	[aCoder encodeInt:i forKey:@"sequenceCount"];
}
@end
