//
//  EcmascriptShapeDescription.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 7/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "ESShapeDescription.h"


@implementation ESShapeDescription

@synthesize color;
@synthesize outlineColor;
@synthesize outlineWidth;
@synthesize shapeType;
@synthesize labelText;
@synthesize alpha;
@synthesize bounds;

-(id)init {
	self = [super init];
	self.bounds = [[[ESBounds alloc] init] autorelease];
	self.bounds.x = 10;
	self.bounds.y = 10;
	self.bounds.width = 100;
	self.bounds.height = 50;
	return self;
}

-(void)dealloc {
	self.color = nil;
	self.outlineColor = nil;
	self.shapeType = nil;
	self.labelText = nil;
	self.bounds = nil;
	[super dealloc];
}

/**
 Create a shape based on the value of shapeType.
 The bounds property must be not nil.
 
 There are only 4 supported shapes currently.
 
  RECT
  CURVED_RECT
  ELLIPSE
  CIRCLE
 
 **/
-(AbstractNodeShape *)createShape
{
	if (self.shapeType == nil) 
		return nil;
	if (self.bounds == nil)
		return nil;
	if (self.labelText == nil)
		self.labelText = @"";
	
	NSArray *array = [NSArray arrayWithObjects:@"RECT",@"CURVED_RECT", @"ELLIPSE", @"CIRCLE", nil];
	if ([array indexOfObjectPassingTest:^(id obj, NSUInteger idx, BOOL *stop) {
		return (BOOL)([[self.shapeType uppercaseString] compare:[array objectAtIndex:idx]] == NSOrderedSame);
	}] == NSNotFound)
	{
		return nil;
	}
	AbstractNodeShape *shape;
	if ([[self.shapeType uppercaseString] compare:@"RECT"] == NSOrderedSame) {
		
		shape = [[RectangleNode alloc] 
				 initWithBounds: [[QRectangle alloc] initX:self.bounds.x 
														 Y:self.bounds.y 
													 WIDTH:self.bounds.width 
													HEIGHT:self.bounds.height]
				 AndLabel:self.labelText];
		
	} else if ([[self.shapeType uppercaseString] compare:@"CURVED_RECT"] == NSOrderedSame) {
		
		shape = [[CurvedRectangleNode alloc] 
				 initWithBounds: [[QRectangle alloc] initX:self.bounds.x 
														 Y:self.bounds.y 
													 WIDTH:self.bounds.width 
													HEIGHT:self.bounds.height]
				 AndLabel:self.labelText];
		
		
	} else if ([[self.shapeType uppercaseString] compare:@"ELLIPSE"] == NSOrderedSame) {
		
		shape = [[EllipseNode alloc] 
				 initWithBounds: [[QRectangle alloc] initX:self.bounds.x + self.bounds.width/2.0f 
														 Y:self.bounds.y + self.bounds.height/2.0f 
													 WIDTH:self.bounds.width 
													HEIGHT:self.bounds.height]
				 AndLabel:self.labelText];
		
		
	} else if ([[self.shapeType uppercaseString] compare:@"CIRCLE"] == NSOrderedSame) {
		
		shape = [[CircleNode alloc] 
				 initWithBounds: [[QRectangle alloc] initX: self.bounds.x + self.bounds.width/2.0f 
														 Y:self.bounds.y + self.bounds.height/2.0f 
													 WIDTH:self.bounds.width 
													HEIGHT:self.bounds.height]
				 AndLabel:self.labelText];
		
	}
	
	ESColourParser *colorParser = [[[ESColourParser alloc] initParser:self.color] autorelease];
	ESColourParser *outlineParser = [[[ESColourParser alloc] initParser:self.outlineColor] autorelease];
	shape.fillColor = [colorParser parseSource];
	shape.outlineColor = [outlineParser parseSource];
	shape.outlineWeight = self.outlineWidth;
	return shape;
}



@end
