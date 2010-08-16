//
//  CDQuartzNode.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzNode.h"


@implementation CDQuartzNode

@synthesize shapeDelegate;

/**
 Initialise with user data.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithData:(NSObject *)userData
{
	self = [super initWithData:userData];	
	return self;
}

/**
 Initialise with a copy of another node.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 This will retain a shallow copy to the user data in the node.
 **/
-(id)initWithCopy:(CDNode *)node
{
	self = [super initWithData:node.data];
	return self;
}

/**
 Initialise with user data.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithShape:(AbstractNodeShape*) s AndData:(NSObject *)userData
{
	self = [super initWithData:userData];
	self.shapeDelegate = s;
	return self;
}

/**
 Initialise with a copy of another node.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithShape:(AbstractNodeShape*) s AndCopy:(CDNode *)node
{
	self = [super initWithData:node.data];
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
