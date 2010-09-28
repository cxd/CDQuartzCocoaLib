//
//  Move.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "Move.h"


@implementation Move

-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	
	return (!state.shouldDelete) && (!state.isCancelled) && ([state.trackNodes count] > 0);
}

/**
 Update the state by moving the tracked nodes.
 **/
-(void)update:(CDGraphViewState *)state
{
	int i = 0;
	for(QPoint *p in state.trackPoints)
	{
		TrackedNode *node = [state findNode:i];
		if (node.node != nil)
		{
			[state.graph moveNode:node.node To:p];
			state.redraw = YES;
		}
		i++;
	}
	[state.trackPoints removeAllObjects];
}

@end
