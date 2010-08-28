//
//  CDQuartzGraph.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzGraph.h"


@implementation CDQuartzGraph

@synthesize shapeDelegate;

/**
 Default initialiser
 **/
-(id)init
{
	self = [super init];
	return self;
}

/**
 Initialise the graph with a shape delegate.
 **/
-(id)initWithShape:(AbstractGraphShape*) s
{
	self = [super init];
	self.shapeDelegate = s;
	return self;
}

/**
 Initialise with a copy of the graph.
 For all nodes in the graph generate a
 default shape provider.
 **/
-(id)initWithCopy:(CDGraph *)copy
{
	self = [super init];
	// deep copy all nodes and edges.
	self.isBidirectional = copy.isBidirectional;
	// unvisit all nodes.
	for(CDNode *node in copy.nodes)
	{
		node.visited = NO;
	}	
	// add nodes into the graph.
	for(CDNode *node in copy.nodes)
	{
		CDQuartzNode *qNode = [CDQuartzNode initWithCopy:node];
		[nodes addObject:qNode];
	}
	// connect nodes that are neighbours
	// n^2 operation.
	for(int i=0;i<[copy.nodes count];i++)
	{
		CDNode *from = [copy.nodes objectAtIndex:i];
		CDNode *qFrom = [self findNodeFor:from.data];
		for(int j=0;j<[copy.nodes count];j++)
		{
			CDNode *to = [copy.nodes objectAtIndex:j];
			CDEdge *edge = [copy findEdge:from to:to];
			if (edge != nil)
			{
				// these two nodes are connected.
				CDNode *qTo = [self findNodeFor:to.data];
				[self connect:qFrom to:qTo];
			}
		}
	}
	return self;
}


/**
 Initialise with a copy of the graph.
 For all nodes in the graph generate a
 default shape provider.
 **/
-(id)initWithShape:(AbstractGraphShape*) s AndCopy:(CDGraph *)copy
{
	self = [self initWithCopy:copy];
	self.shapeDelegate = s;
	return self;
}



/**
 release object.
 **/
-(void)dealloc
{
	if (self.shapeDelegate != nil)
	{
	[self.shapeDelegate autorelease];
	self.shapeDelegate = nil;
	}
	[super dealloc];
}


/**
 Add a node to the graph without any
 position information.
 **/
-(CDNode *)add:(NSObject *)objData {
	id node = [[CDQuartzNode alloc] init];
	[node retain];
	[node setData:(id) objData];
	// add it to the array.
	[nodes addObject:node];
	return node;
}

/**
 Connect two nodes graphically.
 If the two supplied nodes are not quartz nodes
 a quartz node will automatically be generated.
 An edge with a default delegate will be created.
 
 The supplied shape will be used to represent the edge.
 
 **/
-(CDEdge *)connect:(CDNode *)fromNode 
				to:(CDNode *)toNode 
		 withShape:(AbstractConnectorShape *)shape
		  fromPort:(AbstractPortShape *)from 
			toPort:(AbstractPortShape*)to
{
	CDQuartzEdge *edge = [self connect: fromNode to:toNode];
	edge.shapeDelegate = shape;
	[edge.shapeDelegate connectStartTo:from];
	[edge.shapeDelegate connectEndTo:to];
	return edge;
}



/**
 Connect two nodes graphically.
 If the two supplied nodes are not quartz nodes
 a quartz node will automatically be generated.
 An edge with a default delegate will be created.
 **/
-(CDEdge *)connect:(CDNode *)fromNode to:(CDNode *)toNode {
	// temporary references.
	CDNode *nodeFrom = fromNode;
	CDNode *nodeTo = toNode;
	if (![[nodeFrom class] isSubclassOfClass:[CDQuartzNode class]])
	{
		nodeFrom = nil;
		nodeFrom = [[CDQuartzNode alloc] initWithCopy:fromNode];
		[self.nodes addObject:nodeFrom];
	}
	if (![[nodeTo class] isSubclassOfClass:[CDQuartzNode class]])
	{
		nodeTo = nil;
		nodeTo = [[CDQuartzNode alloc] initWithCopy:toNode];
		[self.nodes addObject:nodeTo];
	}
	CDQuartzEdge *edge = [[CDQuartzEdge alloc] init];
	[edge retain];
	edge.source = nodeFrom;
	edge.target = nodeTo;
	[edges addObject:(id)edge];
	[nodeFrom addNeighbour:(CDNode *) nodeTo];
	CDEdge* tmp =(CDEdge*) edge;
	if (isBidirectional) {
		edge = [[CDQuartzEdge alloc] init];
		edge.source = nodeTo;
		edge.target = nodeFrom;
		[edges addObject:(id)edge];
		[nodeTo addNeighbour:(CDNode*)nodeFrom];
	}
	return (CDEdge*)tmp;
}

/**
 Change the supplied context.
 Draw all nodes and edges.
 **/
-(void)update:(QContext *)context
{
	if (self.shapeDelegate != nil)
	{
		[self.shapeDelegate update:context];
	}
	for(CDQuartzEdge *edge in self.edges)
	{
		[edge update:context];	
	}
	for(CDQuartzNode *node in self.nodes)
	{
		[node update:context];
	}	
}

/**
 Find the first node that contains the point.
 **/
-(CDQuartzNode *)findNodeContaining:(QPoint *)p
{
	// find a node that is associated with the click event.
	for(CDQuartzNode *node in self.nodes)
	{
		if (node.shapeDelegate == nil)
			continue;
		
		if ([node.shapeDelegate isWithinBounds:p])
		{
			// node is within bounds.
			return node;
		}
	}
	return nil;
}

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(CDQuartzNode *)findIntersectingNode:(QRectangle *)other
{
	// find a node that is associated with the click event.
	for(CDQuartzNode *node in self.nodes)
	{
		if (node.shapeDelegate == nil)
			continue;
		
		if ([node.shapeDelegate intersects:other])
		{
			// node is within bounds.
			return node;
		}
	}
	return nil;	
}

/**
 Move by a relative offset.
 **/
-(void)moveNode:(CDQuartzNode *)node By:(QPoint *)point
{
	if (node == nil) return;
	[node moveBy:point];
	[self updateConnections:node];
}

/**
 Move to an absolute position.
 **/
-(void)moveNode:(CDQuartzNode *)node To:(QPoint *)point
{
	if (node == nil) return;
	[node moveTo:point];
	[self updateConnections:node];
}

/**
 Resize by with and height.
 **/
-(void)resizeNode:(CDQuartzNode *)node ToWidth:(int)w height:(int)h
{
	if (node == nil) return;
	[node resizeToWidth:w height:h];
	[self updateConnections:node];
}

/**
 Update any connections associated with the node.
 **/
-(void)updateConnections:(CDQuartzNode *)node
{
	for(CDQuartzEdge * edge in edges)
	{
		if ([edge.source isEqual:(id)node] || [edge.target isEqual:(id)node])
		{
			[edge updateConnections];		
		}
	}	
}

@end
