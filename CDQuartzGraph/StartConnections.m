//
//  StartConnections.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 3/10/10.
//  Copyright 2010 none. All rights reserved.
//

#import "StartConnections.h"


@implementation StartConnections

-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	return state.editConnections;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	
}



@end
