//
//  TrackingViewArea.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 28/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import "TrackingViewBoundary.h"


@implementation TrackingViewBoundary

#ifdef UIKIT_EXTERN 
// TODO: define tracking boundary protocol for ui kit.

#else

/**
 initialise.
 **/
-(id)init
{
	self = [super init];
	return self;
}

-(void)dealloc
{
	if (trackArea != nil)
	{
		NSView *view = [trackArea owner];
		if (view != nil)
		{
			[view removeTrackingArea:trackArea];	
		}
		[trackArea autorelease];
	}
	[super dealloc];
}


/**
 Associate with view.
 **/
-(void)attach:(NSView *)view InBoundary:(QRectangle *)bounds
{
	if (trackArea != nil)
	{
		[trackArea autorelease];	
	}
	NSRect rect = CGRectMake(bounds.x, bounds.y, bounds.width, bounds.height);
	trackArea = [[NSTrackingArea alloc] initWithRect:rect
											options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
											 owner:view 
										  userInfo:nil];
	[trackArea retain];
	[view addTrackingArea:trackArea];
}

/**
 Remove the tracking area from the view.
 **/
-(void)remove:(NSView *)fromView
{
	if (trackArea == nil)
	{
		return;	
	}
	[fromView removeTrackingArea:trackArea];
	[trackArea autorelease];
	trackArea = nil;
}

/**
 Update the boundary.
 This is achieved by removing the track area from the view
 and creating a new track area.
 **/
-(void)updateBoundary:(QRectangle *)bounds
{
	if (trackArea == nil) return;
	NSView *view = [trackArea owner];
	[self remove:view];
	[self attach:view InBoundary:bounds];
}

#endif

@end
