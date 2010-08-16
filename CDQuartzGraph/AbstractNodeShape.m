//
//  AbstractNodeShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "AbstractNodeShape.h"


@implementation AbstractNodeShape

@synthesize ports;


/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	self.ports = [[NSMutableArray alloc] init];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super initWithBounds:b];
	self.ports = [[NSMutableArray alloc] init];
	return self;
}


-(void)dealloc
{
	[self.ports removeAllObjects];
	[self.ports autorelease];
	[super dealloc];
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	for(AbstractGraphShape *p in self.ports)
	{
		[p moveBy:point];
	}
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	QPoint *delta = [[QPoint alloc] initWithX: point.x - self.bounds.x
											Y: point.y - self.bounds.y];
	for(AbstractGraphShape *p in self.ports)
	{
		[p moveBy:delta];	
	}
}

/**
 Update the context.
 **/
-(void)update:(QContext *)context
{
	if (self.ports != nil)
	{
		for(AbstractGraphShape *p in self.ports)
		{
			[p update:context];
		}
	}
	[super update:context];
}
@end
