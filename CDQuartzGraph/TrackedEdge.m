//
//  TrackedEdge.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 20/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TrackedEdge.h"


@implementation TrackedEdge

@synthesize index;

@synthesize edge;



-(id)init
{
	self = [super init];
	return self;
}

-(id)initWithEdge:(CDQuartzEdge *)e atIndex:(int)i
{
	self = [super init];
	self.edge = e;
	self.index = i;
	return self;
}

-(void)dealloc
{
	if (self.edge != nil)
	{
		[self.edge autorelease];	
	}
	[super dealloc];
}

@end
