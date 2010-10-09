//
//  EdgeMove.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 20/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "EdgeMove.h"


@implementation EdgeMove

-(id)init {
	self = [super init];
	return self;
}


/**
 Does the operation apply to the current state.
 **/
-(BOOL)appliesTo:(CDGraphViewState *)state
{
	return (!state.shouldDelete) && 
			(!state.isCancelled) && 
			([state.selectEdges count] > 0) &&
			(state.isEditing);
}

/**
 Update the state by moving the tracked nodes.
 **/
-(void)update:(CDGraphViewState *)state
{
	int i = 0;
	for(QPoint *p in state.hoverPoints)
	{
		TrackedEdge *t = [state findTrackedEdge:i];
		if (t.edge != nil)
		{
			[self checkDisconnect:state trackEdge:t atPoint:p];
			AbstractConnectorShape *connector = t.edge.shapeDelegate;
			AbstractGraphShape *decorator = (moveStart) ? 
												connector.startDecoration : 
												connector.endDecoration;
			if (moveStart)
			{
				[connector moveStartTo:p];	
			}
			else {
				[connector moveEndTo:p];	
			}
			//[decorator moveTo:p];
			[self checkConnect:state trackEdge:t atPoint:p];
			state.redraw = YES;
		}
		i++;
	}
}

/**
 Check the edge and determine which element to disconnect it from.
 **/
-(void)checkDisconnect:(CDGraphViewState *)state trackEdge:(TrackedEdge *)t atPoint:(QPoint *)p
{
	moveStart = NO;
	// remove the edge connection from the graph and shift it to the
	// set of partial edges.
	if ((t.edge.source != nil) && 
		(t.edge.target != nil))
	{
		[state.detachedEdges addObject:t.edge];
		// 
		[state.graph disconnect:t.edge.source to:t.edge.target];
	}
	
	// use the minimum absolute distance from the edge shapes to determine which
	// is being edited.
	QPoint* startMid = [t.edge.shapeDelegate.startDecoration.bounds midPoint];
	QPoint* endMid = [t.edge.shapeDelegate.endDecoration.bounds midPoint];
	
	float startDist = [startMid distanceTo:p];
	float endDist = [endMid distanceTo:p];
	
	if (startDist <= endDist)
	{
		// we are moving the start shape delegate.
		moveStart = YES;
		t.edge.source = nil;
	} else {
		moveStart = NO;
		t.edge.target = nil;
	}
}

/**
 After the move check whether the edge can be connected to any connection port available in the graph.
 If it can be connected, attach it.
 If the source and targets are both defined after the port is attached, update the graph.
 **/
-(void)checkConnect:(CDGraphViewState *)state trackEdge:(TrackedEdge *)t atPoint:(QPoint *)p
{
	CDQuartzNode* node = [state.graph findNodeContaining:p];
	if (node == nil)
		return;
	// find the port closest to the point.
	float min = LONG_MAX;
	AbstractPortShape *closest = nil;
	for(AbstractPortShape *port in node.shapeDelegate.ports)
	{
		float dist = sqrt(pow(port.bounds.x - p.x, 2.0f) + pow(port.bounds.y - p.y, 2.0f));
		if (dist < min)
		{
			min = dist;
			closest = port;
		}
	}
	if (closest == nil)
		return;
	
	// reconnect the edge.
	if ((moveStart) && (t.edge.target != nil))
	{
		[state.graph connect:node
						 to: t.edge.target
				  withShape:t.edge.shapeDelegate
				   fromPort:closest
					 toPort:t.edge.shapeDelegate.endPort];
		[state.detachedEdges removeObject:t.edge];
	
	} else if (t.edge.source != nil) {
		[state.graph connect:t.edge.source
						  to: node
				   withShape:t.edge.shapeDelegate
					fromPort:t.edge.shapeDelegate.startPort
					  toPort:closest];
		[state.detachedEdges removeObject:t.edge];	
	} else if (moveStart && t.edge.target == nil) {
		// connect to start only.
		// remain detached.
		t.edge.source = node;
		[t.edge.shapeDelegate connectStartTo:closest];
	} else {
		// connect to end only.
		// remain detached.
		t.edge.target = node;
		[t.edge.shapeDelegate connectEndTo:closest];
	}
}

@end
