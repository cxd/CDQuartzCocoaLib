//
//  CirclePortShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 25/09/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
	[centre autorelease];
	strokeWidth = [[QStrokeWidth alloc] initWidth:1.0f];
	[self.queue enqueue:fillColor];
	[self.queue enqueue:filledCircle];
	[self.queue enqueue:[[[QFillPath alloc] init] autorelease]];
	
	[self.queue enqueue:strokeColor];
	[self.queue enqueue:strokeWidth];
	[self.queue enqueue:outlineArc];
	[self.queue enqueue:[[[QStrokePath alloc] init] autorelease]];
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
	[centre autorelease];
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
	[centre autorelease];
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
	[centre autorelease];
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
