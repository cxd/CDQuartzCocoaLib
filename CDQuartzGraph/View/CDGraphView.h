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

#import "IEditNodeDelegate.h"

/**
 The Graph View provides support for drawing graphs within an NSView. 
 **/
@interface CDGraphView : NSView<IEditNodeDelegate> {
	/**
	 Internal graph instance.
	 **/
	CDQuartzGraph *graph;
	
	id<GraphLayoutAlgorithm> algorithm;
	
	CDGraphViewState *state;
	
	/**
	 The selected shape that is used to edit a label
	 or other attributes.
	 **/
	CDQuartzNode *selected;
	
	/**
	 A flag to indicate whether the view should delete.
	 **/
	BOOL shouldDelete;
	
	/**
	 A flag to determine whether a menu is being used to edit the label of the node.
	 **/
	BOOL editLabel;
	
	/**
	 The modifier queue.
	 **/
	QModifierQueue *queue;
	
	/**
	 Scroll view reference.
	 Used if the view is nested within a parent view.
	 **/
	NSScrollView *parentScrollView;
	
	/**
	 An editable field to allow the user to modify the
	 text of a node.
	 **/
	NSTextField *labelField;
	
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
 The selected shape that is used to edit a label
 or other attributes.
 **/
@property(retain) CDQuartzNode *selected;

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
 A flag to determine whether a menu is being used to edit the label of the node.
 **/
@property(assign) BOOL editLabel;

/**
 Scroll view reference.
 Used if the view is nested within a parent view.
 **/
@property(retain) IBOutlet NSScrollView *parentScrollView;

/**
 An editable field to allow the user to modify the
 text of a node.
 **/
@property(retain) IBOutlet 	NSTextField *labelField;

/**
 Save the graph to the supplied file path.
 **/
-(BOOL)saveGraphToFilePath:(NSString *)filePath;

/**
 Open the graph from the supplied file path.
 **/
-(BOOL)openGraphFromFilePath:(NSString *)filePath;

/**
 Swap the current graph out for a new graph.
 This effectively replaces the graph within the view state.
 **/
-(void)swapGraph:(CDQuartzGraph *)newGraph;

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
 Begin text editing.
 **/
-(void)onStartTextEdit:(NSPoint) point size:(NSSize) sz;

/**
 Receive the event for colour changes.
 This will change the fill colour of the selected node.
 **/
-(void)onColorChangeNotification:(NSNotification*)notification;

/**
 Begin text editing.
 **/
-(void)onEndTextEdit;


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

/**
 Receive the change font event.
The default behaviour is to change the
 font of the selected node.
 **/
-(void)onChangeFont:(NSFont *)font;

@end
