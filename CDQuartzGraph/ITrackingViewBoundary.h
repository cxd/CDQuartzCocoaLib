//
//  TrackingViewBoundary.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 27/09/10.
//  Copyright 2010 none. All rights reserved.
//
#import "CDQuartzGraphHeader.h"

#ifdef UIKIT_EXTERN 

#import <UIKit/UIKit.h>

#else

#import <Cocoa/Cocoa.h>

#endif

@protocol ITrackingViewBoundary

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
