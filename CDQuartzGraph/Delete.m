//
//  Delete.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 19/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "Delete.h"


@implementation Delete


-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	if (!state.shouldDelete || state.newNode != nil) 
		return NO;
	return [state.trackPoints count] > 0;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	state.shouldDelete = NO;
	[state searchForTrackingNodes];
	int i = 0;
	for(QPoint *p in state.trackPoints)
	{
		TrackedNode *node = [state findNode:i];
		if (node.node != nil)
		{
			if ([state.graph removeNode:node.node])
			{
				state.redraw = YES;
			}
		}
		i++;
	}
	[state.trackPoints removeAllObjects];
}


@end
