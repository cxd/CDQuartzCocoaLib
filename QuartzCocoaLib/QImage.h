//
//  QImage.h
//  QuartzCocoaLib
//
//  Created by Chris Davey on 5/07/09.
//  Copyright 2009 none. All rights reserved.
//

#import "QFramework.h"
#import "QAbstractContextModifier.h"
#import "QPoint.h"
#import "QBoundedObject.h"

@interface QImage : QAbstractContextModifier<QBoundedObject> {
	QPoint *anchor;
	float width;
	float height;
	CGImageRef imageRef;
}

@property(retain) QPoint *anchor;
@property(assign) float width;
@property(assign) float height;
@property(assign) CGImageRef imageRef;

/**
 Allow parameterless constructor for NSCoding.
 **/
-(id)init;

// load a file from a url.
-(id)initWithUrl:(NSString *)url X:(float)x Y:(float)y;
-(id)initWithUrl:(NSString *)url POINT:(QPoint *)p;
-(id)initWithUrl:(NSString *)url X:(float)x Y:(float)y Width:(float)w Height:(float)h;
-(id)initWithUrl:(NSString *)url POINT:(QPoint *)p Width:(float)w Height:(float)h;
-(id)initWithResource:(NSString *)resource X:(float)x Y:(float)y;
-(void)dealloc;
-(void)update:(QContext*)context;
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
