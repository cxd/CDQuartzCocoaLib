//
//  TestGraphView.m
//  TestCDQuartzGraph
//
//  Created by Chris Davey on 18/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TestGraphView.h"


@implementation TestGraphView


@synthesize toolbar;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
	self.labelField = [[NSTextField alloc] initWithFrame:[self frame]];
    return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
	if (self.toolbar != nil)
	{
		[self.toolbar setSelectedItemIdentifier:@"select"];
	}
	self.labelField = [[NSTextField alloc] initWithFrame:[self frame]];
}


-(void)dealloc
{
	if (self.toolbar != nil)
	{
		[self.toolbar autorelease];	
	}
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	
	if (self.algorithm == nil)
	{
		self.algorithm = [[ForceDirectedLayout alloc] initWidth:[self frame].size.width 
														 Height:[self frame].size.height 
														 Epochs:150
													Temperature:50.0]; 
	}
	[super drawRect:dirtyRect];
}


-(CDQuartzGraph *)createGraph {
	
	CurvedRectangleNode *rect1 = [[CurvedRectangleNode alloc] 
									initWithBounds:
									[[QRectangle alloc] initX:30 Y:30 WIDTH:150 HEIGHT:100]
								  AndLabel:@"Test01"];
	
	CDQuartzNode *node1 = (CDQuartzNode *)[self.graph add:@"Test01"];
	node1.shapeDelegate = rect1;
	
	CurvedRectangleNode *rect2 = [[CurvedRectangleNode alloc] initWithBounds:
								  [[QRectangle alloc] initX:400 Y:300 WIDTH:150 HEIGHT:100]
								  AndLabel:@"Test02"];
	CDQuartzNode *node2 = (CDQuartzNode *)[self.graph add:@"Test02"];
	node2.shapeDelegate = rect2;
	
	CurvedRectangleNode *rect3 = [[CurvedRectangleNode alloc] initWithBounds:
								  [[QRectangle alloc] initX:50 Y:310 WIDTH:150 HEIGHT:100]
																	AndLabel:@"Test03"];
	CDQuartzNode *node3 = (CDQuartzNode *)[self.graph add:@"Test03"];
	node3.shapeDelegate = rect3;
	rect3.fillColor = [[QColor alloc] initWithRGB:0.5 G:1.0 B:0.0];
	
	
	CurvedRectangleNode *rect4 = [[CurvedRectangleNode alloc] initWithBounds:
								  [[QRectangle alloc] initX:250 Y:400 WIDTH:150 HEIGHT:100]
																	AndLabel:@"Test04"];
	CDQuartzNode *node4 = (CDQuartzNode *)[self.graph add:@"Test04"];
	node4.shapeDelegate = rect4;
	rect4.fillColor = [[QColor alloc] initWithRGB:0.0 G:0.8 B:1.0];
	
	
	BezierLineConnector *connect1 = [[BezierLineConnector alloc] init];
	[self.graph connect:node1 
					to:node2
			withShape:connect1
			fromPort:rect1.rightPort
				toPort:rect2.leftPort];
	
	BezierLineConnector *connect2 = [[BezierLineConnector alloc] init];
	[self.graph connect:node1 
			to:node3
			withShape:connect2
			fromPort:rect1.rightPort
			toPort:rect3.leftPort];
	
	BezierLineConnector *connect3 = [[BezierLineConnector alloc] init];
	[self.graph connect:node2 
			to:node3
			withShape:connect3
			fromPort:rect2.rightPort
			toPort:rect3.leftPort];
	
	BezierLineConnector *connect4 = [[BezierLineConnector alloc] init];
	[self.graph connect:node2
					 to: node4
			  withShape:connect4
			   fromPort:rect2.topPort
				 toPort:rect4.bottomPort];
	
	
	BezierLineConnector *connect5 = [[BezierLineConnector alloc] init];
	[self.graph connect:node4
					 to: node1
			  withShape:connect5
			   fromPort:rect4.topPort
				 toPort:rect1.bottomPort];
	
	BezierLineConnector *connect6 = [[BezierLineConnector alloc] init];
	[self.graph connect:node4
					 to: node3
			  withShape:connect6
			   fromPort:rect4.leftPort
				 toPort:rect3.topPort];
	
	return self.graph;
}


-(void)mouseUp:(NSEvent *)theEvent
{
	if (self.toolbar != nil && !self.editLabel)
	{
		[self.toolbar setSelectedItemIdentifier:nil];
		[self.toolbar setSelectedItemIdentifier:@"select"];
	}
	[super mouseUp:theEvent];	
}


/**
 Receive select action from ui.
 **/
-(IBAction)onSelect:(id)sender
{
	[super onSelect:sender];	
}

/**
 Receive add action from UI.
 **/
-(IBAction)onAdd:(id)sender
{
	self.state.newNode = [[CDQuartzNode alloc] init];
	self.state.newNode.data = @"Untitled";
	// add it to the centre of the screen.
	float cx = [self frame].size.width/2.0f;
	float cy = [self frame].size.height/2.0f;
	
	
	CurvedRectangleNode *shape = [[CurvedRectangleNode alloc] initWithBounds:
								  [[QRectangle alloc] initX:cx - 75.0f Y:cy - 50.0f 
													  WIDTH:150 HEIGHT:100]
																	AndLabel:@"Untitled"];
	self.state.newNode.shapeDelegate = shape;
	
	[super onAdd:sender];
}

/**
 Receive delete action from UI.
 **/
-(IBAction)onDelete:(id)sender
{
	[super onDelete:sender];	
}

/**
 Begin text editing.
 The default behaviour is to place the label at the same position as the node.
 **/
-(void)onStartTextEdit:(NSPoint) point size:(NSSize) sz
{
	[super onStartTextEdit:point size:sz];
	
	
}

/**
 End text editing.
 This will remove the text edit field from the subviews.
 **/
-(void)onEndTextEdit
{
	[super onEndTextEdit];
}

/**
 Add a new connection to the graph.
 **/
-(IBAction)onAddConnect:(id)sender
{
	[super onAddConnect:sender];
	if (self.toolbar != nil)
	{
		[self.toolbar setSelectedItemIdentifier:@"connect"];	
	}
}

/**
 Receive connect action from UI.
 **/
-(IBAction)onConnect:(id)sender
{
	[super onConnect:sender];	
}

/**
 Receive disconnect action from UI.
 **/
-(IBAction)onDisconnect:(id)sender
{
	[super onDisconnect:sender];	
}

/**
 Receive edit action from UI.
 **/
-(IBAction)onEdit:(id)sender
{
	[super onEdit:sender];	
}


@end
