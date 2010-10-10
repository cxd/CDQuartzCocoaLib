//
//  CDGraphView.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 22/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"
#import "CDQuartzNode.h"
#import "CDQuartzEdge.h"


#import "ShapeDelegate.h"
#import "Drawable.h"

#import "AbstractGraphShape.h"
#import "AbstractNodeShape.h"
#import "AbstractConnectorShape.h"
#import "BezierLineConnector.h"

#import "GraphLayoutAlgorithm.h"
#import "CDGraphViewState.h"

/**
 The Graph View provides support for drawing graphs within an NSView. 
 **/
@interface CDGraphView : NSView {
	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	id<GraphLayoutAlgorithm> algorithm;
	
	CDGraphViewState *state;
	
	/**
	 A flag to indicate whether the view should delete.
	 **/
	BOOL shouldDelete;
	
	/**
	 The modifier queue.
	 **/
	QModifierQueue *queue;
	
	/**
	 Scroll view reference.
	 Used if the view is nested within a parent view.
	 **/
	NSScrollView *parentScrollView;
}

/**
 Internal graph instance.
 **/
@property(retain) CDQuartzGraph *graph;

/**
 The state associated with the view.
 **/
@property(retain) CDGraphViewState *state;

/**
 A reference to a graph layout algorithm.
 **/
@property(retain) id<GraphLayoutAlgorithm> algorithm;

/**
 The modifier queue.
 **/
@property(retain) QModifierQueue *queue;


/**
 A flag to indicate whether the view should delete.
 **/
@property(assign) BOOL shouldDelete;

/**
 Scroll view reference.
 Used if the view is nested within a parent view.
 **/
@property(retain) IBOutlet NSScrollView *parentScrollView;

/**
 The method used to create the initial graph by the view.
 Override this method in derived classes in order to generate
 the default graph.
 **/
-(CDQuartzGraph *)createGraph;

/**
 Handle event from bounds changing.
 Will be used when this graph view is housed within a scroll view.
 **/
-(void)boundsDidChange:(NSNotification *)notification;

/**
 Prepare the view to allow connections.
 **/
-(void)onStartConnection;

/**
 Update the view to disallow connections.
 **/
-(void)onEndConnection;

/**
 Receive select action from ui.
 **/
-(IBAction)onSelect:(id)sender;

/**
 Receive add action from UI.
 **/
-(IBAction)onAdd:(id)sender;

/**
 Receive delete action from UI.
 **/
-(IBAction)onDelete:(id)sender;

/**
 Add a new connection to the graph.
 **/
-(IBAction)onAddConnect:(id)sender;

/**
 Receive connect action from UI.
 **/
-(IBAction)onConnect:(id)sender;

/**
 Receive disconnect action from UI.
 **/
-(IBAction)onDisconnect:(id)sender;

/**
 Receive edit action from UI.
 **/
-(IBAction)onEdit:(id)sender;


@end
