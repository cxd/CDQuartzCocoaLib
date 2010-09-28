//
//  TrackedNode.m
//  CDQuartzGraphTouch
//
//  Created by Chris Davey on 6/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TrackedNode.h"


@implementation TrackedNode

@synthesize index;
@synthesize node;

-(id)init
{
	self = [super init];
	return self;
}

-(id)initWithNode:(CDQuartzNode *)n atIndex:(int)i
{
	self = [super init];
	self.index = i;
	self.node = n;
	return self;
}

-(void)dealloc
{
	if (self.node != nil)
	{
		[self.node autorelease];
	}
	[super dealloc];
}

@end
