//
//  AbstractConnectorShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "AbstractConnectorShape.h"


@implementation AbstractConnectorShape

/**
 Start decoration.
 **/
@synthesize startDecoration;
/**
 End decoration.
 **/
@synthesize endDecoration;

@synthesize startPort;

@synthesize endPort;


/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super initWithBounds:b];
	return self;	
}


-(void)dealloc
{
	if (self.startDecoration != nil)
	{
		[self.startDecoration autorelease];	
	}
	if (self.endDecoration != nil)
	{
		[self.endDecoration autorelease];	
	}
	if (self.startPort != nil)
	{
		[self.startPort autorelease];	
	}
	if (self.endPort != nil)
	{
		[self.endPort autorelease];	
	}
	[super dealloc];
}

/**
 Update the context.
 **/
-(void)update:(QContext *)context
{
	if (self.startDecoration != nil)
	{
		[self.startDecoration update:context];	
	}
	if (self.endDecoration != nil)
	{
		[self.endDecoration update:context];	
	}
	[super update:context];
}


/**
 Connect the start line to supplied port.
 **/
-(void)connectStartTo:(AbstractPortShape *)port
{
	self.startPort = port;
	// TODO: move to the mid point of the port shape.
}

/**
 Connect the end line to supplied port.
 **/
-(void)connectEndTo:(AbstractPortShape *)port
{
	self.endPort = port;
	// TODO: move to the mid point of the port shape
}


@end
