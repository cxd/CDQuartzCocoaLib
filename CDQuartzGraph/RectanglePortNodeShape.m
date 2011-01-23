//
//  AbstractBoundPortShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "RectanglePortNodeShape.h"


@implementation RectanglePortNodeShape

@synthesize strokeColor;
@synthesize foreColor;
@synthesize strokeWidth;

/**
 Left hand port.
 **/
@synthesize leftPort;

/**
 Top port.
 **/
@synthesize topPort;

/**
 RHS port.
 **/
@synthesize rightPort;

/**
 Bottom port.
 **/
@synthesize bottomPort;


/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	self.bounds.width = 200;
	self.bounds.height = 150;
	[self createPorts];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super initWithBounds:b];
	[self createPorts];
	return self;
}

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super initWithLabel:l];
	self.bounds.width = 200;
	self.bounds.height = 150;
	[self createPorts];
	return self;
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super initWithBounds:b AndLabel:l];
	[self createPorts];
	return self;
}

/**
 clear up the object.
 **/
-(void)dealloc
{
	if (self.foreColor != nil) 
		[self.foreColor autorelease];
	if (self.outlineColor != nil) 
		[self.outlineColor autorelease];
	if (self.strokeWidth != nil)
		[self.strokeWidth autorelease];
	[super dealloc];
}



/**
 Event raised when fill color changed.
 **/
-(void)onFillColorChanged
{
	self.foreColor.red = self.fillColor.red;
	self.foreColor.blue = self.fillColor.blue;
	self.foreColor.green = self.fillColor.green;
	self.foreColor.alpha = self.fillColor.alpha;
}


/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged
{
	self.strokeWidth.width = self.outlineWeight;	
}

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged
{
	self.strokeColor.red = self.outlineColor.red;
	self.strokeColor.blue = self.outlineColor.blue;
	self.strokeColor.green = self.outlineColor.green;
	self.strokeColor.alpha = self.outlineColor.alpha;
}

/**
 Create the set of ports associated with the rectangle.
 **/
-(void)createPorts
{
	float portWidth = 5.0f;
	// use the midpoints of each port.
	QRectangle *leftB = [[QRectangle alloc] initX: self.bounds.x - portWidth/2.0
												Y: (self.bounds.y + self.bounds.height/2.0 - portWidth/2.0)
											WIDTH:portWidth
										   HEIGHT:portWidth];
	self.leftPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:leftB];
	[leftB autorelease];
	[self.ports addObject:self.leftPort];
	
	QRectangle *topB = [[QRectangle alloc] initX:self.bounds.x + self.bounds.width/2.0 - portWidth/2.0
											   Y:self.bounds.y - portWidth/2.0
										   WIDTH:portWidth 
										  HEIGHT:portWidth];
	self.topPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:topB];
	[topB autorelease];
	[self.ports addObject:self.topPort];
	
	
	QRectangle *rightB = [[QRectangle alloc] initX: self.bounds.x + self.bounds.width - portWidth/2.0
												 Y: self.bounds.y + self.bounds.height/2.0 - portWidth/2.0
											 WIDTH:portWidth
											HEIGHT:portWidth];
	self.rightPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:rightB];
	[rightB autorelease];
	[self.ports addObject:self.rightPort];
	
	QRectangle *bottomB = [[QRectangle alloc] initX:self.bounds.x + self.bounds.width/2.0 - portWidth/2.0
												  Y:self.bounds.y + self.bounds.height - portWidth/2.0
											  WIDTH:portWidth 
											 HEIGHT:portWidth];
	self.bottomPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:bottomB];
	[bottomB autorelease];
	[self.ports addObject:self.bottomPort];
}
/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
	// recompute the left, top, right and bottom positions
	// use the midpoints of each port.
	float portWidth = self.leftPort.bounds.width;
	
	float left = self.bounds.x - portWidth/2.0;
	float top = self.bounds.height/2.0 - portWidth/2.0;
	[self.leftPort moveTo:[[[QPoint alloc] initX:left Y:top] autorelease]];
	
	left = self.bounds.x + self.bounds.width/2.0 - portWidth/2.0;
	top = self.bounds.y - portWidth/2.0;
	[self.topPort moveTo:[[[QPoint alloc] initX:left Y:top] autorelease]];
	
	left = self.bounds.x + self.bounds.width - portWidth/2.0;
	top = self.bounds.height/2.0 - portWidth/2.0;
	[self.rightPort moveTo:[[[QPoint alloc] initX:left Y:top] autorelease]];
	
	left = self.bounds.x + self.bounds.width/2.0 - portWidth/2.0;
	top = self.bounds.y + self.bounds.height - portWidth/2.0;
	[self.bottomPort moveTo:[[[QPoint alloc] initX:left Y:top] autorelease]];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	self.leftPort=[aDecoder decodeObjectForKey:@"RectanglePortNodeShape_leftPort"];
	self.topPort = [aDecoder decodeObjectForKey:@"RectanglePortNodeShape_topPort"];
	self.rightPort = [aDecoder decodeObjectForKey:@"RectanglePortNodeShape_rightPort"];
	self.bottomPort = [aDecoder decodeObjectForKey:@"RectanglePortNodeShape_bottomPort"];
	self.leftPort.parent = self;
	self.topPort.parent = self;
	self.rightPort.parent = self;
	self.bottomPort.parent = self;
	
	self.strokeColor = [aDecoder decodeObjectForKey:@"RectanglePortNodeShape_strokeColor"];
	self.foreColor = [aDecoder decodeObjectForKey:@"RectanglePortNodeShape_fillColor"];
	self.strokeWidth = [aDecoder decodeObjectForKey:@"RectanglePortNodeShape_strokeWidth"];
	
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.leftPort forKey:@"RectanglePortNodeShape_leftPort"];
	[aCoder encodeObject:self.topPort forKey:@"RectanglePortNodeShape_topPort"];
	[aCoder encodeObject:self.rightPort forKey:@"RectanglePortNodeShape_rightPort"];
	[aCoder encodeObject:self.bottomPort forKey:@"RectanglePortNodeShape_bottomPort"];
	[aCoder encodeObject:self.strokeColor forKey:@"RectanglePortNodeShape_strokeColor"];
	[aCoder encodeObject:self.foreColor forKey:@"RectanglePortNodeShape_fillColor"];
	[aCoder encodeObject:self.strokeWidth forKey:@"RectanglePortNodeShape_strokeWidth"];
}


@end
