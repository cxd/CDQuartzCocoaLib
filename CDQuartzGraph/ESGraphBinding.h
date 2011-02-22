//
//  EcmascriptGraphBinding.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 6/02/11.
//  Copyright 2011 cd. All rights reserved.
//

#import "CDQuartzGraphHeader.h"
#import <WebKit/WebKit.h>
#import "CDGraphViewState.h"
#import "CDGraphView.h"
#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraph.h"
#import "CDQuartzNode.h"
#import "CDQuartzEdge.h"
#import "ESShapeDescription.h"
#import "ESBounds.h"
#import "ESGraphParser.h"

/**
 The ecmascript graph binding provides support for ecmascript api calls to generate a graph.
 This support is provided via an interpretation of the ecmascript JSON representation of
 the graph data structure.
 When the ecmascript processes the graph representation it will make calls into this 
 library to build the resulting graph object in a state based process.
 
 All graphs created with the ecmascript interface will use Strings for the node data.
 
 This object will interact with the graph view to provide scripting capabilities for
 the underlying model.
 **/
@interface ESGraphBinding : NSObject {

	/**
	 Web viw object.
	**/
	WebView *webView;
	/**
	 Reference to the web script object provided by the web view.
	 **/
	WebScriptObject *scriptObject;
	/**
	 The state object associated with the graph.
	 **/
	CDGraphViewState *state;
	
	CDGraphView *graphView;
	
	NSTextView *textView;
	
	/**
	 The script data supplied by the user.
	 **/
	NSString *scriptData;
}


@property(retain, nonatomic) IBOutlet WebView *webView;

@property(retain, nonatomic) WebScriptObject *scriptObject;

@property(retain, nonatomic) IBOutlet CDGraphViewState *state;

@property(retain, nonatomic) IBOutlet CDGraphView *graphView;

@property(retain, nonatomic) IBOutlet NSTextView *textView;

@property(retain, nonatomic) NSString* scriptData;

/**
 Parse and display the graph.
 **/
-(IBAction)parseDisplayGraph:(id)sender;

/**
 Apply the changes from the view to the graph.
 **/
-(IBAction)applyChanges:(id)sender;

/**
 Process the supplied graph.
 **/
-(NSString *)ecmascriptForGraph;

@end
