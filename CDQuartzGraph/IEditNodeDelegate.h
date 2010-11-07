//
//  IEditShapeDelegate.h
//  CDQuartzGraph
//
//  Created by Chris Davey on 31/10/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDQuartzNode.h"


@protocol IEditNodeDelegate

/**
 Edit the supplied shape.
 **/
-(void)editNode:(CDQuartzNode *)shape;

@end
