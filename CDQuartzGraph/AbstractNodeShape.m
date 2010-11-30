//
//  AbstractNodeShape.m
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
	[delta autorelease];
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
