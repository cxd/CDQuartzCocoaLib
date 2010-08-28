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
@synthesize trackNode;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.graph = [[CDQuartzGraph alloc] init];
    }
    return self;
}


-(void)awakeFromNib
{
	[super awakeFromNib];
	self.graph = [[CDQuartzGraph alloc] init];
}

-(void)dealloc
{
	if (self.trackNode != nil)
	{
	[self.trackNode autorelease];	
	}
	[self.graph autorelease];
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
    
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
	// find a node that is associated with the click event.
	self.trackNode = [self.graph findNodeContaining:p];	
}

-(void)mouseUp:(NSEvent *)theEvent
{
	if (self.trackNode != nil)
	{
		[self.trackNode autorelease];
		self.trackNode = nil;
	}
}

-(void)mouseDragged:(NSEvent *)event
{
	if (self.trackNode == nil)
	{
		return;	
	}
	NSPoint clickLocation;
    
    // convert the mouse-down location into the view coords
    clickLocation = [self convertPoint:[event locationInWindow]
							  fromView:nil];
	
	
	float x = (float)clickLocation.x;
	float y = (float)clickLocation.y;
   	QPoint *p = [[QPoint alloc] init];
	p.x = x; 
	p.y = y;
	
	[self.graph moveNode:self.trackNode To:p];
	
	[self setNeedsDisplay:YES];
	
}


@end
