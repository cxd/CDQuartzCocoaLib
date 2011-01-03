//
//  CDQuartzGraph.h
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

#import "CDQuartzEdge.h"
#import "CDQuartzNode.h"
#import "CDPersistentQuartzEdge.h"
#import <float.h>


@interface CDQuartzGraph : CDGraph<QContextModifier,Drawable,CDGraphVisitor> {
	/**
	 A shape delegate is used to perform 
	 the drawing of the graphical representation of
	 the vertice.
	 **/
	AbstractGraphShape* shapeDelegate;

	
	/**
	 Used to calculate bounds.
	 **/
	QPoint *minPoint;
	QPoint *maxPoint;
}

/**
 A shape delegate is used to perform 
 the drawing of the graphical representation of
 the vertice.
 **/
@property(retain) AbstractGraphShape* shapeDelegate;


/**
 Default initialiser
 **/
-(id)init;

/**
 Initialise the graph with a shape delegate.
 **/
-(id)initWithShape:(AbstractGraphShape*) s;


/**
 Initialise with a copy of the graph.
 For all nodes in the graph generate a
 default shape provider.
 **/
-(id)initWithCopy:(CDGraph *)copy;

/**
 Initialise with a copy of the graph.
 For all nodes in the graph generate a
 default shape provider.
 **/
-(id)initWithShape:(AbstractGraphShape*) s AndCopy:(CDGraph *)copy;


/**
 Dealloc
 **/
-(void)dealloc;

/**
 Connect the two nodes and use the supplied shape.
 **/
-(CDEdge *)connect:(CDNode *)fromNode 
				to:(CDNode *)toNode 
		 withShape:(AbstractConnectorShape *)shape
		  fromPort:(AbstractPortShape *)from 
			toPort:(AbstractPortShape*)to;
/**
 Change the supplied context.
 **/
-(void)update:(QContext *)context;

/**
 Find the first node that contains the point.
 **/
-(CDQuartzNode *)findNodeContaining:(QPoint *)p;

/**
 Find an edge that is contained by the supplied point.
 **/
-(CDQuartzEdge *)findEdgeContaining:(QPoint *)p;

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(CDQuartzNode *)findIntersectingNode:(QRectangle *)other;

/**
 Move by a relative offset.
 **/
-(void)moveNode:(CDQuartzNode *)node By:(QPoint *)point;

/**
 Move to an absolute position.
 **/
-(void)moveNode:(CDQuartzNode *)node To:(QPoint *)point;

/**
 Move all nodes by a relative distance specified as a point.
 **/
-(void)moveAllNodesBy:(QPoint *)point;

/**
 Resize by with and height.
 **/
-(void)resizeNode:(CDQuartzNode *)node ToWidth:(int)w height:(int)h;

/**
 Update any connections associated with the node.
 **/
-(void)updateConnections:(CDQuartzNode *)node;

/**
 Find the closest port.
 **/
-(AbstractPortShape *)closestPort:(QPoint *)point toNode:(CDQuartzNode *)node;

/**
 Compute the size of the graph.
 **/
-(QRectangle *)computeBounds;

/**
 Vist method used when processing the graph to compute the bounds.
 **/
-(void) visit:(CDNode *) node;

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
