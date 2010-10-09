//
//  TestGraphView.h
//  TestCDQuartzGraph
//
//  Created by Chris Davey on 18/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDQuartzGraph/CDQuartzGraphHeader.h"
#import "CDQuartzGraph/CDQuartzGraphLib.h"

@interface TestGraphView : CDGraphView {

	/**
	 a reference to the toolbar.
	**/
	NSToolbar* toolbar;
	
}

/**
 a reference to the toolbar.
 **/
@property(retain) IBOutlet NSToolbar* toolbar;

-(CDQuartzGraph *)createGraph;




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
