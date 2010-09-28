//
//  TrackingViewArea.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 28/09/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITrackingViewBoundary.h"

#ifdef UIKIT_EXTERN 
// TODO: define tracking boundary protocol for ui kit.

#else

#endif

@interface TrackingViewBoundary : NSObject<ITrackingViewBoundary> {

	
#ifdef UIKIT_EXTERN 
	// TODO: define tracking boundary protocol for ui kit.
	
#else
	
	NSTrackingArea *trackArea;
	
#endif
	
}

/**
 initialise.
 **/
-(id)init;

-(void)dealloc;


#ifdef UIKIT_EXTERN 
// TODO: define tracking boundary protocol for ui kit.

#else


/**
 Associate with view.
 **/
-(void)attach:(NSView *)view InBoundary:(QRectangle *)bounds;

/**
 Remove the tracking area from the view.
 **/
-(void)remove:(NSView *)fromView;

/**
 Update the boundary.
 **/
-(void)updateBoundary:(QRectangle *)bounds;


#endif

@end
