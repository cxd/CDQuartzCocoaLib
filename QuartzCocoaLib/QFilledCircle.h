//
//  QFilledCircle.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 16/01/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "QCircle.h"

/**
 A filled circle is used to fill a circle with the current fill colour defined in the context.
 **/
@interface QFilledCircle : QCircle {

}

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;
-(id)initX:(float)cx Y:(float)cy Radius:(float)rad;
-(id)initWithCentre:(QPoint *)cp Radius:(float)rad;
-(void)dealloc;
-(void)update:(QContext *)context;

#pragma mark Encoder.
-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;


@end
