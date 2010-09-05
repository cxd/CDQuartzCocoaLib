//
//  GraphLayoutAlgorithm.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 5/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"

@protocol GraphLayoutAlgorithm

@property(assign) float width;
@property(assign) float height;

/**
 Perform the layout algorithm on the supplied graph. 
 **/
-(void)layout:(CDQuartzGraph *)graph;

@end
