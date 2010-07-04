//
//  QArc.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QPoint.h"
#import "QBoundedObject.h"
#import "math.h"

@interface QArc : QAbstractContextModifier<QBoundedObject> {
	QPoint* centre;
	float radius;
	float startAngle;
	float endAngle;
	BOOL isClockwise;
	BOOL isStart;
	BOOL isEnd;
}

@property(retain) QPoint* centre;
@property(assign) float radius;
@property(assign) float startAngle;
@property(assign) float endAngle;
@property(assign) BOOL isClockwise;
@property(assign) BOOL isStart;
@property(assign) BOOL isEnd;


-(id)initWithX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float) sa EndAngle:(float)ea;
-(id)initWithCentre:(QPoint *)cp Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea;
-(id)initWithX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e;
-(id)initWithCentre:(QPoint *)cp Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e;
-(id)initWithX:(float)cx Y:(float)cy Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e CLOCKWISE:(BOOL)cw ;
-(id)initWithCentre:(QPoint *)cp Radius:(float)rad StartAngle:(float)sa EndAngle:(float)ea START:(BOOL) s END:(BOOL) e CLOCKWISE:(BOOL)cw ;
-(void)dealloc;
-(void)update:(QContext*)context;
-(QRectangle*)getBoundary;
@end
