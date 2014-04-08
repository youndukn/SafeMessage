//
//  SMAppDelegate.h
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

@interface SMAppDelegate : UIResponder <UIApplicationDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) UINavigationController *navController;

@end
