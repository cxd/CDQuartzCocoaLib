//
//  QLabel.m
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "QLabel.h"


@implementation QLabel

@synthesize text;
@synthesize color;
@synthesize font;
@synthesize fontSize;

-(id)initWithText:(NSString *)t X:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h
{
	self = [super initX:xcoord Y:ycoord WIDTH:w HEIGHT:h];
	self.text = t;
	self.font = @"Helvetica";
	self.fontSize = 12;
	self.color = [[QColor alloc] initWithRGB:0.0 
										   G:0.0 
										   B:0.0];
	return self;
}

-(id)initWithText:(NSString *)t Rect:(CGRect) rect
{
	self = [super initWithRect:rect];
	self.text = t;
	self.font = @"Helvetica";
	self.fontSize = 12;
	self.color = [[QColor alloc] initWithRGB:0.0 
										   G:0.0 
										   B:0.0];
	return self;
}


-(id)initWithText:(NSString *)t Font:(NSString *)f X:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h
{
	self = [super initX:xcoord Y:ycoord WIDTH:w HEIGHT:h];
	self.text = t;
	self.font = f;
	self.fontSize = 12;
	self.color = [[QColor alloc] initWithRGB:0.0 
										   G:0.0 
										   B:0.0];
	return self;
}

-(id)initWithText:(NSString *)t Font:(NSString *)f Rect:(CGRect) rect
{
	self = [super initWithRect:rect];
	self.text = t;
	self.font = f;
	self.fontSize = 12;
	self.color = [[QColor alloc] initWithRGB:0.0 
										   G:0.0 
										   B:0.0];
	return self;
}


-(void)dealloc
{
	if (self.text != nil)
	{
		[self.text autorelease];	
	}
	if (self.color != nil)
	{
		[self.color autorelease];	
	}
	if (self.font != nil)
	{
		[self.font autorelease];	
	}
	[super dealloc];
}

-(void)update:(QContext*) context
{
	// approximate middle y position.
	float midy = self.y + self.height/2.0;
	
	// draw the point and then work out the adjustment.
	CGContextSelectFont (context.context,
						 [self.font UTF8String], 
						 self.fontSize, 
						 kCGEncodingMacRoman);
	CGContextSetCharacterSpacing(context.context, 0.1);
	CGContextSetRGBFillColor(context.context, 
							 self.color.red, 
							 self.color.green, 
							 self.color.blue, 
							 self.color.alpha);
	
#ifdef UIKIT_EXTERN
	CGContextSetTextMatrix(context.context, 
						   CGAffineTransformMake(-1.0,0.0, 0.0, 1.0, 0.0, 0.0));
	
#else
	CGContextSetTextMatrix(context.context, 
						   CGAffineTransformMake(1.0,0.0, 0.0, 1.0, 0.0, 0.0));
	
#endif
	// first draw the text at the current x y position to work out its size.
	CGContextSetTextDrawingMode(context.context,
								kCGTextInvisible);
	CGContextShowTextAtPoint(context.context, 
							 self.x, 
							 self.y, 
							 [self.text UTF8String],
							 [self.text length]);
	CGPoint p = CGContextGetTextPosition(context.context);
	CGContextSetTextDrawingMode(context.context,
								kCGTextFillStroke);
	// calculate the width of the text.
	float w = p.x - self.x;
	if (isnan(w)) return;
	
	// we want to position the text in the middle of the boundary.
	float middle = (self.width - w) / 2.0f;
	CGContextShowTextAtPoint(context.context, 
							 self.x + middle, 
							 midy, 
							 [self.text UTF8String],
							 [self.text length]);
}

@end
