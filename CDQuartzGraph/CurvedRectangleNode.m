//
//  CurvedRectangleNode.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CurvedRectangleNode.h"


@implementation CurvedRectangleNode


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
	[self createShapes];
	[self createPorts];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super initWithBounds:b];
	[self createShapes];
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
	[self createShapes];
	[self createPorts];
	return self;
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super initWithBounds:b AndLabel:l];
	[self createShapes];
	[self createPorts];
	return self;
}


-(void)dealloc
{
	[filledRectangle autorelease];
	[outlineRectangle autorelease];
	[color autorelease];
	[outlineColor autorelease];
	[strokeWidth autorelease];
	[super dealloc];
}

/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged
{
	strokeWidth.width = self.outlineWeight;	
}

/**
 Event raised when fill color changed.
 **/
-(void)onFillColorChanged
{
	color.red = self.fillColor.red;
	color.blue = self.fillColor.blue;
	color.green = self.fillColor.green;
	color.alpha = self.fillColor.alpha;
}

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged
{
	strokeColor.red = self.outlineColor.red;
	strokeColor.blue = self.outlineColor.blue;
	strokeColor.green = self.outlineColor.green;
	strokeColor.alpha = self.outlineColor.alpha;
}

-(void)createShapes
{
	strokeColor = [[QStrokeColor alloc] initWithQColor:self.outlineColor];
	[self.queue enqueue:strokeColor];
	[self.queue enqueue:[[QLineCap alloc] initWithStyle:QLineCapRounded]];
	[self.queue enqueue:[[QJoinCap alloc] initWithStyle:QJoinCapRounded]];
	strokeWidth = [[QStrokeWidth alloc] initWidth:self.outlineWeight];
	[self.queue enqueue:strokeWidth];
	color = [[QFillColor alloc] initWithQColor:self.fillColor];
	[self.queue enqueue:color];
	
	filledRectangle = [[QFilledRectangle alloc] initX:self.bounds.x
														Y:self.bounds.y 
													WIDTH:self.bounds.width 
												   HEIGHT:self.bounds.height];
	[filledRectangle retain];
	[self.queue enqueue:filledRectangle];
	
	outlineRectangle = [[QStrokedRectangle alloc] initX:self.bounds.x 
														  Y:self.bounds.y
													  WIDTH:self.bounds.width 
													 HEIGHT:self.bounds.height];
	[outlineRectangle retain];
	[self.queue enqueue:outlineRectangle];
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
	[self.ports addObject:self.leftPort];
	
	QRectangle *topB = [[QRectangle alloc] initX:self.bounds.x + self.bounds.width/2.0 - portWidth/2.0
												   Y:self.bounds.y - portWidth/2.0
											   WIDTH:portWidth 
											  HEIGHT:portWidth];
	self.topPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:topB];
	[self.ports addObject:self.topPort];
	
	QRectangle *rightB = [[QRectangle alloc] initX: self.bounds.x + self.bounds.width - portWidth/2.0
													Y: self.bounds.y + self.bounds.height/2.0 - portWidth/2.0
												WIDTH:portWidth
											   HEIGHT:portWidth];
	self.rightPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:rightB];
	[self.ports addObject:self.rightPort];
	
	QRectangle *bottomB = [[QRectangle alloc] initX:self.bounds.x + self.bounds.width/2.0 - portWidth/2.0
												   Y:self.bounds.y + self.bounds.height - portWidth/2.0
											   WIDTH:portWidth 
											  HEIGHT:portWidth];
	self.bottomPort = [[CurvedRectanglePort alloc] initWithParent:self AndBounds:bottomB];
	[self.ports addObject:self.bottomPort];
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	[super moveBy:point];	
	filledRectangle.x = self.bounds.x;
	filledRectangle.y = self.bounds.y;
	outlineRectangle.x = self.bounds.x;
	outlineRectangle.y = self.bounds.y;
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	[super moveTo:point];
	filledRectangle.x = self.bounds.x;
	filledRectangle.y = self.bounds.y;
	outlineRectangle.x = self.bounds.x;
	outlineRectangle.y = self.bounds.y;	
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
	filledRectangle.width = self.bounds.width;
	filledRectangle.height = self.bounds.height;
	outlineRectangle.width = self.bounds.width;
	outlineRectangle.height = self.bounds.height;
	
	// recompute the left, top, right and bottom positions
	// use the midpoints of each port.
	float portWidth = self.leftPort.bounds.width;
	
	float left = self.bounds.x - portWidth/2.0;
	float top = self.bounds.height/2.0 - portWidth/2.0;
	[self.leftPort moveTo:[[QPoint alloc] initX:left Y:top]];
	
	left = self.bounds.x + self.bounds.width/2.0 - portWidth/2.0;
	top = self.bounds.y - portWidth/2.0;
	[self.topPort moveTo:[[QPoint alloc] initX:left Y:top]];
	
	left = self.bounds.x + self.bounds.width - portWidth/2.0;
	top = self.bounds.height/2.0 - portWidth/2.0;
	[self.rightPort moveTo:[[QPoint alloc] initX:left Y:top]];
	
	left = self.bounds.x + self.bounds.width/2.0 - portWidth/2.0;
	top = self.bounds.y + self.bounds.height - portWidth/2.0;
	[self.bottomPort moveTo:[[QPoint alloc] initX:left Y:top]];
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	outlineRectangle = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_outlineRectangle"];
	filledRectangle = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_filledRectangle"];
	strokeColor = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_strokeColor"];
	color = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_color"];
	strokeWidth = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_strokeWidth"];
	self.leftPort=[aDecoder decodeObjectForKey:@"CurvedRectangleNode_leftPort"];
	self.topPort = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_topPort"];
	self.rightPort = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_rightPort"];
	self.bottomPort = [aDecoder decodeObjectForKey:@"CurvedRectangleNode_bottomPort"];
	self.leftPort.parent = self;
	self.topPort.parent = self;
	self.rightPort.parent = self;
	self.bottomPort.parent = self;
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:outlineRectangle forKey:@"CurvedRectangleNode_outlineRectangle"];
	[aCoder encodeObject:filledRectangle forKey:@"CurvedRectangleNode_filledRectangle"];
	[aCoder encodeObject:strokeColor forKey:@"CurvedRectangleNode_strokeColor"];
	[aCoder encodeObject:color forKey:@"CurvedRectangleNode_color"];
	[aCoder encodeObject:strokeWidth forKey:@"CurvedRectangleNode_strokeWidth"];
	[aCoder encodeObject:self.leftPort forKey:@"CurvedRectangleNode_leftPort"];
	[aCoder encodeObject:self.topPort forKey:@"CurvedRectangleNode_topPort"];
	[aCoder encodeObject:self.rightPort forKey:@"CurvedRectangleNode_rightPort"];
	[aCoder encodeObject:self.bottomPort forKey:@"CurvedRectangleNode_bottomPort"];
}

@end
