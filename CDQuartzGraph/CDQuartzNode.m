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



/**
 Check whether a point occurs within the bounds
 of this object.
 **/
-(BOOL)isWithinBounds:(QPoint *)point
{
	if (self.shapeDelegate != nil)
	{
	return [self.shapeDelegate isWithinBounds:point];
	}
	return NO;
}

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other
{
	if (self.shapeDelegate != nil)
	{
		return [self.shapeDelegate intersects:other];	
	}
	return NO;
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	if (self.shapeDelegate == nil) return;
	[self.shapeDelegate moveBy:point];
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	if (self.shapeDelegate == nil) return;
	[self.shapeDelegate moveTo:point];
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	if (self.shapeDelegate == nil) return;
	[self.shapeDelegate resizeToWidth:w height:h];
}
@end
