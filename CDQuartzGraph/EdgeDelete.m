//
//  EdgeDelete.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 9/10/10.
//  Copyright 2010 none. All rights reserved.
//

#import "EdgeDelete.h"


@implementation EdgeDelete


-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	if (!state.shouldDelete || state.isCancelled) 
		return NO;
	return	(state.shouldDelete) && 
			(!state.isCancelled) && 
			([state.selectEdges count] > 0) &&
			(state.isEditing);
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	int i = 0;
	for(QPoint *p in state.hoverPoints)
	{
		TrackedEdge *t = [state findTrackedEdge:i];
		if (t.edge != nil)
		{
			// disconnect the items.
			[state.graph disconnect:t.edge.source to:t.edge.target]; 
			// remove it from detached edges if it exists.
			t.edge.source = nil;
			t.edge.target = nil;
			[state.detachedEdges removeObject:(id)t.edge];
			[state.selectEdges removeObjectAtIndex:t.index];
		}
	}
	state.shouldDelete = NO;
	state.redraw = YES;
}


@end
