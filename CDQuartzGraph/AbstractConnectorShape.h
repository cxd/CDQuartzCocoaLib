//
//  AbstractConnectorShape.h
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

@interface AbstractConnectorShape : AbstractGraphShape {
	/**
	 A shape that is drawn at the start of the connection.
	 **/
	AbstractGraphShape *startDecoration;
	/**
	 A shape that is drawn at the end of the connection.
	 **/
	AbstractGraphShape *endDecoration;
	
	/**
	 A reference to the start port.
	 **/
	AbstractPortShape *startPort;
	
	/**
	A reference to the end port.
	 **/
	AbstractPortShape *endPort;
}

/**
 A shape that is drawn at the start of the connection.
 **/
@property(retain) AbstractGraphShape *startDecoration;
/**
 A shape that is drawn at the end of the connection.
 **/
@property(retain) AbstractGraphShape *endDecoration;

/**
 A reference to the start port.
 **/
@property(retain) AbstractPortShape *startPort;

/**
 A reference to the end port.
 **/
@property(retain) AbstractPortShape *endPort;



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
 Connect the start line to supplied port.
 **/
-(void)connectStartTo:(AbstractPortShape *)port;

/**
 Connect the end line to supplied port.
 **/
-(void)connectEndTo:(AbstractPortShape *)port;

/**
 Update the context.
 **/
-(void)update:(QContext *)context;

@end
