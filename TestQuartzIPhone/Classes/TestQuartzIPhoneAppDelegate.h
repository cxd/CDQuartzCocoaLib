//
//  TestQuartzIPhoneAppDelegate.h
//  TestQuartzIPhone
//
//  Created by Chris Davey on 5/07/09.
//  Copyright none 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestQuartzIPhoneViewController;

@interface TestQuartzIPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TestQuartzIPhoneViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TestQuartzIPhoneViewController *viewController;

@end

