//
//  CurvedRectanglePort.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 15/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CurvedRectanglePort.h"


@implementation CurvedRectanglePort

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p
{
	self = [super initWithParent:p];
	self.bounds.width = 50;
	self.bounds.height = 50;
	[self createShapes];
	return self;
}

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r
{
	self= [super initWithParent:p AndBounds:r];
	[self createShapes];
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
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	filledRectangle = [aDecoder decodeObjectForKey:@"CurvedRectanglePort_filledRectangle"];
	outlineRectangle = [aDecoder decodeObjectForKey:@"CurvedRectanglePort_outlineRectangle"];
	color = [aDecoder decodeObjectForKey:@"CurvedRectanglePort_color"];
	outlineColor = [aDecoder decodeObjectForKey:@"CurvedRectanglePort_outlineColor"];
	strokeWidth = [aDecoder decodeObjectForKey:@"CurvedRectanglePort_strokeWidth"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:filledRectangle forKey:@"CurvedRectanglePort_filledRectangle"];
	[aCoder encodeObject:outlineRectangle forKey:@"CurvedRectanglePort_outlineRectangle"];
	[aCoder encodeObject:color forKey:@"CurvedRectanglePort_color"];
	[aCoder encodeObject:outlineColor forKey:@"CurvedRectanglePort_outlineColor"];
	[aCoder encodeObject:strokeWidth forKey:@"CurvedRectanglePort_strokeWidth"];
}

@end
