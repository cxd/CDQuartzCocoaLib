//
//  Edit.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 19/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "Edit.h"


@implementation Edit


-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	[super appliesTo:state];
	if (state.shouldDelete || state.newNode != nil) 
		return NO;
	return state.selectLabel && [state.trackPoints count] > 0;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	// select the currently tracked object.
	[state searchForTrackingNodes];
	// notify the state delegate which node is being edited.
	if (state.editDelegate != nil)
	{
		int i = 0;
		for(QPoint *p in state.trackPoints)
		{
			TrackedNode *node = [state findNode:i];
			if (node.node != nil)
			{
				// edit the node.
				[state.editDelegate editNode:node.node];
			}	
			i++;
		}
	}
}


@end
