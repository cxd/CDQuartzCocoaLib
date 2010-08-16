//
//  CDQuartzEdge.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzEdge.h"


@implementation CDQuartzEdge

@synthesize shapeDelegate;

/**
 Default initialiser.
 **/
-(id)init
{
	self = [super init];
	return self;
}

-(id)initWithShape:(AbstractConnectorShape*) s
{
	self = [super init];
	self.shapeDelegate = s;
	return self;
}


/**
 Dealloc
 **/
-(void)dealloc
{
	if (self.shapeDelegate != nil)
	{
		[self.shapeDelegate autorelease];	
	}
	[super dealloc];
}



/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context
{
	if (self.shapeDelegate != nil)
	{
		[self.shapeDelegate update:context];	
	}
}

@end
