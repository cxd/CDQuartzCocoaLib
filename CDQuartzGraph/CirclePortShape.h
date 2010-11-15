//
//  CirclePortShape.h
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

#import "CDQuartzGraphHeader.h"
#import "AbstractGraphShape.h"
#import "ShapeDelegate.h"
#import "AbstractPortShape.h"

@interface CirclePortShape : AbstractPortShape {
	QArc *outlineArc;
	QArc *filledCircle;
	QStrokeColor *strokeColor;
	QFillColor *color;
	QStrokeWidth *strokeWidth;
}


/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p;

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r;

-(void)createShapes;
/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged;

/**
 Event raised when fill color changed.
 **/
-(void)onFillColorChanged;

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged;

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point;

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point;

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h; 

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder;
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
