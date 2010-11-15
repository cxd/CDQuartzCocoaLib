//
//  ForceDirectedLayout.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 5/09/10.
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
#import "GraphLayoutAlgorithm.h"


@interface ForceDirectedLayout : NSObject<GraphLayoutAlgorithm> {
	/**
	 Width of area to allow drawing.
	 **/
	float width;
	/**
	 Height of area to allow drawing.
	 **/
	float height;
	/**
	 Number of iterations to perform.
	 **/
	int epochs;
	
	/**
	 Area of the available space divided by the number of vertices in the graph.
	 **/
	float dividedArea;
	
	/**
	 Initial temperature of the system.
	 **/
	float initialTemperature;
}

@property(assign) float width;
@property(assign) float height;

/**
 Initialise with prior conditions.
 Width, Height and number of Epochs.
 **/
-(id)initWidth:(float)w Height:(float)h Epochs:(int)e Temperature:(float)t;

-(void)dealloc;

/**
 Perform the layout algorithm on the supplied graph. 
 **/
-(void)layout:(CDQuartzGraph *)graph;

/**
 Calculate the attractive force
 **/
-(float)attract:(float)dist;

/**
 Calculate the repulsive force.
 **/
-(float)repulse:(float)dist;

/**
 The minimum of two values.
 **/
-(float)min:(float)a And:(float)b;

/**
 The maximum of two values.
 **/
-(float)max:(float)a And:(float)b;

@end
