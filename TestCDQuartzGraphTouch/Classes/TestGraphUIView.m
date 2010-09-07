//
//  TestGraphUIView.m
//  TestCDQuartzGraphTouch
//
//  Created by Chris Davey on 7/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TestGraphUIView.h"


@implementation TestGraphUIView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	// Drawing code here.
	
    // a context reference.
	// contexts can reference any type of graphics context.
	QContext *context = [[QContext alloc] initWithContext:UIGraphicsGetCurrentContext()];
	[context retain];
	if (queue == nil)
	{
		queue = [[QModifierQueue alloc] init];
		[queue retain];
		[queue enqueue:[self createGraph]];
		
		self.algorithm = [[ForceDirectedLayout alloc] initWidth:[self frame].size.width 
														 Height:[self frame].size.height 
														 Epochs:150
													Temperature:50.0]; 
	}
	
	self.algorithm.width = [self frame].size.width;
	self.algorithm.height = [self frame].size.height;
	[self.algorithm layout:self.graph];
	
	QModifierQueue *copy = [QModifierQueue updateContext:context SourceQueue:queue];
	[queue autorelease];
	queue = copy;
	[context release];
}


- (void)dealloc {
    [super dealloc];
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

@end
