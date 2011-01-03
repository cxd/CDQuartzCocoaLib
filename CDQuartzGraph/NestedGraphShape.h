//
//  NestedGraphShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 1/12/10.
//  Copyright 2010 cd. All rights reserved.
//
/**
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 **/

#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"
#import "AbstractGraphShape.h"
#import "CurvedRectangleNode.h"

#define DEFAULT_NESTEDGRAPH_PADDING = 25.0f;

/**
 A nested graph shape describes a shape that contains
 another graph.
 The nested graph shape is a rectangle node that contains 
 another graph within it.
 
 The dimensions of the node are the bounds of the nested graph.
 
 **/
@interface NestedGraphShape : CurvedRectangleNode {
	/**
	 A nested graph.
	 **/
	CDQuartzGraph *nestedGraph;
	/**
	 Value of padding around the graph.
	 **/
	float padding;
}
/**
 A nested graph.
 **/
@property(retain) CDQuartzGraph *nestedGraph;

/**
 Value of padding around the graph.
 **/
@property(assign) float padding;

/**
 Initialise with graph.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g;

/**
 Initialise with graph and label.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g AndLabel:(NSString *)l;

/**
 Initialise with graph and label.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g Padding:(float)p AndLabel:(NSString *)l;

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
