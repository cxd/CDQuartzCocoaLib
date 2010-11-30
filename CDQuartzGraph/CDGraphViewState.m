//
//  CDGraphViewState.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/09/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#import "CDGraphViewState.h"
#import "CDGraphViewOperation.h"
#import "Add.h"
#import "Cancel.h"
#import "Connect.h"
#import "Delete.h"
#import "Initialise.h"
#import "Join.h"
#import "Move.h"
#import "Place.h"
#import "Select.h"
#import "Edit.h"
#import "EdgeSelect.h"
#import "EdgeMove.h"
#import "StartConnections.h"
#import "EdgeDelete.h"

@implementation CDGraphViewState


@synthesize graph;
@synthesize trackNodes;
@synthesize algorithm;
@synthesize isCancelled;
@synthesize newNode;
@synthesize shouldDelete;
@synthesize trackPoints;
@synthesize bounds;
@synthesize redraw;
@synthesize hoverPoints;
@synthesize selectEdges;
@synthesize editConnections;
@synthesize detachedEdges;
@synthesize isEditing;
@synthesize selectLabel;
@synthesize editDelegate;
@synthesize lock;

-(id)initWithBounds:(QRectangle *)b
{
	self = [super init];
	self.bounds = b;
	self.graph = [[CDQuartzGraph alloc] init];
	self.trackNodes = [[NSMutableArray alloc] init];
	self.trackPoints = [[NSMutableArray alloc] init];
	self.hoverPoints = [[NSMutableArray alloc] init];
	self.selectEdges = [[NSMutableArray alloc] init];
	self.detachedEdges = [[NSMutableArray alloc] init];
	self.lock = [[NSLock alloc] init];
	[self buildTransitions];
	return self;
}

/**
 Initialise with the graph instance and the bounds of the visible area.
 **/
-(id)initWithGraph:(CDQuartzGraph *)g andBounds:(QRectangle *)b
{
	self = [super init];
	self.graph = g;
	self.bounds = b;
	self.trackNodes = [[NSMutableArray alloc] init];
	self.trackPoints = [[NSMutableArray alloc] init];
	self.hoverPoints = [[NSMutableArray alloc] init];
	self.selectEdges = [[NSMutableArray alloc] init];
	self.detachedEdges = [[NSMutableArray alloc] init];
	self.lock = [[NSLock alloc] init];
	[self buildTransitions];
	return self;	
}


-(void)dealloc
{
	if (self.trackNodes != nil)
	{
		[self.trackNodes removeAllObjects];
		[self.trackNodes autorelease];	
	}
	[self.graph autorelease];
	if (self.algorithm != nil)
	{
		[self.algorithm autorelease];	
	}
	if (self.newNode != nil)
	{
		[self.newNode autorelease];	
	}
	if (self.trackPoints != nil)
	{
		[self.trackPoints removeAllObjects];
		[self.trackPoints autorelease];
	}
	if (self.hoverPoints != nil)
	{
		[self.hoverPoints removeAllObjects];
		[self.hoverPoints autorelease];	
	}
	if (self.selectEdges != nil)
	{
		[self.selectEdges removeAllObjects];
		[self.selectEdges autorelease];
	}
	if (self.detachedEdges != nil)
	{
		[self.detachedEdges removeAllObjects];
		[self.detachedEdges autorelease];
	}
	[transitions autorelease];
	[self.lock autorelease];
	self.editDelegate = nil; // remove weak reference.
	[super dealloc];
}

/**
 Initialise the state transition graph
 **/
-(void)buildTransitions
{
	/*
	 Initialised -> { Select, Add, Delete, StartConnections }
	 Select -> { Move, Cancel, Edit }
	 Cancel -> { Initialised, Edit }
	 Move -> { Initialise, Move }
	 Delete -> { Cancel, Initialised }
	 Add -> { Cancel, Place }
	 Place -> { Initialised }
	 Join -> { Initialised }
	 Edit -> { Edit, Initialised, Cancel }
	 StartConnections -> { Cancel, EdgeSelect, EdgeDelete }
	 EdgeSelect -> { EdgeMove, Cancel }
	 EdgeMove -> { EdgeMove, Join, Initialise, EdgeSelect }
	 EdgeDelete -> { Initialised }
	 */
	transitions = [[CDGraph alloc] init];
	Initialise *init = [[Initialise alloc] init];
	Select *select = [[Select alloc] init];
	Cancel *cancel = [[Cancel alloc] init];
	Move *move = [[Move alloc] init];
	Delete *delete = [[Delete alloc] init];
	Add *add = [[Add alloc] init];
	Place *place = [[Place alloc] init];
	Join *join = [[Join alloc] init];
	Edit *edit = [[Edit alloc] init];
	StartConnections *startConnect = [[StartConnections alloc] init];
	EdgeSelect *edgeSelect = [[EdgeSelect alloc] init];
	EdgeMove *edgeMove = [[EdgeMove alloc] init];
	EdgeDelete *edgeDelete = [[EdgeDelete alloc] init];
	
	CDNode *initNode = [transitions add:init];
	CDNode *selectNode = [transitions add:select];
	CDNode *cancelNode = [transitions add:cancel];
	CDNode *moveNode = [transitions add:move];
	CDNode *deleteNode = [transitions add:delete];
	CDNode *addNode = [transitions add:add];
	CDNode *placeNode = [transitions add:place];
	CDNode *joinNode = [transitions add:join];
	CDNode *editNode = [transitions add:edit];
	CDNode *startConnectNode = [transitions add:startConnect];
	CDNode *edgeSelectNode = [transitions add:edgeSelect];
	CDNode *edgeMoveNode = [transitions add:edgeMove];
	CDNode *edgeDeleteNode = [transitions add:edgeDelete];
	
	[init autorelease];
	[select autorelease];
	[cancel autorelease];
	[move autorelease];
	[delete autorelease];
	[add autorelease];
	[place autorelease];
	[join autorelease];
	[edit autorelease];
	[startConnect autorelease];
	[edgeSelect autorelease];
	[edgeMove autorelease];
	[edgeDelete autorelease];
	
	current = initNode;
	
	/*
	 Initialised -> { Select, Add, StartConnections }
	 */
	[transitions connect:initNode to:selectNode];
	[transitions connect:initNode to:addNode];
	[transitions connect:initNode to:startConnectNode];
	[transitions connect:initNode to:deleteNode];
	
	/*
	 Select -> { Move, Cancel, Edit }
	 */
	[transitions connect:selectNode to:moveNode];
	[transitions connect:selectNode to:cancelNode];
	[transitions connect:selectNode to:editNode];
	
	
	/**
	 StartConnections -> { Cancel, EdgeSelect, EdgeDelete }
	 **/
	[transitions connect:startConnectNode to:cancelNode];
	[transitions connect:startConnectNode to:edgeSelectNode];
	
	/*
	 EdgeSelect -> { Connect, EdgeMove, Cancel, EdgeDelete }
	 */
	[transitions connect:edgeSelectNode to:cancelNode];
	[transitions connect:edgeSelectNode to:edgeMoveNode];
	[transitions connect:edgeSelectNode to:edgeDeleteNode];
	[transitions connect:edgeSelectNode to: edgeSelectNode];
	
	/*
	 EdgeMove -> { Join, Cancel, EdgeMove, EdgeSelect }
	 */
	[transitions connect:edgeMoveNode to:joinNode];
	[transitions connect:edgeMoveNode to:cancelNode];
	[transitions connect:edgeMoveNode to:edgeMoveNode];
	
	/**
	 EdgeDelete -> { Initialised }
	 **/
	[transitions connect:edgeDeleteNode to:initNode];
	
	/*
	 Edit -> { Edit, Initialised, Cancel }
	 */
	[transitions connect:editNode to:initNode];
	[transitions connect:editNode to:cancelNode];
	[transitions connect:editNode to:editNode];
	
	/*
	 Cancel -> { Initialised, Edit }
	 */
	[transitions connect:cancelNode to:initNode];
	[transitions connect:cancelNode to:editNode];
	
	/*
	 Move -> { Join, Initialise, Move, Cancel }
	 */
	[transitions connect:moveNode to:initNode];
	[transitions connect:moveNode to:moveNode];
	[transitions connect:moveNode to:selectNode];

	 /*
	  Delete -> { Cancel, Initialised }
	 */
	[transitions connect:deleteNode to:cancelNode];
	[transitions connect:deleteNode to:initNode];
	
	/*
	Add -> { Cancel, Place }
	*/
	[transitions connect:addNode to:cancelNode];
	[transitions connect:addNode to:placeNode];
	
	/*
	 Place -> { Initialised }
	 */
	[transitions connect:placeNode to:initNode];
	/*
	 Join -> { Initialised }
	 */
	[transitions connect:joinNode to:initNode];
}


/**
 Find the tracked node associated with the index.
 **/
-(TrackedNode *)findNode:(int)idx
{
	for(TrackedNode *t in self.trackNodes)
	{
		if (t.index == idx) return t;	
	}
	return nil;
}

/**
 Find the tracked edge associated with the index.
 **/
-(TrackedEdge *)findTrackedEdge:(int)idx
{
	for(TrackedEdge *e in self.selectEdges)
	{
		if (e.index == idx) return e;		
	}
	return nil;
}

/**
 Search for and identify tracking nodes against the set of points.
 **/
-(void)searchForTrackingNodes
{
	[self.trackNodes removeAllObjects];
	int i = 0;
	for(QPoint *p in self.trackPoints)
	{
		// find a node that is associated with the click event.
		CDQuartzNode* node = [self.graph findNodeContaining:p];
		TrackedNode *tNode = [[TrackedNode alloc] initWithNode:node atIndex:i];
		[self.trackNodes addObject:[tNode autorelease]];
		i++;
	}
}

/**
 Find the set of edges that exist within the range
 of the points used to hover over the edge shapes.
 **/
-(void)searchForTrackingEdges
{
	[self.selectEdges removeAllObjects];
	int i = 0;
	for(QPoint *p in self.hoverPoints)
	{
		CDQuartzEdge *edge = [self.graph findEdgeContaining:p];
		if (edge == nil)
		{
			// check detached edges.
			for(CDQuartzEdge *detached in self.detachedEdges)
			{
				if ([detached.shapeDelegate isWithinBounds:p])
				{
				edge = detached;	
				}
			}
		}
		if (edge != nil)
		{
			TrackedEdge *tEdge = [[TrackedEdge alloc] initWithEdge:edge atIndex:i];
			[self.selectEdges addObject:[tEdge autorelease]];
		}
		i++;
	}
}

/**
 Hover over shapes in the collection.
 **/
-(void)hoverShapes:(NSMutableArray *)points
{
	[self.hoverPoints removeAllObjects];
	[self.hoverPoints addObjectsFromArray:points];
	[self updateState];
}

/**
 Update the state with the selection of points
 **/
-(void)trackShapes:(NSMutableArray*)points andDelete:(BOOL)flag
{
	[self.trackPoints removeAllObjects];
	[self.trackPoints addObjectsFromArray:points];
	self.shouldDelete = flag;
	[self updateState];
}

/**
 Cancel the current operation if possible.
 **/
-(void)cancelOperation:(BOOL)cancelFlag
{
	self.isCancelled = cancelFlag;
	[self updateState];
}

/**
 Add a new graph node to the state.
 **/
-(void)addNode:(CDQuartzNode *)node
{
	[self.trackPoints removeAllObjects];
	[self.trackPoints addObject:[[[QPoint alloc] initX:node.shapeDelegate.bounds.x Y:node.shapeDelegate.bounds.y] autorelease]];
	self.newNode = node;
	[self updateState];
}

/**
 Update the state.
 **/
-(void)updateState
{
	if (current == nil) return;
#ifdef UIKIT_EXTERN
	
	NSString *previous = NSStringFromClass([self class]);
#else
	NSString *previous = [current.data className];
#endif
	for(CDNode *next in current.neighbours)
	{
		if ([next.data appliesTo:self])
		{
#ifdef UIKIT_EXTERN
			NSString *nextName = NSStringFromClass([next.data class]);
#else
			NSString *nextName = [next.data className];
#endif
			current = next;
			[current.data update:self];
			
			NSLog(@"Previous: %@ Next: %@", previous, nextName);
		}
	}
}

/**
 Compute the bounds for the graph based on the current rectangle.
 **/
-(QRectangle *)computeBounds:(QRectangle *)curRect
{
	if (minPoint != nil)
	{
		[minPoint autorelease];	
	}
	if (maxPoint != nil)
	{
		[maxPoint autorelease];	
	}
	minPoint = [[QPoint alloc] initX:MAXFLOAT Y:MAXFLOAT];
	maxPoint = [[QPoint alloc] initX:-1.0f*MAXFLOAT Y:-1.0f*MAXFLOAT]; 
	// visit nodes and calculate the bounds.
	CDGraphTraversal *traversal = [[CDGraphTraversal alloc] init];
	[traversal traverse:self graphInstance:self.graph];
	[traversal autorelease];
	return [[[QRectangle alloc] initX:minPoint.x 
								   Y:minPoint.y 
							   WIDTH:[minPoint horizontalDistanceTo:maxPoint] 
							  HEIGHT:[minPoint verticalDistanceTo:maxPoint]] autorelease];
}


/**
 Vist method used when processing the graph to compute the bounds.
 **/
-(void) visit:(CDNode *) node
{
	CDQuartzNode* qNode = (CDQuartzNode *)node;
	if (qNode.shapeDelegate == nil)
		return;
	
	if (qNode.shapeDelegate.bounds.x < minPoint.x)
	{
		minPoint.x = qNode.shapeDelegate.bounds.x;	
	} else if (qNode.shapeDelegate.bounds.x + qNode.shapeDelegate.bounds.width > maxPoint.x) {
		maxPoint.x = qNode.shapeDelegate.bounds.x + qNode.shapeDelegate.bounds.width;	
	}
	if (qNode.shapeDelegate.bounds.y < minPoint.y)
	{
		minPoint.y = qNode.shapeDelegate.bounds.y;	
	} else if (qNode.shapeDelegate.bounds.y + qNode.shapeDelegate.bounds.height > maxPoint.y) {
		maxPoint.y = qNode.shapeDelegate.bounds.y + qNode.shapeDelegate.bounds.height;
	}
}

@end
