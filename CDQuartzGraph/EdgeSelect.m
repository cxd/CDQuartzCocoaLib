//
//  EdgeSelect.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 20/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "EdgeSelect.h"


@implementation EdgeSelect


-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	if (state.shouldDelete || state.isCancelled) 
		return NO;
	if ([state.hoverPoints count] > 0)
	{
		[state searchForTrackingEdges];
		return [state.selectEdges count] > 0;
	}
	return NO;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	// search for tracking edges.
	
}


@end
