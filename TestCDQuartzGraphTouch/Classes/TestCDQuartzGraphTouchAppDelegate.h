//
//  TestCDQuartzGraphTouchAppDelegate.h
//  TestCDQuartzGraphTouch
//
//  Created by Chris Davey on 7/09/10.
//  Copyright none 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestCDQuartzGraphTouchViewController;

@interface TestCDQuartzGraphTouchAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TestCDQuartzGraphTouchViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TestCDQuartzGraphTouchViewController *viewController;

@end

