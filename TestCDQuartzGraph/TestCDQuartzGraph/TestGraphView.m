//
//  TestGraphView.m
//  TestCDQuartzGraph
//
//  Created by Chris Davey on 18/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TestGraphView.h"


@implementation TestGraphView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	
    // a context reference.
	// contexts can reference any type of graphics context.
	QContext *context = [[QContext alloc] initWithContext:[[NSGraphicsContext currentContext] graphicsPort]];
	[context retain];
	if (queue == nil)
	{
		queue = [[QModifierQueue alloc] init];
		[queue retain];
		[queue enqueue:[self createGraph]];
	}
	
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:queue];
	[queue autorelease];
	queue = copy;
	[context release];
}

-(CDQuartzGraph *)createGraph {
	
	CurvedRectangleNode *rect1 = [[CurvedRectangleNode alloc] 
									initWithBounds:
									[[QRectangle alloc] initX:30 Y:30 WIDTH:150 HEIGHT:100]];
	
	CDQuartzNode *node1 = (CDQuartzNode *)[self.graph add:@"Test01"];
	node1.shapeDelegate = rect1;
	
	CurvedRectangleNode *rect2 = [[CurvedRectangleNode alloc] initWithBounds:
								  [[QRectangle alloc] initX:400 Y:300 WIDTH:150 HEIGHT:100]];
	CDQuartzNode *node2 = (CDQuartzNode *)[self.graph add:@"Test02"];
	node2.shapeDelegate = rect2;
	
	CurvedRectangleNode *rect3 = [[CurvedRectangleNode alloc] initWithBounds:
								  [[QRectangle alloc] initX:50 Y:310 WIDTH:150 HEIGHT:100]];
	CDQuartzNode *node3 = (CDQuartzNode *)[self.graph add:@"Test03"];
	node3.shapeDelegate = rect3;
	
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
	
	return self.graph;
}

@end
