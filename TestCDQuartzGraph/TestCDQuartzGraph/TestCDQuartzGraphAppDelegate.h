//
//  TestCDQuartzGraphAppDelegate.h
//  TestCDQuartzGraph
//
//  Created by Chris Davey on 18/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDQuartzGraph/CDGraphView.h"

@interface TestCDQuartzGraphAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	/**
	 A reference to the graph view.
	 **/
	CDGraphView *graphView;
	
	NSFont *defaultFont;
}

@property (assign) IBOutlet NSWindow *window;

@property(retain) IBOutlet CDGraphView *graphView;

@property(retain) NSFont *defaultFont;

@end
