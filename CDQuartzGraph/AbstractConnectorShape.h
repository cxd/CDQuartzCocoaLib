//
//  AbstractConnectorShape.h
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
#import "AbstractGraphShape.h"
#import "ShapeDelegate.h"
#import "AbstractPortShape.h"
#import "CirclePortShape.h"
#import "CurvedRectanglePort.h"

@interface AbstractConnectorShape : AbstractGraphShape {
	/**
	 A shape that is drawn at the start of the connection.
	 **/
	AbstractGraphShape *startDecoration;
	/**
	 A shape that is drawn at the end of the connection.
	 **/
	AbstractGraphShape *endDecoration;
	
	/**
	 A reference to the start port.
	 **/
	AbstractPortShape *startPort;
	
	/**
	A reference to the end port.
	 **/
	AbstractPortShape *endPort;
}

/**
 A shape that is drawn at the start of the connection.
 **/
@property(retain) AbstractGraphShape *startDecoration;
/**
 A shape that is drawn at the end of the connection.
 **/
@property(retain) AbstractGraphShape *endDecoration;

/**
 A reference to the start port.
 **/
@property(retain) AbstractPortShape *startPort;

/**
 A reference to the end port.
 **/
@property(retain) AbstractPortShape *endPort;



/**
 Default initialisation.
 **/
-(id)init;

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l;

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b;

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l;

-(void)dealloc;

/**
 Initialise the line with default bounds.
 Use the diagonal of the bounds to set the key points.
 **/
-(void)initialiseRect:(QRectangle *)b;

/**
 Update Connections.
 **/
-(void)updateConnections;

/**
 Connect the start line to supplied port.
 **/
-(void)connectStartTo:(AbstractPortShape *)port;

/**
 Connect the end line to supplied port.
 **/
-(void)connectEndTo:(AbstractPortShape *)port;


/**
 Move start point by relative amount.
 **/
-(void)moveStartBy:(QPoint *)p;

/**
 Move end point by relative amount.
 **/
-(void)moveEndBy:(QPoint *)p;

/**
 Move start point to absolute point.
 **/
-(void)moveStartTo:(QPoint *)p;

/**
 Move end point to absolute point.
 **/
-(void)moveEndTo:(QPoint *)p;


/**
 Update the context.
 **/
-(void)update:(QContext *)context;

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
