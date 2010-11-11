//
//  QMove.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 5/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QPoint.h"

@interface QMove : QAbstractContextModifier {
	QPoint *position;
}
@property(retain) QPoint *position;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;
-(id)initX:(float)x Y:(float)y;
-(id)initWithPoint:(QPoint *)p;
-(void)dealloc;
-(void)update:(QContext *)context;

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
