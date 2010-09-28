//
//  Select.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "Select.h"


@implementation Select

-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	if (state.shouldDelete) 
		return NO;
	return [state.trackPoints count] > 0;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	[state searchForTrackingNodes];
}


@end
