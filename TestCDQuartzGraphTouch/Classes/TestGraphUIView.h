//
//  TestGraphUIView.h
//  TestCDQuartzGraphTouch
//
//  Created by Chris Davey on 7/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDQuartzGraphHeader.h"
#import "CDQuartzGraphLib.h"

@interface TestGraphUIView : CDGraphView {
	/**
	 a reference to the toolbar.
	 **/
	UIToolbar* toolbar;
}

/**
 a reference to the toolbar.
 **/
@property(retain) IBOutlet UIToolbar* toolbar;

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
