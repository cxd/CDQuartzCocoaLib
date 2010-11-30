//
//  CDQuartzGraph.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
	[node setData:(id) objData];
	// add it to the array.
	[nodes addObject:node];
	return [node autorelease];
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
	
	if (fromNode == nil || toNode == nil) 
		return nil;
	
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
	edge.source = nodeFrom;
	edge.target = nodeTo;
	[edges addObject:(id)edge];
	[nodeFrom addNeighbour:(CDNode *) nodeTo];
	CDEdge* tmp =(CDEdge*) edge;
	if (isBidirectional) {
		[edge autorelease];
		edge = [[CDQuartzEdge alloc] init];
		edge.source = nodeTo;
		edge.target = nodeFrom;
		[edges addObject:(id)edge];
		[nodeTo addNeighbour:(CDNode*)nodeFrom];
	}
	[edge autorelease];
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
 Find an edge that is contained by the supplied point.
 **/
-(CDQuartzEdge *)findEdgeContaining:(QPoint *)p
{
	for(CDQuartzEdge *edge in self.edges)
	{
		if ([edge.shapeDelegate isWithinBounds:p])
		{
			return edge;	
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

#pragma mark Encoder and Decoder.

/**
 Convert all the neighbours into a persistent edge.
 **/
-(NSMutableArray *)convertNeigboursForEncoding:(CDNode *)node atIndex:(int)n
{
	NSMutableArray *set = [[NSMutableArray alloc] init];
	
	for(CDQuartzNode *next in node.neighbours)
	{
		int i = [self findIndex:next];
		if (i < 0)
			continue;
		CDQuartzEdge *qEdge = [self findEdge:node to:next];
		if (qEdge == nil)
			continue; // should not occur as the nodes are neighbours.
		CDPersistentQuartzEdge *edge = [[CDPersistentQuartzEdge alloc] init];
		edge.sourceIdx = n;
		edge.targetIdx = i;
		edge.edgeShape = qEdge.shapeDelegate;
		[set addObject:edge];
		[edge autorelease];
	}
	[set autorelease];
	return set;
}


/**
 Find the closest port.
 **/
-(AbstractPortShape *)closestPort:(QPoint *)point toNode:(CDQuartzNode *)node
{
	AbstractPortShape *closest = nil;
	float dist = FLT_MAX;
	for(AbstractPortShape *port in node.shapeDelegate.ports)
	{
		float delta = [point distanceTo:[port.bounds midPoint]];
		if (delta < dist) {
			dist = delta;
			closest = port;
		}
	}
	return closest;
}

-(id) initWithCoder: (NSCoder *) decoder 
{
	self.shapeDelegate = [decoder decodeObjectForKey:@"shapeDelegate"];
	self.isBidirectional = [decoder decodeBoolForKey: @"isBidirectional"];
	self.nodes = [[decoder decodeObjectForKey: @"nodes"] retain];
	self.edges = [[NSMutableArray alloc] init];
	NSMutableArray* adjacentSet = [decoder decodeObjectForKey:@"adjacentSet"];
	for(CDPersistentQuartzEdge *p in adjacentSet)
	{
		CDQuartzNode *source = [self.nodes objectAtIndex:p.sourceIdx];
		CDQuartzNode *dest = [self.nodes objectAtIndex:p.targetIdx];
		AbstractConnectorShape* connect= p.edgeShape;
		AbstractPortShape *start = nil, *end = nil;
		// find the closest source port
		if (connect.startPort != nil)
		{
			start = [self closestPort:[connect.startPort.bounds midPoint] toNode:source];
		}
		// find the closest destination port.
		if (connect.endPort != nil) {
			end = [self closestPort:[connect.endPort.bounds midPoint] toNode:dest];	
		}
		// connect the two nodes.
		if (start != nil && end != nil)
		{
			[self connect:source to:dest withShape:connect fromPort:start toPort:end];	
		}
	}
	return self;
}

// NSCoding protocol implementation.
-(void) encodeWithCoder: (NSCoder *) encoder
{
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.shapeDelegate forKey:@"shapeDelegate"];
}

// implementation of NSCopying using archiver to create a deep copy.
-(id)copyWithZone: (NSZone *) zone
{
	NSData *archive = [NSKeyedArchiver archivedDataWithRootObject: self];
	CDQuartzGraph *copy = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	return [copy retain];
}
@end
