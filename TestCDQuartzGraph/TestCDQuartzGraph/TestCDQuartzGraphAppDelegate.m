//
//  TestCDQuartzGraphAppDelegate.m
//  TestCDQuartzGraph
//
//  Created by Chris Davey on 18/08/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TestCDQuartzGraphAppDelegate.h"

@implementation TestCDQuartzGraphAppDelegate

@synthesize window;
@synthesize graphView;
@synthesize defaultFont;

-(void)dealloc
{
if (self.graphView != nil)
{
	[self.graphView autorelease];	
}
	if (self.defaultFont != nil)
	{
		[self.defaultFont autorelease];	
	}
	[super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	self.defaultFont = [NSFont userFontOfSize:12.0f];
	[[NSFontManager sharedFontManager] setSelectedFont:self.defaultFont isMultiple:NO];
}

-(void)changeFont:(id)sender
{
	if (self.graphView == nil)
		return;
	NSFont *oldFont = [sender selectedFont];
    NSFont *newFont = [sender convertFont:oldFont];
	[self.graphView onChangeFont:newFont];
}

@end
