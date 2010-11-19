//
//  CDGraphView.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 22/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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


#ifdef UIKIT_EXTERN
- (id)initWithFrame:(CGRect)frame {
#else
- (id)initWithFrame:(NSRect)frame {
#endif
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
#ifdef UIKIT_EXTERN	
		self.parentScrollView.contentSize = CGSizeMake([self frame].size.width, [self frame].size.height);
		
#else		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(boundsDidChange:) 
													 name: NSViewBoundsDidChangeNotification 
												   object:[self.parentScrollView contentView]];
#endif
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
 Save the graph to the supplied file path.
 **/
-(BOOL)saveGraphToFilePath:(NSString *)filePath
{
	@try {
		return [NSKeyedArchiver archiveRootObject:self.graph 
										   toFile:filePath];
	}
	@catch (NSException * e) {
		NSLog(@"%@ %@ %@", [e name], [e reason], [e description]);	
	}
	return NO;
}

/**
 Open the graph from the supplied file path.
 **/
-(BOOL)openGraphFromFilePath:(NSString *)filePath
{
	@try {
		CDQuartzGraph *copy;
		copy = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
		if (copy != nil) {
			[self swapGraph:copy];
			return YES;
		}
	}
	@catch (NSException * e) {
		NSLog(@"%@ %@ %@", [e name], [e reason], [e description]);	
	}
	return NO;
}


/**
 Swap the current graph out for a new graph.
 This effectively replaces the graph within the view state.
 **/
-(void)swapGraph:(CDQuartzGraph *)newGraph
{
	[self.graph autorelease];	
	[self.state autorelease];
	[self.queue autorelease];
	self.queue = [[QModifierQueue alloc] init];
	[self.queue retain];
	self.graph = newGraph;
	self.state = [[CDGraphViewState alloc] initWithGraph:self.graph 
											   andBounds:[[QRectangle alloc] initX:[self frame].origin.x
																				 Y:[self frame].origin.y
																			 WIDTH:[self frame].size.width
																			HEIGHT:[self frame].size.height]];	
	self.state.editDelegate = self;
	[self.queue enqueue:self.graph];
	
	if (self.parentScrollView != nil)
	{
		// recompute the bounds
		QRectangle *currentRect = [[QRectangle alloc] initWithRect:[self frame]];
		QRectangle *newBounds = [self.state computeBounds:currentRect];
		if ( (currentRect.x != newBounds.x) || 
			(currentRect.y != newBounds.y) ||
			(currentRect.width != newBounds.width) ||
			(currentRect.height != newBounds.height) )
		{
			
			[self setFrame:CGRectMake((newBounds.x < [[self superview] frame].origin.x) ? newBounds.x : [[self superview] frame].origin.x, 
									  (newBounds.y < [[self superview] frame].origin.y) ? newBounds.y : [[self superview] frame].origin.y, 
									  (newBounds.width > [[self superview] frame].size.width) ? newBounds.width : [[self superview] frame].size.width, 
									  (newBounds.height > [[self superview] frame].size.height) ? newBounds.height : [[self superview] frame].size.height)];
		}
	}
	
	self.shouldDelete = NO;
	self.editLabel = NO;
#ifdef UIKIT_EXTERN
	[[self superview] setNeedsDisplay]; 
#else
	[[self superview] setNeedsDisplay:YES];
#endif
}

#ifndef UIKIT_EXTERN
/**
A replacement method for the "setNeedsDisplay" provided in UIKit.
This will set the needs display flag to true.
**/
-(void)setNeedsDisplay
{
	[self setNeedsDisplay:YES];	
}
#endif
	
#pragma mark Drawing.	
/**
 Derived classes should override this method
 if they need to do any custom drawing before the base class.
 **/
#ifdef UIKIT_EXTERN	
- (void)drawRect:(CGRect)dirtyRect {
#else
- (void)drawRect:(NSRect)dirtyRect {
#endif

    // a context reference.
	// contexts can reference any type of graphics context.
	
#ifdef UIKIT_EXTERN	
	QContext *context = [[QContext alloc] initWithContext:UIGraphicsGetCurrentContext()];
	
	// flip the coordinates for UI drawing.
	[context flipW:0.0 H:dirtyRect.size.height];
	
#else
	QContext *context = [[QContext alloc] initWithContext:[[NSGraphicsContext currentContext] graphicsPort]];
	
#endif
	
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
	 Receive the change font event.
	 The default behaviour is to change the
	 font of the selected node.
	 **/
#ifdef UIKIT_EXTERN
	-(void)onChangeFont:(UIFont *)font
#else
	-(void)onChangeFont:(NSFont *)font
#endif
{
	if (self.selected == nil)
			return;
	if (self.selected.shapeDelegate.labelShape == nil)
		return;
	NSString* name = [font fontName];
	CGFloat sz = [font pointSize];
	self.selected.shapeDelegate.labelShape.font = name;
	self.selected.shapeDelegate.labelShape.fontSize = sz;
	self.state.isEditing = YES;
	[self setNeedsDisplay];
}

#ifndef UIKIT_EXTERN

/* TODO: find a way to implement colour selection in Cocoa Touch. */
	
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

#pragma mark OSX Mouse event handling.	
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
	 Handle the event where the mouse has moved.
	 Allow the mouse position to be used to affect the current state.
	 This event is received when the connections
	 have attached NSTrackingAreas to the view.
	 Otherwise this event is not raised.
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
#endif


/**
 Handle event from bounds changing.
 Will be used when this graph view is housed within a scroll view.
 **/
-(void)boundsDidChange:(NSNotification *)notification
{
	[self setNeedsDisplay];
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
#ifdef UIKIT_EXTERN
	[self.labelField setText:shape.shapeDelegate.label];
#else
	[self.labelField setStringValue:shape.shapeDelegate.label];
#endif
	}
	float x = shape.shapeDelegate.bounds.x;
	float y = shape.shapeDelegate.bounds.y;
	if (shape.shapeDelegate.labelShape != nil)
	{
		x = shape.shapeDelegate.labelShape.textX;
		y = shape.shapeDelegate.labelShape.textY;
	}
	
	[self onStartTextEdit: CGPointMake(x, 
									   y)
					 size:CGSizeMake(shape.shapeDelegate.bounds.width, 
									 25.0f)];
	
	
}


/**
 Begin text editing.
 The default behaviour is to place the label at the same position as the node.
 **/
-(void)onStartTextEdit:(CGPoint) point size:(CGSize) sz
{
	if (self.labelField == nil)
		return;
	if (![[self subviews] containsObject:(id)self.labelField])
	{
		[self addSubview:self.labelField];	
	}
	
	CGRect rect = [self.labelField bounds];
	rect.origin.x = point.x;
	rect.origin.y = point.y;
	rect.size.width = sz.width;
	rect.size.height = sz.height;
	[self.labelField setBounds:rect];
	[self.labelField setFrame:rect];
	[self setNeedsDisplay];
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
#ifdef UIKIT_EXTERN
		[self.selected.shapeDelegate changeLabel: [self.labelField text]];
#else
		[self.selected.shapeDelegate changeLabel: [self.labelField stringValue]];
#endif	
		[self.selected autorelease];
		self.selected = nil;
	}
	[self setNeedsDisplay];
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
	[self setNeedsDisplay];
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

#ifdef UIKIT_EXTERN

#pragma mark UIKit Touch Input.
	
/**
 Touches began are treated in a way that is similar to a mousedown 
 in the graph view.
 **/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	self.state.isEditing = YES;
	
	//TODO: gesture for editing text
	if (!self.editLabel)
	{
		//	self.state.selectLabel = [event clickCount] > 1;
	}
	else {
		self.editLabel = self.state.selectLabel;	
	}
	
	
	int i=0;
	for(UITouch *t in touches)
	{
		[self beginTracking:t atIndex:i];
		i++;
	}
	
	// update the state again if the label is being selected.
	if (self.state.selectLabel)
	{
		[self.state updateState];
	}
	if (state.redraw)
	{
		[self setNeedsDisplay];
	}
	state.redraw = NO;
}

	/**
	 This is equivalent to a mouseup in the graph view.
	 **/
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Touches Ended");
	
	int i=0;
	for(UITouch *t in touches)
	{
		[self endTracking:t atIndex:i];
		i++;
	}
	
	if (!self.editLabel) {
		[self.state cancelOperation:YES];
	}
	if (state.redraw) [self setNeedsDisplay];
	self.state.isEditing = NO;
	self.state.redraw = NO;
	self.shouldDelete = NO;
	if (self.state.editConnections)
	{
		[self onEndConnection];	
	}
}
/**
 Touches Moved is treated in a way that is similar to mouse dragged in 
 the graph view.
 **/
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Touches Moved");
	
	int i=0;
	for(UITouch *t in touches)
	{
		[self moveTracked:t atIndex:i];
		i++;
	}
	if (self.state.redraw)
	{
		[self setNeedsDisplay];
	}
	self.state.redraw = NO;
	
}
	
	
/**
 Begin tracking the touch for the supplied index..
 **/
-(void)beginTracking:(UITouch *)touch atIndex:(int)idx
{
	if (self.state.editConnections)
		[self testConnections:touch];
	
	CGPoint clickLocation = [touch locationInView:self];
   	
	QPoint *p = [[QPoint alloc] init];
	p.x = clickLocation.x;
	p.y = [self frame].size.height - clickLocation.y;
	
	if (!self.state.editConnections) {
		[self.state trackShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]] 
					  andDelete:self.shouldDelete];
	} else {
		[self.state hoverShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]]];
	}
}

/**
 The touch has moved, track the movement for the supplied index.
 **/
-(void)moveTracked:(UITouch *)touch atIndex:(int)idx
{
	if (self.state.editConnections)
		[self testConnections:touch];
	
	NSLog(@"Moved Tracked");
	
	CGPoint clickLocation = [touch locationInView:self];
   	
	float x = (float)clickLocation.x;
	float y = (float)clickLocation.y;
   	QPoint *p = [[QPoint alloc] init];
	p.x = x; 
	p.y = [self frame].size.height - y;
	
	if (!self.state.editConnections)
	{
		NSLog(@"Track Shapes");
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
			
			[self setFrame:CGRectMake((newBounds.x < [[self superview] frame].origin.x) ? newBounds.x : [[self superview] frame].origin.x, 
									  (newBounds.y < [[self superview] frame].origin.y) ? newBounds.y : [[self superview] frame].origin.y, 
									  (newBounds.width > [[self superview] frame].size.width) ? newBounds.width : [[self superview] frame].size.width, 
									  (newBounds.height > [[self superview] frame].size.height) ? newBounds.height : [[self superview] frame].size.height)];
			
			[[self superview] setNeedsDisplay];
		}
	}
}

/**
 The touch is no longer active for the supplied index.
 **/
-(void)endTracking:(UITouch *)touch atIndex:(int)idx
{
	
}

/**
 Test the connections for a touch that may reside
 within a connection boundary.
 **/
-(void)testConnections:(UITouch *)touch 
{
	if (!self.state.editConnections) return;
	BOOL isMatched = NO;
	for(CDQuartzEdge *edge in self.graph.edges)
	{
		if (edge.shapeDelegate != nil)
		{
			if ([edge.shapeDelegate.trackingView isTouchInBounds:self 
													   withTouch:touch])
			{
			// generate the connection editing notifications.
				[self updateLocationOfHoverOnConnection:touch];
				isMatched = YES;
			}
		}
	}
	if (isMatched) return;
	// we also need to unregister shapes that are temporary detached edges in the display.
	for(CDQuartzEdge *edge in self.state.detachedEdges)
	{
		if ([edge.shapeDelegate.trackingView isTouchInBounds:self
												   withTouch:touch])
		{
		// generate the connection editing event.
			[self updateLocationOfHoverOnConnection:touch];
		}
	}
}

/**
Because NSTrackingArea is not provided in cocoa touch
 instead we always search for a touch location
 within the boundaries of each edge connector shape.
 If it is then we add it to the hoverShapes collection in the state.
 This simulates the result that "mouseMoved" would have if tracking
 was supported.
**/
-(void)updateLocationOfHoverOnConnection:(UITouch *)touch
{
	CGPoint location = [touch locationInView:self];
	float x = (float)location.x;
	float y = (float)location.y;
	QPoint *p = [[QPoint alloc] init];
	p.x = x;
	p.y = [self frame].size.height - y;
	if (self.state.editConnections)
	{
		[self.state hoverShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]]];
	}
}
	
#endif
	
@end
