//
//  CurvedRectanglePort.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 15/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
	[self.queue enqueue:[[[QLineCap alloc] initWithStyle:QLineCapRounded] autorelease]];
	[self.queue enqueue:[[[QJoinCap alloc] initWithStyle:QJoinCapRounded] autorelease]];
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
