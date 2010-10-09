//
//  CDGraphView.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 22/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDGraphView.h"


@implementation CDGraphView


@synthesize graph;
@synthesize algorithm;
@synthesize shouldDelete;
@synthesize state;
@synthesize queue;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.graph = [[CDQuartzGraph alloc] init];
		self.state = [[CDGraphViewState alloc] initWithGraph:self.graph 
												   andBounds:[[QRectangle alloc] initX:[self frame].origin.x
																					 Y:[self frame].origin.y
																				 WIDTH:[self frame].size.width
																				HEIGHT:[self frame].size.height]];
	}
    return self;
}


-(void)awakeFromNib
{
	[super awakeFromNib];
	self.graph = [[CDQuartzGraph alloc] init];
	self.state = [[CDGraphViewState alloc] initWithGraph:self.graph 
											   andBounds:[[QRectangle alloc] initX:[self frame].origin.x
																				 Y:[self frame].origin.y
																			 WIDTH:[self frame].size.width
																			HEIGHT:[self frame].size.height]];
}



-(void)dealloc
{
	[self.graph autorelease];
	if (self.algorithm != nil)
	{
		[self.algorithm autorelease];	
	}
	if (self.state != nil)
	{
		[self.state autorelease];	
	}
	if (self.queue != nil)
	{
		[self.queue autorelease];	
	}
	[super dealloc];
}

/**
 Derived classes should override this method
 if they need to do any custom drawing before the base class.
 **/
- (void)drawRect:(NSRect)dirtyRect {
    // a context reference.
	// contexts can reference any type of graphics context.
	QContext *context = [[QContext alloc] initWithContext:[[NSGraphicsContext currentContext] graphicsPort]];
	[context retain];
	if (self.queue == nil)
	{
		self.queue = [[QModifierQueue alloc] init];
		[self.queue retain];
		[self.queue enqueue:[self createGraph]];
	}
	
	if ((self.algorithm != nil) && (!self.state.isEditing) && (!self.state.editConnections))
	{
		self.algorithm.width = [self frame].size.width;
		self.algorithm.height = [self frame].size.height;
		[self.algorithm layout:self.graph];
	}
	
	
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:self.queue];
	[self.queue autorelease];
	self.queue = copy;
	[context release];
	
	// update any detached edges.
	for(CDQuartzEdge *edge in self.state.detachedEdges)
	{
		[edge.shapeDelegate update:context];
	}
}

/**
 The method used to create the initial graph by the view.
 Override this method in derived classes in order to generate
 the default graph.
 **/
-(CDQuartzGraph *)createGraph
{
	return self.graph;
}


-(void)mouseDown:(NSEvent *)event
{
   
	NSPoint clickLocation;
   
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
							  fromView:nil];
	
	float x = (float)clickLocation.x;
	float y = (float)clickLocation.y;
   	
	QPoint *p = [[QPoint alloc] init];
	p.x = x;
	p.y = y;
	
	self.state.isEditing = YES;
	
	if (!self.state.editConnections) {
		[self.state trackShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]] 
					  andDelete:self.shouldDelete];
	} else {
		[self.state hoverShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]]];
	}
	
	[self setNeedsDisplay:state.redraw];
	
	state.redraw = NO;
}

-(void)mouseUp:(NSEvent *)theEvent
{
	[self.state cancelOperation:YES];
	
	[self setNeedsDisplay:state.redraw];
	
	self.state.isEditing = NO;
	
	self.state.redraw = NO;
	self.shouldDelete = NO;
	
	if (self.state.editConnections)
	{
		[self onEndConnection];	
	}
}

-(void)mouseDragged:(NSEvent *)event
{
	NSPoint clickLocation;
    
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
							  fromView:nil];
	
	
	float x = (float)clickLocation.x;
	float y = (float)clickLocation.y;
   	QPoint *p = [[QPoint alloc] init];
	p.x = x; 
	p.y = y;
	
	if (!self.state.editConnections)
	{
		[self.state trackShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]] 
					  andDelete:self.shouldDelete];
	} else {
		[self.state hoverShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]]];
	}
	[self setNeedsDisplay:state.redraw];
	
	state.redraw = NO;
	
}

/**
 Handle the event where the mouse has moved.
 Allow the mouse position to be used to affect the current state.
 **/
-(void)mouseMoved:(NSEvent *)theEvent
{
	NSPoint location;
	location = [self convertPoint:[theEvent locationInWindow] 
						 fromView:nil];
	
	float x = (float)location.x;
	float y = (float)location.y;
	QPoint *p = [[QPoint alloc] init];
	p.x = x;
	p.y = y;
	
	if (self.state.editConnections)
	{
		[self.state hoverShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]]];
	}
	
	[self setNeedsDisplay:state.redraw];
	
	state.redraw = NO;
}

/**
 Prepare the view to allow connections.
 **/
-(void)onStartConnection
{
	if (self.state.editConnections) return;
	self.state.editConnections = YES;
	for(CDQuartzEdge *edge in self.graph.edges)
	{
		[edge.shapeDelegate attachTrackingAreaToView:self];	
	}
	// we also need to connect shapes that are temporary detached edges in the display.
	for(CDQuartzEdge *edge in self.state.detachedEdges)
	{
		[edge.shapeDelegate attachTrackingAreaToView:self];	
	}
}

/**
 Update the view to disallow connections.
 **/
-(void)onEndConnection
{
	self.state.editConnections = NO;
	for(CDQuartzEdge *edge in self.graph.edges)
	{
		if (edge.shapeDelegate != nil)
		{
			[edge.shapeDelegate removeTrackingAreaFromView:self];	
		}
	}
	// we also need to unregister shapes that are temporary detached edges in the display.
	for(CDQuartzEdge *edge in self.state.detachedEdges)
	{
		[edge.shapeDelegate attachTrackingAreaToView:self];	
	}
}


/**
 Receive select action from ui.
 **/
-(IBAction)onSelect:(id)sender
{
	[self onEndConnection];
	self.state.editConnections = NO;
	self.shouldDelete = NO;
}

/**
 Receive add action from UI.
 **/
-(IBAction)onAdd:(id)sender
{
	[self onEndConnection];
	self.shouldDelete = NO;
}

/**
 Receive delete action from UI.
 **/
-(IBAction)onDelete:(id)sender
{
	[self onEndConnection];
	self.shouldDelete = YES;
}

/**
 Add a new connection to the graph.
 **/
-(IBAction)onAddConnect:(id)sender
{
	
	float cx = [self frame].size.width/2.0f;
	float cy = [self frame].size.height/2.0f;
	QRectangle *bounds = [[QRectangle alloc] initX:cx-50 Y:cy+50 WIDTH:100 HEIGHT:100];
	// create a new connection object centre screen.
	BezierLineConnector *connect = [[BezierLineConnector alloc] initWithBounds:bounds];
	
	QPoint *start = [[QPoint alloc] initX:cx-50 Y:cy+50];
	QPoint *end = [[QPoint alloc] initX:cx+50 Y:cy-50];
	
	[connect moveStartTo:start];
	[connect moveEndTo:end];
	
	CDQuartzEdge *edge = [[CDQuartzEdge alloc] init];
	edge.shapeDelegate = connect;
	[self.state.detachedEdges addObject:edge];
	self.state.redraw = YES;
	// update the state.
	[self onStartConnection];
	[self setNeedsDisplay:YES];
	self.shouldDelete = NO;
}

/**
 Receive connect action from UI.
 **/
-(IBAction)onConnect:(id)sender
{
	[self onStartConnection];
	self.shouldDelete = NO;
}

/**
 Receive disconnect action from UI.
 **/
-(IBAction)onDisconnect:(id)sender
{
	self.state.shouldDelete = YES;
	[self onStartConnection];
}

/**
 Receive edit action from UI.
 **/
-(IBAction)onEdit:(id)sender
{
	self.shouldDelete = NO;
	[self onEndConnection];

}

@end
