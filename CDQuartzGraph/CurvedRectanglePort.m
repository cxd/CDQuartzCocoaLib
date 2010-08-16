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
	[self createShape];
	return self;
}

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r
{
	self= [super initWithParent:p AndBounds:r];
	[self createShape];
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

-(void)createShape
{
	strokeColor = [[QStrokeColor alloc] initWithQColor:self.outlineColor];
	[self.queue enqueue:strokeColor];
	[self.queue enqueue:[[QLineCap alloc] initWithStyle:QLineCapRounded]];
	[self.queue enqueue:[[QJoinCap alloc] initWithStyle:QJoinCapRounded]];
	strokeWidth = [[QStrokeWidth alloc] initWidth:self.outlineWeight];
	[self.queue enqueue:strokeWidth];
	color = [[QFillColor alloc] initWithQColor:self.fillColor];
	[self.queue enqueue:color];
	
	filledRectangle = [[QFilledRectangle alloc] initWithX:self.bounds.x
																Y:self.bounds.y 
															WIDTH:self.bounds.width 
														   HEIGHT:self.bounds.height];
	[filledRectangle retain];
	[self.queue enqueue:filledRectangle];
	
	outlineRectangle = [[QStrokedRectangle alloc] initWithX:self.bounds.x 
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

@end
