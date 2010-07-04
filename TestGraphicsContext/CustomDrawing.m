//
//  CustomDrawing.m
//  TestGraphicsContext
//
//  Created by Chris Davey on 27/06/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CustomDrawing.h"


@implementation CustomDrawing

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	[NSGraphicsContext saveGraphicsState];
    // Drawing code here.
	NSRect bounds = [self bounds];
	//make the points
	NSPoint point1 = NSMakePoint ((bounds.origin.x) + 10, (bounds.origin.y) + 10);
	NSPoint point2 = NSMakePoint ((bounds.origin.x) + 10, (bounds.origin.y) + 110);
	NSPoint point3 = NSMakePoint ((bounds.origin.x) + 110, (bounds.origin.y) + 110);
	NSPoint point4 = NSMakePoint ((bounds.origin.x) + 110, (bounds.origin.y) + 10);
	
	//create the lines
	NSBezierPath* lineA = [[NSBezierPath alloc] init];
	[lineA setLineWidth: 3.0];
	[[NSColor redColor] set];
	[lineA moveToPoint: point1];
	[lineA lineToPoint: point2];
	[lineA lineToPoint: point3];
	[lineA lineToPoint: point4];
	[lineA closePath];
	
	[lineA fill];
	[[NSColor blackColor] set];
	[lineA stroke];
	
	// test another method of creating a rect.
	NSRect test2 = NSMakeRect((bounds.origin.x) + 10, (bounds.origin.y) + 150, 100, 100);
	NSBezierPath *pathB = [NSBezierPath bezierPath];
	[pathB appendBezierPathWithRoundedRect:test2 xRadius:2.0 yRadius:2.0];
	[pathB setLineWidth:2.0];
	[[NSColor blueColor] set];
	[pathB fill];
	[[NSColor blackColor] set];
	[pathB stroke];
	
	[NSGraphicsContext restoreGraphicsState];
	
	[NSGraphicsContext saveGraphicsState];
	// test shadows.
	NSShadow* theShadow = [[NSShadow alloc] init];
	[theShadow setShadowOffset:NSMakeSize(10.0, -10.0)];
	[theShadow setShadowBlurRadius:3.0];
	
	// Use a partially transparent color for shapes that overlap.
	[theShadow setShadowColor:[[NSColor blackColor]
							   colorWithAlphaComponent:0.3]];
	
	[theShadow set];
	// test another method of creating a rect.
	NSRect test3 = NSMakeRect((bounds.origin.x) + 150, (bounds.origin.y) + 150, 100, 100);
	NSBezierPath *pathC = [NSBezierPath bezierPath];
	[pathC appendBezierPathWithRoundedRect:test3 xRadius:5.0 yRadius:5.0];
	[pathC setLineWidth:5.0];
	
	[[NSColor yellowColor] set];
	[pathC fill];
	
	[NSGraphicsContext restoreGraphicsState];
	
	[[NSColor orangeColor] set];
	[pathC stroke];
	
	
}

@end
