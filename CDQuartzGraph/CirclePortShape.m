//
//  CirclePortShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 25/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CirclePortShape.h"


@implementation CirclePortShape


/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p
{
	self = [super initWithParent:p];
	self.bounds.width = 5;
	self.bounds.height = 5;
	[self createShapes];
	return self;
}

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r
{
	self = [super initWithParent:p AndBounds:r];
	[self createShapes];
	return self;
}

-(void)dealloc
{
	[fillColor autorelease];
	[strokeColor autorelease];
	[filledCircle autorelease];
	[outlineArc autorelease];
	[strokeWidth autorelease];
	[super dealloc];
}


-(void)createShapes
{
	QPoint *centre = [[QPoint alloc] initX:self.bounds.x + self.bounds.width/2 Y:self.bounds.y + self.bounds.height/2];
	fillColor = [[QFillColor alloc]initWithRGB:1 G:1 B:1];
	strokeColor = [[QStrokeColor alloc] initWithRGB:0 G:0 B:0];
	filledCircle = [[QArc alloc] initWithCentre: centre
										 Radius:self.bounds.width
									 StartAngle:0.0 
									   EndAngle:360.0
										  START:YES 
											END:YES 
									  CLOCKWISE:YES];
	outlineArc = [[QArc alloc] initWithCentre: centre
									   Radius:self.bounds.width
								   StartAngle:0.0 
									 EndAngle:360.0
										START:YES 
										  END:YES 
									CLOCKWISE:YES];
	strokeWidth = [[QStrokeWidth alloc] initWidth:1.0f];
	[self.queue enqueue:fillColor];
	[self.queue enqueue:filledCircle];
	[self.queue enqueue:[[QFillPath alloc] init]];
	
	[self.queue enqueue:strokeColor];
	[self.queue enqueue:strokeWidth];
	[self.queue enqueue:outlineArc];
	[self.queue enqueue:[[QStrokePath alloc] init]];
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

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	[super moveBy:point];
	QPoint *centre = [[QPoint alloc] initX:self.bounds.x + self.bounds.width/2 Y:self.bounds.y + self.bounds.height/2];
	filledCircle.centre = centre;
	outlineArc.centre = centre;
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	[super moveTo:point];
	QPoint *centre = [[QPoint alloc] initX:self.bounds.x + self.bounds.width/2 Y:self.bounds.y + self.bounds.height/2];
	filledCircle.centre = centre;
	outlineArc.centre = centre;
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	[super resizeToWidth:w height:h];
	QPoint *centre = [[QPoint alloc] initX:self.bounds.x + self.bounds.width/2 Y:self.bounds.y + self.bounds.height/2];
	filledCircle.centre = centre;
	outlineArc.centre = centre;
	filledCircle.radius = w;
	outlineArc.radius = w;
}

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	fillColor = [aDecoder decodeObjectForKey:@"CirclePortShape_fillColor"];
	strokeColor = [aDecoder decodeObjectForKey:@"CirclePortShape_strokeColor"];
	filledCircle = [aDecoder decodeObjectForKey:@"CirclePortShape_filledCircle"];
	outlineArc = [aDecoder decodeObjectForKey:@"CirclePortShape_outlineArc"];
	strokeWidth = [aDecoder decodeObjectForKey:@"CirclePortShape_strokeWidth"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:fillColor forKey:@"CirclePortShape_fillColor"];
	[aCoder encodeObject:strokeColor forKey:@"CirclePortShape_strokeColor"];
	[aCoder encodeObject:filledCircle forKey:@"CirclePortShape_filledCircle"];
	[aCoder encodeObject:outlineArc forKey:@"CirclePortShape_outlineArc"];
	[aCoder encodeObject:strokeWidth forKey:@"CirclePortShape_strokeWidth"];
}
@end
