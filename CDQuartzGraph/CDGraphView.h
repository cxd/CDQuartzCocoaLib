//
//  CDGraphView.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 22/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDQuartzGraph.h"
#import "CDQuartzNode.h"
#import "CDQuartzEdge.h"

#import "QuartzCocoaLib/QuartzCocoaLib.h"
#import "CDGraph/CDGraph.h"

#import "ShapeDelegate.h"
#import "Drawable.h"

#import "AbstractGraphShape.h"
#import "AbstractNodeShape.h"
#import "AbstractConnectorShape.h"

@interface CDGraphView : NSView {
	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	CDQuartzNode *trackNode;
}

/**
 Internal graph instance.
 **/
@property(assign) CDQuartzGraph *graph;

@property(assign) CDQuartzNode *trackNode;

@end
