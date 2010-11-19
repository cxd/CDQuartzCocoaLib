//
//  EdgeMove.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 20/09/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
			if (moveStart)
			{
				[connector moveStartTo:p];	
			}
			else {
				[connector moveEndTo:p];	
			}
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
