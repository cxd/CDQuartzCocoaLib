//
//  CDQuartzNode.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.shapeDelegate = [aDecoder decodeObjectForKey:@"shapeDelegate"];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.shapeDelegate forKey:@"shapeDelegate"];
	
}
@end
