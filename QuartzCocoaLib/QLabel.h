//
//  QLabel.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "QFramework.h"
#import "QModifierQueue.h"
#import "QAbstractContextModifier.h"
#import "QBoundedObject.h"
#import "QColor.h"

/**
 A label is used to draw text in the graphics context
 using the Core text api.
 This is a simple means of drawing text to the screen.
 **/
@interface QLabel : QRectangle<QBoundedObject> {
	
	NSString *text;
	QColor *color;
	NSString *font;
	int fontSize;
	float textX;
	float textH;
	BOOL isFlipped;
}

/**
 Position of text x
 **/
@property(assign) float textX;

/**
 Position of text y.
 **/
@property(assign) float textY;

/**
 The text to display in the label.
 **/
@property(retain) NSString *text;


/**
 The font to display in the label.
 **/
@property(retain) NSString *font;


/**
 The color to display the text with.
 **/
@property(retain) QColor *color;

@property(assign) int fontSize;


/**
 Determine whether the coordinate system is flipped for drawing.
 It it is not flipped on the iOS the x axis will be flipped before drawing text.
 This affects iOS only.
 **/
@property(assign) BOOL isFlipped;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;

-(id)initWithText:(NSString *)t X:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;

-(id)initWithText:(NSString *)t Rect:(CGRect) rect;

-(id)initWithText:(NSString *)t Font:(NSString *)f X:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;

-(id)initWithText:(NSString *)t Font:(NSString *)f Rect:(CGRect) rect;

-(void)update:(QContext*) context;

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
