//
//  PaintInstance.h
//  Pour
//
//  Created by Chris Davey on 3/08/09.
//  Copyright 2009 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCocoaLib.h"
#import "PouredDroplet.h"
#import "Vector2D.h"

/*
 A paint instance represents a single poured object.
 A user pours paint instances onto the screen by touching the screen.
 
 Paint Instances are particle systems whose energy degrades over time.
 The paint instance is manipulated by the user tilting the iphone device.
 The direction of the pour is manipulated by this tilting movement.
 The degrading energy represents the drying time of the paint.
 Once dry the mark is left on the view, but be moved about by user interaction.
 
 */
@interface PaintInstance : NSObject{
	NSMutableArray *droplets;
	Vector2D *vector;
	QFillColor *fillColor;
	float energy;
	QPoint *point;
	CGRect frame;
}
@property(retain) NSMutableArray *droplets;
@property(retain) Vector2D *vector;
@property(assign) float energy;
@property(retain) QFillColor *fillColor;
@property(retain) QPoint *point;
@property(assign) CGRect frame;

-(id)initWithX:(float)x Y:(float)y Rect:(CGRect) frame;

-(id)initWithFillColor:(QFillColor *)color X:(float)x Y:(float)y Rect:(CGRect) frame;

-(void)enqueue:(QModifierQueue *)queue;

-(void)update;

-(void)updateMotion:(Vector2D *)motion;

@end
