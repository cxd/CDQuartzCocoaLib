//
//  AbstractConnectorShape.m
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
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super initWithLabel:l];
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

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super initWithBounds:b AndLabel:l];
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
 Initialise the line with default bounds.
 Use the diagonal of the bounds to set the key points.
 **/
-(void)initialiseRect:(QRectangle *)b
{
	self.startDecoration = [[CirclePortShape alloc] initWithParent:self];
	self.startDecoration.bounds.width = 10;
	self.startDecoration.bounds.height = 10;
	self.endDecoration = [[CirclePortShape alloc] initWithParent:self];
	self.endDecoration.bounds.width = 10;
	self.endDecoration.bounds.height = 10;

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
 Update Connections.
 **/
-(void)updateConnections 
{
	float sX, sY, eX, eY = 0.0;
	// move to the mid point of the port shape.
	if (self.startDecoration != nil)
	{
		sX = self.startDecoration.bounds.x;
		sY = self.startDecoration.bounds.y;
	}
	if (self.endDecoration != nil)
	{
		eX = self.endDecoration.bounds.x;
		eY = self.endDecoration.bounds.y;
	}
	
	if (self.startPort != nil)
	{
		sX = self.startPort.bounds.x + self.startPort.bounds.width/2.0;
		sY = self.startPort.bounds.y + self.startPort.bounds.height/2.0;
	}
	if (self.endPort != nil)
	{
		eX = self.endPort.bounds.x + self.startPort.bounds.width/2.0;
		eY = self.endPort.bounds.y + self.endPort.bounds.height/2.0;
		if ((sX - eX < 0) && (sY - eY < 0))
		{
			eX = self.endPort.bounds.x;
		}
	}
	if (self.startDecoration != nil)
	{
	[self.startDecoration moveTo:[[QPoint alloc] initX:sX - self.startDecoration.bounds.width/2.0f 
													 Y:sY - self.startDecoration.bounds.height/2.0f]];
	}
	if (self.endDecoration != nil)
	{
	[self.endDecoration moveTo:[[QPoint alloc] initX:eX - self.endDecoration.bounds.width/2.0f 
												   Y:eY - self.endDecoration.bounds.height/2.0f]];
	}
}


/**
 Connect the start line to supplied port.
 **/
-(void)connectStartTo:(AbstractPortShape *)port
{
	self.startPort = port;
	[self updateConnections];
}

/**
 Connect the end line to supplied port.
 **/
-(void)connectEndTo:(AbstractPortShape *)port
{
	self.endPort = port;
	[self updateConnections];
}


-(void)moveStartBy:(QPoint *)p
{
	if (self.startDecoration != nil)
	{
		[self.startDecoration moveBy:p];
	}
}

-(void)moveEndBy:(QPoint *)p
{
	if (self.endDecoration != nil)
	{
		[self.endDecoration moveBy:p];
	}
}

-(void)moveStartTo:(QPoint *)p
{
	if (self.startDecoration != nil)
	{
		[self.startDecoration moveTo:p];
	}
}

-(void)moveEndTo:(QPoint *)p
{
	if (self.endDecoration != nil)
	{
		[self.endDecoration moveTo:p];
	}
}

/**
 Check whether a point occurs within the bounds
 of this object.
 **/
-(BOOL)isWithinBounds:(QPoint *)point
{
	BOOL flag = NO;
	if (self.endDecoration != nil)
	{
		flag = [self.endDecoration isWithinBounds:point];
	}
	if (self.startDecoration != nil)
	{
		flag |= [self.startDecoration isWithinBounds:point];	
	}
	return flag;
}

#ifdef UIKIT_EXTERN 

// TODO: define tracking boundary protocol for ui kit.

#else

/**
 Attach the tracking area to a view.
 **/
-(void)attachTrackingAreaToView:(NSView *)view
{
	if (self.startDecoration != nil)
	{
		[self.startDecoration attachTrackingAreaToView:view];	
	}
	if (self.endDecoration != nil)
	{
		[self.endDecoration attachTrackingAreaToView:view];	
	}
}

/**
 Remove the tracking area from the view.
 **/
-(void)removeTrackingAreaFromView:(NSView *)view
{
	if (self.startDecoration != nil)
	{
		[self.startDecoration removeTrackingAreaFromView:view];	
	}
	if (self.endDecoration != nil)
	{
		[self.endDecoration removeTrackingAreaFromView:view];	
	}	
}

#endif

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.startDecoration = [aDecoder decodeObjectForKey:@"AbstractConnectorShape_startDecoration"];
	self.endDecoration = [aDecoder decodeObjectForKey:@"AbstractConnectorShape_endDecoration"];
	self.startPort = [aDecoder decodeObjectForKey:@"AbstractConnectorShape_startPort"];
	self.endPort = [aDecoder decodeObjectForKey:@"AbstractConnectorShape_endPort"];	
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.startDecoration forKey:@"AbstractConnectorShape_startDecoration"];
	[aCoder encodeObject:self.endDecoration forKey:@"AbstractConnectorShape_endDecoration"];
	[aCoder encodeObject:self.startPort forKey:@"AbstractConnectorShape_startPort"];
	[aCoder encodeObject:self.endPort forKey:@"AbstractConnectorShape_endPort"];
}


@end
