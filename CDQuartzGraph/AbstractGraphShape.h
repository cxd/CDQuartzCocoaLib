//
//  AbstractGraphShape.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 14/08/10.
//  Copyright 2010 none. All rights reserved.
//

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

// TODO: define tracking boundary protocol for ui kit.

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


@end
