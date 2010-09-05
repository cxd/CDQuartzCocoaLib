//
//  AbstractGraphShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "AbstractGraphShape.h"


@implementation AbstractGraphShape

@synthesize bounds;
@synthesize fillColor;
@synthesize outlineColor;
@synthesize outlineWeight;
@synthesize displacement;
@synthesize label;
@synthesize labelShape;
@synthesize textColor;

/**
 Default initialisation.
 **/
-(id)init
{
	self = [super init];
	self.bounds = [[QRectangle alloc] init];
	self.fillColor = [[QColor alloc] initWithRGB:1.0 G:1.0 B:1.0];
	self.outlineColor = [[QColor alloc] initWithRGB:0.0 G:0.0 B:0.0];
	self.outlineWeight = 1.0;
	self.displacement = [[QPoint alloc] initX:0.0 Y:0.0];
	[self attachObservers];
	return self;
}

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l
{
	self = [super init];
	self.bounds = [[QRectangle alloc] init];
	self.fillColor = [[QColor alloc] initWithRGB:1.0 G:1.0 B:1.0];
	self.outlineColor = [[QColor alloc] initWithRGB:0.0 G:0.0 B:0.0];
	self.outlineWeight = 1.0;
	self.displacement = [[QPoint alloc] initX:0.0 Y:0.0];
	self.label = l;
	[self createLabel];
	[self attachObservers];
	return self;
}

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b
{
	self = [super init];
	self.bounds = b;
	self.fillColor = [[QColor alloc] initWithRGB:1.0 G:1.0 B:1.0];
	self.outlineColor = [[QColor alloc] initWithRGB:0.0 G:0.0 B:0.0];
	self.outlineWeight = 1.0;
	self.displacement = [[QPoint alloc] initX:0.0 Y:0.0];
	[self attachObservers];
	return self;
}

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l
{
	self = [super init];
	self.bounds = b;
	self.fillColor = [[QColor alloc] initWithRGB:1.0 G:1.0 B:1.0];
	self.outlineColor = [[QColor alloc] initWithRGB:0.0 G:0.0 B:0.0];
	self.outlineWeight = 1.0;
	self.displacement = [[QPoint alloc] initX:0.0 Y:0.0];
	self.label = l;
	[self createLabel];
	[self attachObservers];
	return self;
}



/*
 Dealloc.
 */
-(void)dealloc
{
	if (self.bounds != nil)
	{
		[self.bounds autorelease];	
	}
	if (self.label != nil)
	{
		[self.label autorelease];	
	}
	if (self.labelShape != nil)
	{
		[self.labelShape autorelease];	
	}
	if (self.textColor != nil)
	{
		[self.textColor autorelease];	
	}
	[super dealloc];
}


/**
 Create the label to render.
 **/
-(void)createLabel
{
	self.labelShape = [[QLabel alloc] initWithText:self.label 
												 X: self.bounds.x 
												 Y: self.bounds.y
											 WIDTH: self.bounds.width
											HEIGHT: self.bounds.height];
	self.labelShape.color;
}

-(void)attachObservers 
{
	[self addObserver:self
			  forKeyPath:@"fillColor"
                 options:(NSKeyValueObservingOptionNew |
						  NSKeyValueObservingOptionOld)
				 context:NULL];
	
	[self addObserver:self
		   forKeyPath:@"outlineColor"
			  options:(NSKeyValueObservingOptionNew |
					   NSKeyValueObservingOptionOld)
			  context:NULL];
	
	[self addObserver:self
		   forKeyPath:@"outlineWeight"
			  options:(NSKeyValueObservingOptionNew |
					   NSKeyValueObservingOptionOld)
			  context:NULL];
	
	[self addObserver:self
		   forKeyPath:@"textColor"
			  options:(NSKeyValueObservingOptionNew |
					   NSKeyValueObservingOptionOld)
			  context:NULL];
}

/**
 Receive key value observing events.
 **/
-(void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
	if ([keyPath isEqualToString:@"outlineColor"])
	{
	[self onOutlineColorChanged];	
	}
	else if ([keyPath isEqualToString:@"outlineWeight"])
	{
		[self onOutlineWeightChanged];	
	}
	else if ([keyPath isEqualToString:@"fillColor"]) 
	{
		[self onFillColorChanged];
	}
	else if ([keyPath isEqualToString:@"textColor"])
	{
		if (self.labelShape != nil)
		{
			self.labelShape.color = self.textColor;	
		}
	}
}


/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged
{
	
}

/**
 Event raised when fill color changed.
 **/
-(void)onFillColorChanged
{
}

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged
{
}


/**
 Check whether a point occurs within the bounds
 of this object.
 **/
-(BOOL)isWithinBounds:(QPoint *)point
{
	QPoint *topLeft = [[QPoint alloc] initX:self.bounds.x Y:self.bounds.y];
	QPoint *bottomRight = [[QPoint alloc] initX:self.bounds.x + self.bounds.width Y:self.bounds.y + self.bounds.height];
	
	// distance should be positive as point is greater than top left.
	float xTop = [topLeft horizontalDistanceTo:point];
	float yTop = [topLeft verticalDistanceTo:point];
	
	// distance should be negative as point is less than bottom right.
	float xBottom = [bottomRight horizontalDistanceTo:point];
	float yBottom = [bottomRight verticalDistanceTo:point];
	
	return (xTop >= 0.0 && yTop >= 0.0 && xBottom <= 0.0 && yBottom <= 0.0);
}

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other
{
	// very simple collision detection the rectangular intersection.
	float left = self.bounds.x;
	float left2 = other.x;
	float right = self.bounds.x + self.bounds.width;
	float right2 = other.x + other.width;
	float top = self.bounds.y;
	float top2 = other.y;
	float bottom = self.bounds.y + self.bounds.height;
	float bottom2 = other.y + other.height;
	if ((left > right2) || 
		(right < left2) ||
		(top > bottom2) ||
		(bottom < top2))
		return NO;
	return YES;	
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	self.bounds.x += point.x;
	self.bounds.y += point.y;
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	self.bounds.x = point.x;
	self.bounds.y = point.y;
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	self.bounds.width = w;
	self.bounds.height = h;
}


/**
 Overridden to update the context with the text label.
 **/
-(void)update:(QContext*) context
{
	if (self.labelShape != nil && !labelQueued)
	{
		labelQueued = YES;
		[self.queue enqueue:self.labelShape]; 
	}
	else if (self.labelShape != nil)
	{
		self.labelShape.x = self.bounds.x;
		self.labelShape.y = self.bounds.y;
		self.labelShape.width = self.bounds.width;
		self.labelShape.height = self.bounds.height;
	}
	[super update:context];
}

@end
