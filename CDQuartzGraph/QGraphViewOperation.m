//
//  QGraphViewOperation.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "QGraphViewOperation.h"


@implementation QGraphViewOperation

@synthesize children;

-(id)init
{
	self.children = [[NSMutableArray alloc] init];
	return self;
}

-(void)dealloc
{
	[super dealloc];
}

/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	return NO;
}

/**
 Update the state. 
 **/
-(void)update:(CDGraphViewState *)state
{
}

@end
