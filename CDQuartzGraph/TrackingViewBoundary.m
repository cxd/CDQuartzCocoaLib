//
//  TrackingViewArea.m
//  CDQuartzGraph
//
//  Created by Chris Davey on 28/09/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#import "TrackingViewBoundary.h"


@implementation TrackingViewBoundary



/**
 initialise.
 **/
-(id)init
{
	self = [super init];
	return self;
}

#ifdef UIKIT_EXTERN 

@synthesize trackBounds;

-(void)dealloc {
	if (self.trackBounds != nil)
	{
		[self.trackBounds autorelease];	
	}
	[super dealloc];	
}


/**
 Associate with view.
 **/
-(void)attach:(UIView *)view InBoundary:(QRectangle *)bounds
{
	if (self.trackBounds != nil)
	{
		[self.trackBounds autorelease];	
		self.trackBounds = nil;
	}
	self.trackBounds = bounds;
	[self.trackBounds retain];
}

/**
 Remove the tracking area from the view.
 **/
-(void)remove:(UIView *)fromView
{
	if (self.trackBounds != nil)
	{
		[self.trackBounds autorelease];	
		self.trackBounds = nil;
	}
}

/**
 Update the boundary.
 This is achieved by removing the track area from the view
 and creating a new track area.
 **/
-(void)updateBoundary:(QRectangle *)bounds
{
	if (self.trackBounds != nil)
	{
		[self.trackBounds autorelease];	
		self.trackBounds = nil;
	}
	self.trackBounds = bounds;
	[self.trackBounds retain];
}



/**
 Check to see if the touch resides within the tracked boundary.
 **/
-(BOOL)isTouchInBounds:(UIView *)fromView withTouch:(UITouch *)touch
{
	CGPoint point = [touch locationInView:fromView];
	CGPoint clickLocation = [fromView convertPoint:point fromView:nil];
	// the view is inverted so we need to convert to the correct coordinates.
	float x = (float)clickLocation.x;
	float y =  [fromView frame].size.height - (float)clickLocation.y;
	QPoint *p = [[QPoint alloc] initX:x Y:y];
	[p retain];
	BOOL result = [self.trackBounds contains:p];
	[p autorelease];
	return result;
}

#else

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
