//
//  UIGraphView.m
//  CDQuartzGraphTouch
//
//  Created by Chris Davey on 6/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "UIGraphView.h"


@implementation UIGraphView


@synthesize graph;
@synthesize trackNodes;
@synthesize algorithm;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.graph = [[CDQuartzGraph alloc] init];
		self.multipleTouchEnabled = YES;
		self.trackNodes = [[NSMutableArray alloc] init];
	}
    return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
	self.multipleTouchEnabled = YES;
	self.graph = [[CDQuartzGraph alloc] init];
	self.trackNodes = [[NSMutableArray alloc] init];
}

-(void)dealloc
{
	if (self.trackNodes != nil)
	{
		[self.trackNodes removeAllObjects];
		[self.trackNodes autorelease];	
	}
	[self.graph autorelease];
	if (self.algorithm != nil)
	{
		[self.algorithm autorelease];	
	}
	[super dealloc];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.algorithm != nil)
	{
		[self.algorithm layout:self.graph];	
	}
	
}

// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	int i=0;
	for(UITouch *t in touches)
	{
		[self beginTracking:t atIndex:i];
		i++;
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	int i=0;
	for(UITouch *t in touches)
	{
		[self endTracking:t atIndex:i];
		i++;
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	int i=0;
	for(UITouch *t in touches)
	{
		[self moveTracked:t atIndex:i];
		i++;
	}
}

-(void)beginTracking:(UITouch *)touch atIndex:(int)idx
{
	CGPoint point = [touch locationInView:self];
	CGPoint clickLocation = [self convertPoint:point fromView:nil];
	float x = (float)clickLocation.x;
	float y = (float)clickLocation.y;
	
   	
	QPoint *p = [[QPoint alloc] init];
	p.x = x;
	p.y = y;
	// find a node that is associated with the click event.
	CDQuartzNode* node = [self.graph findNodeContaining:p];
	[node retain];
	if (node != nil)
	{
		[self.trackNodes addObject:[[TrackedNode alloc] initWithNode:node atIndex:idx]];	
	}
	[node autorelease];
}

-(void)moveTracked:(UITouch *)touch atIndex:(int)idx
{
 	// find the tracked node at the supplied index.
	if (idx < 0 || idx > [self.trackNodes count]) return;
	TrackedNode* t = [self findNode:idx];
	if (t == nil)
		return;
	CGPoint point = [touch locationInView:self];
	CGPoint clickLocation = [self convertPoint:point fromView:nil];
	float x = (float)clickLocation.x;
	float y = (float)clickLocation.y;
	
   	
	QPoint *p = [[QPoint alloc] init];
	p.x = x;
	p.y = y;
	[self.graph moveNode:t.node To:p];
	
	[self setNeedsDisplay];
}

-(void)endTracking:(UITouch *)touch atIndex:(int)idx
{
	// find the tracked node at index
	// find the tracked node at the supplied index.
	if (idx < 0 || idx > [self.trackNodes count]) return;
	TrackedNode* t = [self findNode:idx];
	// if found update the position.
	if (t == nil)
		return;
	// remove it from the tracked collection
	[self.trackNodes removeObject:t];
}

-(TrackedNode *)findNode:(int)idx
{
	for(TrackedNode *t in self.trackNodes)
	{
		if (t.index == idx) return t;	
	}
	return nil;
}



@end
