//
//  PouredDroplet.h
//  Pour
//
//  Created by Chris Davey on 3/08/09.
//  Copyright 2009 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCocoaLib.h"


@interface PouredDroplet : NSObject {
	float centreX;
	float centreY;
	float acceleration;
	float radius;
	float angle;
	QArc *arc;
}
@property(assign) float centreX;
@property(assign) float centreY;
@property(assign) float acceleration;
@property(assign) float radius;
@property(assign) float angle;
@property(retain) QArc *arc;

-(id)initWithX:(float) x Y:(float) y Radius:(float) r;

-(id)initWithX:(float) x Y:(float) y Radius:(float) r Aceleration:(float) a;

@end
