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

-(id)initWithX: (float)x Y: (float)y X2: (float)xx Y2:(float)yy CX1:(float) cx1 CY1: (float) cy1 CX2:(float) cx2 CY2: (float)cy2;
-(id)initWidthX: (float)x Y:(float)y X2:(float)xx Y2:(float) yy CX1:(float) cx1 CY1: (float) cy1 CX2:(float) cx2 CY2: (float)cy2 START:(BOOL) s END:(BOOL) e;
-(id)initWithStart: (QPoint *)from Finish: (QPoint *)to CtPoint1: (QPoint *)p1 CtPoint2: (QPoint*) p2;
-(id)initWidthStart: (QPoint *)from Finish: (QPoint *)to CtPoint1: (QPoint *)p1 CtPoint2: (QPoint*) p2 START:(BOOL) s END:(BOOL) e;
-(QRectangle*)getBoundary;

@end
