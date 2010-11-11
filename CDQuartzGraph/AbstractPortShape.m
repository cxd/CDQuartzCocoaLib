//
//  AbstractPortShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 15/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "AbstractPortShape.h"


@implementation AbstractPortShape

@synthesize parent;

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p
{
	self = [super init];
	self.parent = p;
	return self;
}

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r
{
	self = [super initWithBounds:r];
	self.parent = p;
	return self;
}


-(void)dealloc
{
	// weak reference to the parent, it is not retained.
	self.parent = nil;
	[super dealloc];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
}
@end
