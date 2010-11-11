//
//  QShadow.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 4/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QColor.h"

@interface QShadow : QAbstractContextModifier {
	float offset;
	float yoffset;
	float blur;
	QColor *color;
	CGColorSpaceRef colorSpace; 
	CGColorRef colorRef;
}

@property(assign) float offset;
@property(assign) float yoffset;
@property(assign) float blur;
@property(retain) QColor* color;
@property(assign) CGColorSpaceRef colorSpace;
@property(assign) CGColorRef colorRef;

-(id)init;
-(id)initWithBlur:(float)b O:(float)o;
-(id)initWithColor:(QColor*)col;
-(id)initWithBlur:(float)b O:(float)o C:(QColor *)col;
-(id)initWithBlur:(float)b O:(float)o YO:(float)y;
-(id)initWithBlur:(float)b O:(float)o YO:(float)y C:(QColor *)col;

-(void)update:(QContext *)context;
-(void)dealloc;

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
