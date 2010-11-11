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

- (IBAction) openDocument: sender  //IB Action to invoke the standard Open File panel.
{
	NSArray *fileTypes = [NSArray arrayWithObjects: @"cdquartzgraph", @"CDQuartzGraph", nil];
	NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	[openPanel setAllowedFileTypes:fileTypes];
	[openPanel
	 beginSheetForDirectory:NSHomeDirectory()
	 file:nil
	 modalForWindow:window  
	 modalDelegate:self  
	 didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:)  
	 contextInfo:NULL];  
}

// This method gets called when the user hits the return button on the open panel.
- (void) openPanelDidEnd:(NSOpenPanel *)sheet returnCode:(int)returnCode contextInfo:(void  *)contextInfo
{
	if (returnCode != NSOKButton)
		return;
	if (self.graphView == nil)
		return;
	// decode the graph.
	NSString *file = [sheet filename];
	@try {
		CDQuartzGraph *graph;
		graph = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
		[self.graphView swapGraph:graph];
	}
	@catch (NSException * e) {
		NSLog(@"%@ %@ %@", [e name], [e reason], [e description]);
	}
}

- (IBAction)saveDocument:(id)sender  //IB action to invoke the Save panel.
{
	NSArray *fileTypes = [NSArray arrayWithObjects: @"cdquartzgraph", @"CDQuartzGraph", nil];
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	[savePanel setAllowedFileTypes:fileTypes];
	[[NSSavePanel savePanel]
	 beginSheetForDirectory:NSHomeDirectory() 
	 file:nil
	 modalForWindow:window   
	 modalDelegate:self  
	 didEndSelector:@selector(savePanelDidEnd:returnCode:contextInfo:) 
	 contextInfo:NULL];
}

- (void)savePanelDidEnd:(NSSavePanel *)sheet returnCode:(int)returnCode contextInfo:(void  *)contextInfo
{
	if (returnCode != NSOKButton) return;
	if (self.graphView == nil) return;
	NSString *file = [sheet filename];
	@try {
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.graphView.graph];
		[NSKeyedArchiver archiveRootObject:self.graphView.graph
												   toFile:file];
		NSString *error = nil;
		
		NSData *debugData = [NSPropertyListSerialization
							 dataFromPropertyList:data
							format:NSPropertyListXMLFormat_v1_0
							 errorDescription:&error];
		NSString *debugFile = [file stringByAppendingString:@".debug"];
		[debugData writeToFile:debugFile atomically:YES];
	}
	@catch (NSException * e) {
		NSLog(@"%@ %@ %@", [e name], [e reason], [e description]);	}
	@finally {
		
	}
}

@end
