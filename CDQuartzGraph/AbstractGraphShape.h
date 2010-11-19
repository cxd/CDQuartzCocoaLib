//
//  AbstractGraphShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#import "CDQuartzGraphHeader.h"
#import "ShapeDelegate.h"
#import "ITrackingViewBoundary.h"
#import "TrackingViewBoundary.h"

/**
 The abstract shape delegate provides the base
 class for extension when generating graph shapes.
 **/
@interface AbstractGraphShape : QShape<ShapeDelegate> {
	/**
	 The bounds of the shape.
	 **/
	QRectangle *bounds;
	/**
	 Fill color for the shape.
	 **/
	QColor *fillColor;
	/**
	 Outline color for the shape.
	 **/
	QColor *outlineColor;
	/**
	 Weight of the outline.
	 **/
	float outlineWeight;
	
	/**
	 The displacement of this shape.
	 **/
	QPoint* displacement;
	
	/**
	 The label associated with the shape.
	 **/
	NSString *label;
	
	/**
	 The label shape associated with the graph object.
	 **/
	QLabel *labelShape;
	/**
	 The text color associated with the label.
	 **/
	QColor *textColor;
	/**
	 Determine whether the label is queued for presentation.
	 **/
	BOOL labelQueued;
	
	/**
	 A flag used to determine whether the shape is highlighted.
	 **/
	BOOL isHighlighted;
	
	/**
	 Tracking view associated with the object.
	 **/
	TrackingViewBoundary *trackingView;
	
	/**
	 A shape that can be used to display if highlighted.
	 It is drawn beneath the current shape.
	 **/
	AbstractGraphShape* highlightShape;
}

/**
 The bounds of the shape.
 **/
@property(retain) QRectangle *bounds;

/**
 Fill color for the shape.
 **/
@property(retain) QColor *fillColor;
/**
 Outline color for the shape.
 **/
@property(retain) QColor *outlineColor;
/**
 Weight of the outline.
 **/
@property(assign) float outlineWeight;

/**
 Displacement of graph shape.
 **/
@property(retain) QPoint* displacement;

/**
 The label associated with the shape.
 **/
@property(retain) NSString *label;

/**
 The label shape associated with the graph object.
 **/
@property(retain) QLabel *labelShape;

/**
 The text color associated with the label.
 **/
@property(retain) QColor *textColor;

/**
 A flag used to determine whether the shape is highlighted.
 **/
@property(assign) BOOL isHighlighted;

/**
 Tracking view associated with the object.
 **/
@property(retain) TrackingViewBoundary *trackingView;

/**
 A shape that can be used to display if highlighted.
 It is drawn beneath the current shape.
 **/
@property(retain) AbstractGraphShape* highlightShape;


/**
 Attach observers.
 **/
-(void)attachObservers;

/**
 Receive key value observing events.
 **/
-(void)observeValueForKeyPath:(NSString *)keyPath
					 ofObject:(id)object
					   change:(NSDictionary *)change
					  context:(void *)context;

/**
 Event raised when outline weight has changed.
 **/
-(void)onOutlineWeightChanged;

/**
 Event raised when fill color changed.
 **/
-(void)onFillColorChanged;

/**
 Event raised when outline color changed.
 **/
-(void)onOutlineColorChanged;

/**
 Default initialisation.
 **/
-(id)init;

/**
 Default initialisation.
 **/
-(id)initWithLabel:(NSString *)l;

/**
 Initialise with bounds.
 **/
-(id)initWithBounds:(QRectangle *)b;

/**
 Initialise with bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l;


/**
 Initialise with tracking areas bounds and label.
 **/
-(id)initWithBounds:(QRectangle *)b AndLabel:(NSString *)l;

/*
 Dealloc.
 */
-(void)dealloc;


/**
 Create the label to render.
 **/
-(void)createLabel;

/**
 Check whether a point occurs within the bounds
 of this object.
 **/
-(BOOL)isWithinBounds:(QPoint *)point;

/**
 Check whether a rectangle intersects with the rectangle
 of this object.
 **/
-(BOOL)intersects:(QRectangle *)other;

/**
 Move by a relative offset.
 **/
-(void)moveBy:(QPoint *)point;

/**
 Move to an absolute position.
 **/
-(void)moveTo:(QPoint *)point;

/**
 Resize by with and height.
 **/
-(void)resizeToWidth:(int)w height:(int)h; 

/**
 Overridden to update the context with the text label.
 **/
-(void)update:(QContext*) context;

#ifdef UIKIT_EXTERN 


/**
 Attach the tracking area to a view.
 **/
-(void)attachTrackingAreaToView:(UIView *)view;

/**
 Remove the tracking area from the view.
 **/
-(void)removeTrackingAreaFromView:(UIView *)view;


#else

/**
 Attach the tracking area to a view.
 **/
-(void)attachTrackingAreaToView:(NSView *)view;

/**
 Remove the tracking area from the view.
 **/
-(void)removeTrackingAreaFromView:(NSView *)view;

#endif

/**
 Change the label.
 **/
-(void)changeLabel:(NSString *)newLabel;

#pragma mark Encoder and Decoder.
/**
 Read data from an nscoder.
 **/
-(id)initWithCoder:(NSCoder *)aDecoder;
/**
 Write data to an nscoder.
 **/
-(void)encodeWithCoder:(NSCoder *)aCoder;

@end
