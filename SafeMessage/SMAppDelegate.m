//
//  SMAppDelegate.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMAppDelegate.h"

#import <Parse/Parse.h>

#import "SMMessagesViewController.h"
#import "SMLoginViewController.h"

#import "SMConstants.h"
#import "SMUtility.h"

@interface SMAppDelegate(){
}
@property (nonatomic, strong) SMMessagesViewController *mainViewController;

@end

@implementation SMAppDelegate

@synthesize mainViewController;
@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Parse setApplicationId:@"hgt5y09gMHd7qlWRw1jOQUNPcdMI42mgQsunRcTq"
                  clientKey:@"iSvcCL5nkn45iidygJ3bcwlzreN30QNoJHgo5hKi"];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    [self setupAppearance];
    
    self.mainViewController = [[SMMessagesViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)setupAppearance {
    // Navigation bar appearance (background and title)
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [SMUtility gTitleColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:@"FontNAme" size:20.0f], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setBarTintColor:[SMUtility gBackgroundColor]];
    [[UIBarButtonItem appearance] setTintColor:[SMUtility gTitleColor]];
    [[UINavigationBar appearance] setTintColor:[SMUtility gTitleColor]];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
}



- (void)presentLoginViewControllerAnimated:(BOOL)animated {
    SMLogInViewController *logInViewController = [[SMLogInViewController alloc] init];
    [logInViewController setDelegate:self];
    
    [self.mainViewController presentViewController:logInViewController animated:NO completion:nil];
}

- (void)loginViewController:(SMLogInViewController *)loginViewController didLogInUser:(PFUser *)user{
    [self.navController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loginViewController:(SMLogInViewController *)loginViewController didSignUpUser:(PFUser *)user{
    [self loginViewController:loginViewController didLogInUser:user];
}


- (void)logOut {

    // Unsubscribe from push notifications by clearing the channels key (leaving only broadcast enabled).
    [[PFInstallation currentInstallation] setObject:@[@""] forKey:kSMInstallationChannelsKey];
    [[PFInstallation currentInstallation] removeObjectForKey:kSMInstallationChannelsKey];
    [[PFInstallation currentInstallation] saveInBackground];
    
    // Log out
    [PFUser logOut];
    
    // clear out cached data, view controllers, etc
    [self.navController popToRootViewControllerAnimated:NO];
    
    [self presentLoginViewControllerAnimated:YES];
    
    self.mainViewController = nil;

}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}


@end
