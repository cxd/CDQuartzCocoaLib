//
//  EdgeMove.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 20/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QGraphViewOperation.h"

@interface EdgeMove : QGraphViewOperation {

	BOOL moveStart;
}

/**
 Check the edge and determine which element to disconnect it from.
 **/
-(void)checkDisconnect:(CDGraphViewState *)state trackEdge:(TrackedEdge *)t atPoint:(QPoint *)p;


/**
 After the move check whether the edge can be connected to any connection port available in the graph.
 If it can be connected, attach it.
 If the source and targets are both defined after the port is attached, update the graph.
 **/
-(void)checkConnect:(CDGraphViewState *)state trackEdge:(TrackedEdge *)t atPoint:(QPoint *)p;

@end
