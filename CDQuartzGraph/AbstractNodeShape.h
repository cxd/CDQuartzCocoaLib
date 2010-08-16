//
//  AbstractNodeShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AbstractGraphShape.h"
#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "ShapeDelegate.h"
#import "AbstractPortShape.h"

@interface AbstractNodeShape : AbstractGraphShape {

	/**
	 A collection of connectors associated with this shape.
	 **/
	NSMutableArray *ports;
	
}

/**
 A collection of connectors associated with this shape.
 **/
@property(retain) NSMutableArray *ports;


/**
 Default initialisation.
 **/
-(id)init;

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b;


-(void)dealloc;

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point;

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point;

/**
 Update the context.
 **/
-(void)update:(QContext *)context;

@end
