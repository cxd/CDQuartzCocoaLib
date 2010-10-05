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
    if (self.algorithm != nil)
	{
		[self.algorithm layout:self.graph];	
	}
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
	// update any detached edges.
	for(CDQuartzEdge *edge in self.state.detachedEdges)
	{
		[edge.shapeDelegate update:context];
	}
	
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:self.queue];
	[self.queue autorelease];
	self.queue = copy;
	[context release];
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

}

/**
 Receive add action from UI.
 **/
-(IBAction)onAdd:(id)sender
{
	[self onEndConnection];

}

/**
 Receive delete action from UI.
 **/
-(IBAction)onDelete:(id)sender
{
	[self onEndConnection];

}

/**
 Receive connect action from UI.
 **/
-(IBAction)onConnect:(id)sender
{
	[self onStartConnection];
}

/**
 Receive disconnect action from UI.
 **/
-(IBAction)onDisconnect:(id)sender
{
	[self onStartConnection];
}

/**
 Receive edit action from UI.
 **/
-(IBAction)onEdit:(id)sender
{
	[self onEndConnection];

}

@end
