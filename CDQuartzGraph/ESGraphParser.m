//
//  ESGraphParser.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 12/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "ESGraphParser.h"


@implementation ESGraphParser

@synthesize builder;
@synthesize result;
@synthesize graph;

-(id)initWithGraph:(CDQuartzGraph *)g
{
	self = [super init];
	self.graph = g;
	
	return self;
}


-(void)dealloc
{
	self.builder = nil;
	self.result = nil;
	self.graph = nil;
	[super dealloc];
}


-(NSString *)parse
{
	self.builder = [[NSMutableString alloc] init];
	self.result = nil;

	[self.builder appendString:@"{\n\n"];
	[self.builder appendString:@"\"nodes\": [\n"];
	// process individual shapes.
	int i = 0;
	for(CDQuartzNode* node in self.graph.nodes) {
	// process shapes.	
		[self processShape:node];
		i++;
		if (i < [self.graph.nodes count])
		{
			[self.builder appendString:@","];	
		}
	}
	[self.builder appendString:@"],\n\n"];
	
	[self.builder appendString:@"\"edges\": [\n"];
	
	i=0;
	for(CDQuartzEdge* edge in self.graph.edges) {
		[self processEdge:edge];
		i++;
		if (i < [self.graph.edges count])
		{
			[self.builder appendString:@","];	
		}
	}
	
	[self.builder appendString:@"]\n\n"];
	
	[self.builder appendString:@"}\n"];
	
	self.result = [NSString stringWithString:self.builder];
	
	return self.result;
}



/**
 Append the node description for each node in the graph.
 
 Example:
 
 {
 "node": "Seagull",
 "shape": "ELLIPSE",
 "x": "200.0",
 "y": "550.0",
 "width": "100",
 "height": "50",
 "color": "rgb(1.0, 1.0, 0.0)",
 "outlineColor": "rgb(0.0, 0.0, 0.0)",
 "outlineWeight":"1.0"
 }
 
 
 **/
-(void)processShape:(CDQuartzNode*) node
{
	NSString *nodeName = nil;
	NSString *labelText = nil;
	NSString *shape = nil;
	NSString *xPos = nil;
	NSString *yPos = nil;
	NSString *width = nil;
	NSString *height = nil;
	NSString *color = nil;
	NSString *outlineColor = nil;
	NSString *outlineWeight = nil;
	
	if ((node.data != nil) && ([[node.data class] isSubclassOfClass:[NSString class]]))
	{
		nodeName = node.data;
	} else if ((node.shapeDelegate != nil) && (node.shapeDelegate.label != nil) && 
			   ([node.shapeDelegate.label compare:@""] != NSOrderedSame)) {
		nodeName = node.shapeDelegate.label;
	} else {
		// don't add the node.
		return;	
	}
	
	if ((node.shapeDelegate != nil) && (node.shapeDelegate.label != nil) && 
		([node.shapeDelegate.label compare:@""] != NSOrderedSame)) {
		labelText = node.shapeDelegate.label;
	} else {
		labelText = nodeName;	
	}
	
	if (node.shapeDelegate != nil) {
		shape = [self shapeNameForShapeClass:node.shapeDelegate];
		xPos = [[NSNumber numberWithFloat:node.shapeDelegate.bounds.x] stringValue];
		yPos = [[NSNumber numberWithFloat:node.shapeDelegate.bounds.y] stringValue];
		width = [[NSNumber numberWithFloat:node.shapeDelegate.bounds.width] stringValue];
		height = [[NSNumber numberWithFloat:node.shapeDelegate.bounds.height] stringValue];
		NSMutableString *colorString = [[NSMutableString alloc] init];
		
		[colorString appendString:@"rgba("];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.fillColor.red] stringValue]];
		[colorString appendString:@","];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.fillColor.green] stringValue]];
		[colorString appendString:@","];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.fillColor.blue] stringValue]];
		[colorString appendString:@","];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.fillColor.alpha] stringValue]];
		[colorString appendString:@")"];
		
		color = [NSString stringWithString: colorString];
		
		[colorString autorelease];
		
		colorString = [[NSMutableString alloc] init];
		[colorString appendString:@"rgba("];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.outlineColor.red] stringValue]];
		[colorString appendString:@","];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.outlineColor.green] stringValue]];
		[colorString appendString:@","];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.outlineColor.blue] stringValue]];
		[colorString appendString:@","];
		[colorString appendString:
		 [[NSNumber numberWithFloat:node.shapeDelegate.outlineColor.alpha] stringValue]];
		[colorString appendString:@")"];
		
		outlineColor = [NSString stringWithString:colorString];
		
		[colorString autorelease];
		
		outlineWeight = [[NSNumber numberWithFloat:node.shapeDelegate.outlineWeight] stringValue];
		
		
	} else {
	// default shape.
		shape = @"RECT";
		xPos = @"10";
		yPos = @"10";
		width = @"100";
		height = @"50";
		color = @"rgb(1.0, 1.0, 1.0)";
		outlineColor = @"rgb(0.0, 0.0, 0.0)";
		outlineWeight = @"1.0";
	}
	
	[self.builder appendString:@"{\n"];
	
	[self.builder appendString:@"\"node\":"];
	[self.builder appendFormat:@"\"%@\",\n", labelText];
	
	
	[self.builder appendString:@"\"shape\":"];
	[self.builder appendFormat:@"\"%@\",\n", shape];
	
	[self.builder appendString:@"\"x\":"];
	[self.builder appendFormat:@"\"%@\",\n", xPos];
	
	
	[self.builder appendString:@"\"y\":"];
	[self.builder appendFormat:@"\"%@\",\n", yPos];
	
	[self.builder appendString:@"\"width\":"];
	[self.builder appendFormat:@"\"%@\",\n", width];
	
	[self.builder appendString:@"\"height\":"];
	[self.builder appendFormat:@"\"%@\",\n", height];
	
	[self.builder appendString:@"\"color\":"];
	[self.builder appendFormat:@"\"%@\",\n", color];
	
	
	[self.builder appendString:@"\"outlineColor\":"];
	[self.builder appendFormat:@"\"%@\",\n", outlineColor];
	
	[self.builder appendString:@"\"outlineWeight\":"];
	[self.builder appendFormat:@"\"%@\"\n", outlineWeight];
	
	
	[self.builder appendString:@"}"];
	
}

/**
 Add an edge description for each edge in the graph.
 
 Example:
 
 {
 "from": "Mammals",
 "to": "Whale" 
 },
 
 **/
-(void)processEdge:(CDQuartzEdge *)edge
{
	CDQuartzNode* from = edge.source;
	CDQuartzNode* to = edge.target;
	
	NSString* fromName;
	NSString* toName;
	
	if ((from.data != nil) && ([[from.data class] isSubclassOfClass:[NSString class]]))
	{
		fromName = from.data;
	} 
	if ((from.shapeDelegate != nil) && (from.shapeDelegate.label != nil) && 
			   ([from.shapeDelegate.label compare:@""] != NSOrderedSame)) {
		fromName = from.shapeDelegate.label;
	} else {
		// don't add the node.
		return;	
	}
	
	
	if ((to.data != nil) && ([[to.data class] isSubclassOfClass:[NSString class]]))
	{
		toName = to.data;
	} 
	if ((to.shapeDelegate != nil) && (to.shapeDelegate.label != nil) && 
		([to.shapeDelegate.label compare:@""] != NSOrderedSame)) {
		toName = to.shapeDelegate.label;
	} else {
		// don't add the node.
		return;	
	}
	
	
	[self.builder appendString:@"{"];
	
	[self.builder appendString:@"\"from\":"];
	[self.builder appendFormat:@"\"%@\",\n", fromName];
	
	
	[self.builder appendString:@"\"to\":"];
	[self.builder appendFormat:@"\"%@\"\n", toName];
	
	
	[self.builder appendString:@"}"];
	
	[fromName autorelease];
	[toName autorelease];
	
}

/**
 Determine the shape name for the supplied shape class.
 **/
-(NSString *)shapeNameForShapeClass:(AbstractNodeShape *)shape
{
	if ([[shape class] isSubclassOfClass:[CircleNode class]])
	{
	return @"CIRCLE";	
	}
	if ([[shape class] isSubclassOfClass:[EllipseNode class]]) {
	return @"ELLIPSE";	
	}
	if ([[shape class] isSubclassOfClass:[RectangleNode class]]) {
	return @"RECT";	
	}
	if ([[shape class] isSubclassOfClass:[CurvedRectangleNode class]]) {
	return @"CURVED_RECT";	
	}
	// default is rect
	return @"RECT";
	
}




@end
