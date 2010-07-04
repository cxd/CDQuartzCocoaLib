/*
 *  QBoundedObject.h
 *  QuartzCocoaLib
 *
 *  Created by Chris Davey on 5/07/09.
 *  Copyright 2009 none. All rights reserved.
 *
 */
#import "QFramework.h"
#import "QRectangle.h"

@protocol QBoundedObject

/**
 Get the boundary of the object.
 **/
-(QRectangle *)getBoundary;

@end
