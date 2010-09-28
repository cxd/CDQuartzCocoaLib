//
//  TrackedEdge.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 20/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDQuartzEdge.h"


@interface TrackedEdge : NSObject {

	/**
	 Index associated with the edge.
	 **/
	int index;
	
	/**
	 The edge reference.
	 **/
	CDQuartzEdge* edge;
	
}

/**
 Index associated with the edge.
 **/
@property(assign) int index;

/**
 The edge reference.
 **/
@property(retain) CDQuartzEdge* edge;

-(id)init;

-(id)initWithEdge:(CDQuartzEdge *)e atIndex:(int)i;

-(void)dealloc;

@end
