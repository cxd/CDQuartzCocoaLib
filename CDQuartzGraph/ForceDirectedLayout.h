//
//  ForceDirectedLayout.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 5/09/10.
//  Copyright 2010 none. All rights reserved.
//

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
