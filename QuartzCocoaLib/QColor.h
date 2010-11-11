//
//  QColor.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//
#import "QFramework.h"
#import "QAbstractContextModifier.h"


@interface QColor : QAbstractContextModifier {
	float red;
	float green;
	float blue;
	float alpha;
}

@property(assign) float red;
@property(assign) float green;
@property(assign) float blue;
@property(assign) float alpha;


-(id)init;
-(id)initWithRGB:(float)r G:(float)g B:(float)b;
-(id)initWithRGBA:(float)r G:(float)g B:(float)b A:(float)a;
-(id)initWithQColor:(QColor *)color;
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
