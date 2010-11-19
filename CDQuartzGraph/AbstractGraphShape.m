//
//  AbstractGraphShape.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
@synthesize trackingView;
@synthesize isHighlighted;

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
	self.trackingView = [[TrackingViewBoundary alloc] init];
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
	self.trackingView = [[TrackingViewBoundary alloc] init];
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
	self.trackingView = [[TrackingViewBoundary alloc] init];
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
	self.trackingView = [[TrackingViewBoundary alloc] init];
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
	if (self.trackingView != nil)
	{
		[self.trackingView autorelease];
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
	self.labelShape.isFlipped = YES;
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
	return [self.bounds contains:point];
}

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other
{
	return [self.bounds intersects:other];
}

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point
{
	self.bounds.x += point.x;
	self.bounds.y += point.y;
	if (self.labelShape != nil)
	{
		self.labelShape.x += point.x;
		self.labelShape.y += point.y;
	}
	[self.trackingView updateBoundary:self.bounds];
}

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point
{
	self.bounds.x = point.x;
	self.bounds.y = point.y;
	if (self.labelShape != nil)
	{
		self.labelShape.x = point.x;
		self.labelShape.y = point.y;
	}
	[self.trackingView updateBoundary:self.bounds];
}

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h
{
	self.bounds.width = w;
	self.bounds.height = h;
	if (self.labelShape != nil)
	{
		self.labelShape.width = w;
		self.labelShape.height = h;
	}
	[self.trackingView updateBoundary:self.bounds];
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
	[super update:context];
}


/**
 Change the label.
 **/
-(void)changeLabel:(NSString *)newLabel
{
	if (self.label != nil)
	{
		[self.label autorelease];	
	}
	self.label = newLabel;
	if (self.labelShape != nil)
	{
		self.labelShape.text = self.label;	
	}
}



#ifdef UIKIT_EXTERN 


/**
 Attach the tracking area to a view.
 **/
-(void)attachTrackingAreaToView:(UIView *)view
{
	[self.trackingView attach:view InBoundary:self.bounds];	
}

/**
 Remove the tracking area from the view.
 **/
-(void)removeTrackingAreaFromView:(UIView *)view
{
	[self.trackingView remove:view];	
}


#else

/**
 Attach the tracking area to a view.
 **/
-(void)attachTrackingAreaToView:(NSView *)view
{
	[self.trackingView attach:view InBoundary:self.bounds];	
}

/**
 Remove the tracking area from the view.
 **/
-(void)removeTrackingAreaFromView:(NSView *)view
{
	[self.trackingView remove:view];	
}

#endif


#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder];
	self.bounds = [aDecoder decodeObjectForKey:@"AbstractGraphShape_bounds"];
	self.fillColor = [aDecoder decodeObjectForKey:@"AbstractGraphShape_fillColor"];
	self.outlineColor = [aDecoder decodeObjectForKey:@"AbstractGraphShape_outlineColor"];
	self.outlineWeight = [aDecoder decodeFloatForKey:@"AbstractGraphShape_outlineWeight"];
	self.displacement = [aDecoder decodeObjectForKey:@"AbstractGraphShape_displacement"];
	self.labelShape = [aDecoder decodeObjectForKey:@"AbstractGraphShape_labelShape"];
	self.textColor = [aDecoder decodeObjectForKey:@"AbstractGraphShape_textColor"];
	self.label = [aDecoder decodeObjectForKey:@"AbstractGraphShape_label"];
	return self;
}
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
	[aCoder encodeObject:self.bounds forKey:@"AbstractGraphShape_bounds"];
	[aCoder encodeObject:self.fillColor forKey:@"AbstractGraphShape_fillColor"];
	[aCoder encodeObject:self.outlineColor forKey:@"AbstractGraphShape_outlineColor"];
	[aCoder encodeFloat:self.outlineWeight forKey:@"AbstractGraphShape_outlineWeight"];
	[aCoder encodeObject:self.displacement forKey:@"AbstractGraphShape_displacement"];
	[aCoder encodeObject:self.labelShape forKey:@"AbstractGraphShape_labelShape"];
	[aCoder encodeObject:self.textColor forKey:@"AbstractGraphShape_textColor"];
	[aCoder encodeObject:self.label forKey:@"AbstractGraphShape_label"];
}


@end
