//
//  Cancel.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 19/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "Cancel.h"


@implementation Cancel

-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	return (state.isCancelled);
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	[state.trackNodes removeAllObjects];
	[state.trackPoints removeAllObjects];
}


@end
