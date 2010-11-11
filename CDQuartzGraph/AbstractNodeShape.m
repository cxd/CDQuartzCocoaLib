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

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super initWithLabel:l];
	self.ports = [[NSMutableArray alloc] init];
	return self;
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super initWithBounds:b AndLabel:l];
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
	[super moveBy:point];
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
	QPoint *delta = [[QPoint alloc] initX: point.x - self.bounds.x
											Y: point.y - self.bounds.y];
	[super moveBy:delta];
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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.ports = [aDecoder decodeObjectForKey:@"AbstractNodeShape_ports"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.ports forKey:@"AbstractNodeShape_ports"];
}

@end
