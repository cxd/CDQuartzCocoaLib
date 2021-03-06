//
//  CDQuartzNode.h
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


#import "CDQuartzGraphHeader.h"

#import "ShapeDelegate.h"
#import "Drawable.h"

#import "AbstractGraphShape.h"
#import "AbstractNodeShape.h"
#import "AbstractConnectorShape.h"

@interface CDQuartzNode : CDNode<QContextModifier,Drawable> {
	/**
	 A shape delegate is used to perform 
	 the drawing of the graphical representation of
	 the vertice.
	 **/
	AbstractNodeShape* shapeDelegate;

}

/**
 A shape delegate is used to perform 
 the drawing of the graphical representation of
 the vertice.
 **/
@property(retain) AbstractNodeShape* shapeDelegate;

/**
 Initialise with user data.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithData:(NSObject *)userData;

/**
 Initialise with a copy of another node.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithCopy:(CDNode *)node;

/**
 Initialise with user data.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithShape:(AbstractNodeShape*) s AndData:(NSObject *)userData;

/**
 Initialise with a copy of another node.
 Create a default shape delegate 
 which will draw a rounded corner rectangle.
 **/
-(id)initWithShape:(AbstractNodeShape*) s AndCopy:(CDNode *)node;

/**
 Dealloc
 **/
-(void)dealloc;

/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context;


/**
 Check whether a point occurs within the bounds
 of this object.
 **/
-(BOOL)isWithinBounds:(QPoint *)point;

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other;

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
