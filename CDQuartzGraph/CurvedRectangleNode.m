//
//  CurvedRectangleNode.m
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

#import "CurvedRectangleNode.h"


@implementation CurvedRectangleNode

/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
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
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super initWithLabel:l];
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
	[super dealloc];
}

-(void)createShapes
{
	self.strokeColor = [[QStrokeColor alloc] initWithQColor:self.outlineColor];
	[self.queue enqueue:self.strokeColor];
	[self.queue enqueue:[[[QLineCap alloc] initWithStyle:QLineCapRounded] autorelease]];
	[self.queue enqueue:[[[QJoinCap alloc] initWithStyle:QJoinCapRounded] autorelease]];
	self.strokeWidth = [[QStrokeWidth alloc] initWidth:self.outlineWeight];
	[self.queue enqueue:self.strokeWidth];
	self.foreColor = [[QFillColor alloc] initWithQColor:self.fillColor];
	[self.queue enqueue:self.foreColor];
	
	self.filledRectangle = [[QFilledCurvedRectangle alloc] initX:self.bounds.x
														Y:self.bounds.y 
													WIDTH:self.bounds.width 
												   HEIGHT:self.bounds.height];
	[self.filledRectangle retain];
	[self.queue enqueue:self.filledRectangle];
	
	self.outlineRectangle = [[QStrokedCurvedRectangle alloc] initX:self.bounds.x 
														  Y:self.bounds.y
													  WIDTH:self.bounds.width 
													 HEIGHT:self.bounds.height];
	[self.outlineRectangle retain];
	[self.queue enqueue:self.outlineRectangle];
}


#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	return self;
}

/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
}

@end
