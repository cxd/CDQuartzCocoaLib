//
//  QLabel.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 30/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
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
}
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
-(id)initWithText:(NSString *)t X:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;

-(id)initWithText:(NSString *)t Rect:(CGRect) rect;

-(id)initWithText:(NSString *)t Font:(NSString *)f X:(float)xcoord Y:(float)ycoord WIDTH:(float)w HEIGHT:(float)h;

-(id)initWithText:(NSString *)t Font:(NSString *)f Rect:(CGRect) rect;

-(void)update:(QContext*) context;

@end