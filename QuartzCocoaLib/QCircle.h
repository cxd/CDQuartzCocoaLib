//
//  QCircle.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 10/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QPoint.h"
#import "QBoundedObject.h"
#import "QArc.h"

/**
 A circle serves as the base class for circle shapes.
 It extends the QArc.
 
 **/
@interface QCircle : QArc {

}
/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;
-(id)initX:(float)cx Y:(float)cy Radius:(float)rad;
-(id)initWithCentre:(QPoint *)cp Radius:(float)rad;
-(void)dealloc;


#pragma mark Encoder.
-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
