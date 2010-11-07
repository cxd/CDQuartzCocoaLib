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
@synthesize parentScrollView;
@synthesize editLabel;
@synthesize labelField;
@synthesize selected;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.graph = [[CDQuartzGraph alloc] init];
		self.state = [[CDGraphViewState alloc] initWithGraph:self.graph 
												   andBounds:[[QRectangle alloc] initX:[self frame].origin.x
																					 Y:[self frame].origin.y
																				 WIDTH:[self frame].size.width
																				HEIGHT:[self frame].size.height]];
		self.state.editDelegate = self;
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
	self.state.editDelegate = self;
	if (self.parentScrollView != nil)
	{
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(boundsDidChange:) 
													 name: NSViewBoundsDidChangeNotification 
												   object:[self.parentScrollView contentView]];
	}
	
	// attach to any colour change notification.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onColorChangeNotification:)
												 name:@"NSColorPanelColorDidChangeNotification"
											   object:nil];
	
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
	if (self.parentScrollView != nil)
	{
		[self.parentScrollView autorelease];	
	}
	if (self.labelField != nil)
	{
		[self.labelField autorelease];	
	}
	if (self.selected != nil)
	{
		[self.selected autorelease];
		self.selected = nil;
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

/**
 Receive the event for colour changes.
 This will change the fill colour of the selected node.
 **/
-(void)onColorChangeNotification:(NSNotification*)notification
{
	if (self.selected == nil)
		return;
	NSColorPanel * panel = [notification object];
	if (panel == nil)
		return;
	NSColor *col = [panel color];
	self.selected.shapeDelegate.fillColor = [[QColor alloc] initWithRGBA:[col redComponent] 
																	  G:[col greenComponent] 
																	  B:[col blueComponent]
																	   A:[col alphaComponent]];
	self.state.isEditing = YES;
	[self setNeedsDisplay:YES];
}


/**
 Process the mousedown event.
 **/
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
	
	if (!self.editLabel)
	{
	self.state.selectLabel = [event clickCount] > 1;
	}
	else {
		self.editLabel = self.state.selectLabel;	
	}
	
	if (!self.state.editConnections) {
		[self.state trackShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]] 
					  andDelete:self.shouldDelete];
	} else {
		[self.state hoverShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]]];
	}
	
	// update the state again if the label is being selected.
	if (self.state.selectLabel)
	{
		[self.state updateState];
	}
	
	[self setNeedsDisplay:state.redraw];
	state.redraw = NO;
	
}

-(void)mouseUp:(NSEvent *)theEvent
{
	if (!self.editLabel) {
		[self.state cancelOperation:YES];
	}
	
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
	
	[self autoscroll:event];
	
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
	
	if (self.state.redraw && self.parentScrollView != nil)
	{
		// recompute the bounds
		QRectangle *currentRect = [[QRectangle alloc] initWithRect:[self frame]];
		QRectangle *newBounds = [self.state computeBounds:currentRect];
		if ( (currentRect.x != newBounds.x) || 
			 (currentRect.y != newBounds.y) ||
			 (currentRect.width != newBounds.width) ||
			 (currentRect.height != newBounds.height) )
		{
			
			[self setFrame:NSMakeRect((newBounds.x < [[self superview] frame].origin.x) ? newBounds.x : [[self superview] frame].origin.x, 
									  (newBounds.y < [[self superview] frame].origin.y) ? newBounds.y : [[self superview] frame].origin.y, 
									  (newBounds.width > [[self superview] frame].size.width) ? newBounds.width : [[self superview] frame].size.width, 
									  (newBounds.height > [[self superview] frame].size.height) ? newBounds.height : [[self superview] frame].size.height)];
			
			[[self superview] setNeedsDisplay:YES];
		}
	}
	
	[self setNeedsDisplay:self.state.redraw];
	
	self.state.redraw = NO;
	
}

/**
 Handle event from bounds changing.
 Will be used when this graph view is housed within a scroll view.
 **/
-(void)boundsDidChange:(NSNotification *)notification
{
	[self setNeedsDisplay:YES];
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
 Implement the edit shape delegate method.
 Edit the supplied shape.
 **/
-(void)editNode:(CDQuartzNode *)shape
{
	self.selected = shape;
	
	/**
	 The implementing view needs to determine how to display
	 the user interface elements for editing the details of a node.
	 Refer to the TestCDQuartzGraph project for an example implementation.
	 The default implementation will only modify the label itself.
	 **/
	if (self.labelField == nil)
		return;
	
	if (shape.shapeDelegate.label != nil)
	{
	[self.labelField setStringValue:shape.shapeDelegate.label];
	}
	float x = shape.shapeDelegate.bounds.x;
	float y = shape.shapeDelegate.bounds.y;
	if (shape.shapeDelegate.labelShape != nil)
	{
		x = shape.shapeDelegate.labelShape.textX;
		y = shape.shapeDelegate.labelShape.textY;
	}
	
	[self onStartTextEdit: NSMakePoint(x, 
									   y)
					 size:NSMakeSize(shape.shapeDelegate.bounds.width, 
									 25.0f)];
	
	
}


/**
 Begin text editing.
 The default behaviour is to place the label at the same position as the node.
 **/
-(void)onStartTextEdit:(NSPoint) point size:(NSSize) sz
{
	if (self.labelField == nil)
		return;
	if (![[self subviews] containsObject:(id)self.labelField])
	{
		[self addSubview:self.labelField];	
	}
	
	NSRect rect = [self.labelField bounds];
	rect.origin.x = point.x;
	rect.origin.y = point.y;
	rect.size.width = sz.width;
	rect.size.height = sz.height;
	[self.labelField setBounds:rect];
	[self.labelField setFrame:rect];
	[self setNeedsDisplay:YES];
}


/**
 End text editing.
 This will remove the text edit field from the subviews.
 **/
-(void)onEndTextEdit
{
	if (!self.editLabel) return;
	if ([[self subviews] containsObject:(id)self.labelField])
	{
		[self.labelField removeFromSuperview];	
	}
	if (self.selected != nil)
	{
		[self.selected.shapeDelegate changeLabel: [self.labelField stringValue]];
		
		[self.selected autorelease];
		self.selected = nil;
	}
	[self setNeedsDisplay:YES];
} 

/**
 Receive select action from ui.
 **/
-(IBAction)onSelect:(id)sender
{
	[self onEndConnection];
	[self onEndTextEdit];
	self.state.editConnections = NO;
	self.shouldDelete = NO;
	self.state.selectLabel = NO;
	self.editLabel = NO;
}

/**
 Receive add action from UI.
 **/
-(IBAction)onAdd:(id)sender
{
	[self onEndConnection];
	[self onEndTextEdit];
	
	self.shouldDelete = NO;
	self.state.selectLabel = NO;
	self.editLabel = NO;
}

/**
 Receive delete action from UI.
 **/
-(IBAction)onDelete:(id)sender
{
	[self onEndConnection];
	[self onEndTextEdit];
	
	self.shouldDelete = YES;
	self.state.selectLabel = NO;
	self.editLabel = NO;
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
	self.state.selectLabel = NO;
	self.editLabel = NO;
}

/**
 Receive connect action from UI.
 **/
-(IBAction)onConnect:(id)sender
{
	[self onStartConnection];
	[self onEndTextEdit];
	
	self.shouldDelete = NO;
	self.state.selectLabel = NO;
	self.editLabel = NO;
}

/**
 Receive disconnect action from UI.
 **/
-(IBAction)onDisconnect:(id)sender
{
	[self onEndTextEdit];
	
	self.state.shouldDelete = YES;
	[self onStartConnection];
	self.state.selectLabel = NO;
	self.editLabel = NO;
}

/**
 Receive edit action from UI.
 **/
-(IBAction)onEdit:(id)sender
{
	self.shouldDelete = NO;
	[self onEndConnection];
	self.state.selectLabel = YES;
	self.editLabel = YES;
}

@end
