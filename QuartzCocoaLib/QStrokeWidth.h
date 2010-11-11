//
//  QStrokeWidth.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"

@interface QStrokeWidth : QAbstractContextModifier {
	float width;
}
@property(assign) float width;

-(id)init;
-(id)initWidth:(float)w;
-(void)update:(QContext*)context;

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
