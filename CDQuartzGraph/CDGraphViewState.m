//
//  CDGraphViewState.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/09/10.
//  Copyright 2010 none. All rights reserved.
//

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
	[super dealloc];
}

/**
 Initialise the state transition graph
 **/
-(void)buildTransitions
{
	/*
	 Initialised -> { Select, Add, StartConnections }
	 Select -> { Delete, Move, Cancel }
	 Cancel -> { Initialised }
	 Move -> { Initialise, Move }
	 Delete -> { Cancel, Initialised }
	 Add -> { Cancel, Place }
	 Place -> { Initialised }
	 Join -> { Initialised }
	 Edit -> { Initialised, Cancel }
	 StartConnections -> { Cancel, EdgeSelect }
	 EdgeSelect -> { EdgeMove, Cancel }
	 EdgeMove -> { EdgeMove, Join, Initialise }
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
	
	current = initNode;
	
	/*
	 Initialised -> { Select, Add, StartConnections }
	 */
	[transitions connect:initNode to:selectNode];
	[transitions connect:initNode to:addNode];
	[transitions connect:initNode to:startConnectNode];
	
	/*
	 Select -> { Delete, Move, Cancel, Edit }
	 */
	[transitions connect:selectNode to:deleteNode];
	[transitions connect:selectNode to:moveNode];
	[transitions connect:selectNode to:cancelNode];
	[transitions connect:selectNode to:editNode];
	
	
	/**
	 StartConnections -> { Cancel, EdgeSelect }
	 **/
	[transitions connect:startConnectNode to:cancelNode];
	[transitions connect:startConnectNode to:edgeSelectNode];
	
	/*
	 EdgeSelect -> { Connect, EdgeMove, Cancel }
	 */
	[transitions connect:edgeSelectNode to:cancelNode];
	[transitions connect:edgeSelectNode to:edgeMoveNode];
	
	/*
	 EdgeMove -> { Join, Cancel }
	 */
	[transitions connect:edgeMoveNode to:joinNode];
	[transitions connect:edgeMoveNode to:cancelNode];
	[transitions connect:edgeMoveNode to:edgeMoveNode];
	
	/*
	 Edit -> { Initialised, Cancel }
	 */
	[transitions connect:editNode to:initNode];
	[transitions connect:editNode to:cancelNode];
	
	/*
	 Cancel -> { Initialised }
	 */
	[transitions connect:cancelNode to:initNode];
	
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
		[self.trackNodes addObject:tNode];
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
		
		TrackedEdge *tEdge = [[TrackedEdge alloc] initWithEdge:edge atIndex:i];
		[self.selectEdges addObject:tEdge];
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
	[self.trackPoints addObject:[[QPoint alloc] initX:node.shapeDelegate.bounds.x Y:node.shapeDelegate.bounds.y]];
	self.newNode = node;
	[self updateState];
}

/**
 Update the state.
 **/
-(void)updateState
{
	if (current == nil) return;
	NSString *previous = [current.data className];
	for(CDNode *next in current.neighbours)
	{
		if ([next.data appliesTo:self])
		{
			NSString *nextName = [next.data className];
			current = next;
			[current.data update:self];
			
			NSLog(@"Previous: %@ Next: %@", previous, nextName);
		}
	}
}


@end
