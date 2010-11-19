//
//  CDGraphView.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 22/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
@interface
#ifdef UIKIT_EXTERN
 CDGraphView : UIView<IEditNodeDelegate>
#else
 CDGraphView : NSView<IEditNodeDelegate> 
#endif
{
	
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
	
#ifdef UIKIT_EXTERN
	/**
	 Scroll view reference.
	 Used if the view is nested within a parent view.
	 **/
	UIScrollView *parentScrollView;
	
	/**
	 An editable field to allow the user to modify the
	 text of a node.
	 **/
	UITextField *labelField;
	
#else
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
	
	
#endif
		
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

#ifdef UIKIT_EXTERN

/**
 Scroll view reference.
 Used if the view is nested within a parent view.
 **/
@property(retain) IBOutlet UIScrollView *parentScrollView;

/**
 An editable field to allow the user to modify the
 text of a node.
 **/
@property(retain) IBOutlet 	UITextField *labelField;

#else
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
 A replacement method for the "setNeedsDisplay" provided in UIKit.
 This will set the needs display flag to true.
 **/
-(void)setNeedsDisplay;

#endif
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
-(void)onStartTextEdit:(CGPoint) point size:(CGSize) sz;

#ifndef UIKIT_EXTERN
/**
 TODO: implement colour selection for Cocoa Touch.
 Hint use a bitmap colour picker or HSV plenty of articles on how to do this.
 
 Receive the event for colour changes.
 This will change the fill colour of the selected node.
 **/
-(void)onColorChangeNotification:(NSNotification*)notification;

#endif

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


#ifdef UIKIT_EXTERN

/**
 Receive the change font event.
 The default behaviour is to change the
 font of the selected node.
 **/
-(void)onChangeFont:(UIFont *)font;

/**
 Begin tracking the touch for the supplied index..
 **/
-(void)beginTracking:(UITouch *)touch atIndex:(int)idx;

/**
 The touch has moved, track the movement for the supplied index.
 **/
-(void)moveTracked:(UITouch *)touch atIndex:(int)idx;

/**
 The touch is no longer active for the supplied index.
 **/
-(void)endTracking:(UITouch *)touch atIndex:(int)idx;

/**
 Test the connections for a touch that may reside
 within a connection boundary.
 **/
-(void)testConnections:(UITouch *)touch;

/**
 Because NSTrackingArea is not provided in cocoa touch
 instead we always search for a touch location
 within the boundaries of each edge connector shape.
 If it is then we add it to the hoverShapes collection in the state.
 This simulates the result that "mouseMoved" would have if tracking
 was supported.
 **/
-(void)updateLocationOfHoverOnConnection:(UITouch *)touch;

#else
/**
 Receive the change font event.
The default behaviour is to change the
 font of the selected node.
 **/
-(void)onChangeFont:(NSFont *)font;

#endif
@end
