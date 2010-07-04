//
//  TestQuartzIPhoneAppDelegate.m
//  TestQuartzIPhone
//
//  Created by Chris Davey on 5/07/09.
//  Copyright none 2009. All rights reserved.
//

#import "TestQuartzIPhoneAppDelegate.h"
#import "TestQuartzIPhoneViewController.h"

@implementation TestQuartzIPhoneAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
