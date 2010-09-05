//
//  AbstractPortShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 15/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "AbstractGraphShape.h"
#import "ShapeDelegate.h"

@interface AbstractPortShape : AbstractGraphShape {

	/**
	 Parent shape associated with this port.
	 **/
	AbstractGraphShape *parent;
	
}

/**
 A weak reference to Parent shape associated with this port.
 Does not retain the parent reference.
 **/
@property(assign) AbstractGraphShape *parent;

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p;

/**
 Initialise with the parent of the port.
 **/
-(id)initWithParent:(AbstractGraphShape *)p AndBounds:(QRectangle *)r;

@end
