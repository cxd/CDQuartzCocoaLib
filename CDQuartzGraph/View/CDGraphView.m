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
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
    if (self.algorithm != nil)
	{
		[self.algorithm layout:self.graph];	
	}
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
	[self.state trackShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]] 
				  andDelete:self.shouldDelete];
	
	
	[self setNeedsDisplay:state.redraw];
	
	state.redraw = NO;
}

-(void)mouseUp:(NSEvent *)theEvent
{
	[self.state cancelOperation:YES];
	
	[self setNeedsDisplay:state.redraw];
	
	state.redraw = NO;
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
	[self.state trackShapes:[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:p,nil]] 
				  andDelete:self.shouldDelete];
	
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
	
	
	
	[self setNeedsDisplay:state.redraw];
	
	state.redraw = NO;
}


@end
