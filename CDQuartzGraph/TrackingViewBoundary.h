//
//  TrackingViewArea.h
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

#import <Foundation/Foundation.h>
#import "ITrackingViewBoundary.h"

@interface TrackingViewBoundary : NSObject<ITrackingViewBoundary> {

	
#ifdef UIKIT_EXTERN 

	/**
	 A boundary area representing
	 the are to track.
	 **/
	QRectangle *trackBounds;
#else
	
	NSTrackingArea *trackArea;
	
#endif
	
}

/**
 initialise.
 **/
-(id)init;

-(void)dealloc;


/**
 Update the boundary.
 **/
-(void)updateBoundary:(QRectangle *)bounds;


#ifdef UIKIT_EXTERN 

/**
 A boundary area representing
 the are to track.
 This is a weak reference.
 **/
@property(assign) QRectangle *trackBounds;

/**
 Associate with view.
 **/
-(void)attach:(UIView *)view InBoundary:(QRectangle *)bounds;

/**
 Remove the tracking area from the view.
 **/
-(void)remove:(UIView *)fromView;

/**
 Check to see if the touch resides within the tracked boundary.
 **/
-(BOOL)isTouchInBounds:(UIView *)fromView withTouch:(UITouch *)touch;

#else

/**
 Associate with view.
 **/
-(void)attach:(NSView *)view InBoundary:(QRectangle *)bounds;

/**
 Remove the tracking area from the view.
 **/
-(void)remove:(NSView *)fromView;

#endif

@end
