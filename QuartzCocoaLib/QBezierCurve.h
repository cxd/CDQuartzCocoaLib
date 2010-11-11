//
//  QBezierCurve.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QLine.h"

@interface QBezierCurve : QLine {
	QPoint* control1;
	QPoint* control2;
}

@property(retain) QPoint* control1;
@property(retain) QPoint* control2;


-(void)dealloc;
-(void)update:(QContext *)context;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;

-(id)initX: (float)x Y: (float)y X2: (float)xx Y2:(float)yy CX1:(float) cx1 CY1: (float) cy1 CX2:(float) cx2 CY2: (float)cy2;
-(id)initX: (float)x Y:(float)y X2:(float)xx Y2:(float) yy CX1:(float) cx1 CY1: (float) cy1 CX2:(float) cx2 CY2: (float)cy2 START:(BOOL) s END:(BOOL) e;
-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to CtPoint1: (QPoint *)p1 CtPoint2: (QPoint*) p2;
-(id)initWidthStart: (QPoint *)from Finish: (QPoint *)to CtPoint1: (QPoint *)p1 CtPoint2: (QPoint*) p2 START:(BOOL) s END:(BOOL) e;
-(QRectangle*)getBoundary;

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder;
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
