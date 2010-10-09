//
//  Add.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 19/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "Add.h"
#import "CDQuartzNode.h"

@implementation Add


-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	if (state.shouldDelete || state.newNode == nil) 
		return NO;
	return  [state.trackPoints count] > 0;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
	// use the first trackpoint to insert the new shape.
	CDQuartzNode* node = (CDQuartzNode*)[state.graph add:state.newNode.data];
	node.shapeDelegate = state.newNode.shapeDelegate;
	QPoint *p = [state.trackPoints objectAtIndex:0];
	[state.graph moveNode:node To:p];
	[state.newNode autorelease];
	state.newNode = nil;
	state.redraw = YES;
}

@end
