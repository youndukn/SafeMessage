//
//  SMAppDelegate.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMAppDelegate.h"

#import <Parse/Parse.h>

#import "SMMainViewController.h"
#import "SMLoginViewController.h"

#import "SMConstants.h"
#import "SMUtility.h"

@interface SMAppDelegate(){
}
@property (nonatomic, strong) SMMainViewController *mainViewController;

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
    
    self.mainViewController = [[SMMainViewController alloc] init];
    
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


//Create or Edit Channel based on your channel Status
- (void)createOrEditChannel{
    
    PFUser *user = [PFUser currentUser];
    NSString *mySafeNumber = [user username];
    if(mySafeNumber){
        [self findNextAvailableSafeNumber:[mySafeNumber intValue] error:nil];
    }else{
        PFQuery *query = [PFUser query];
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
        [query countObjectsInBackgroundWithTarget:self selector:@selector(findNextAvailableSafeNumber:error:)];
    }
    
}

//Find the next availableSafeNumber
- (void)findNextAvailableSafeNumber:(int)numberOfRegistration error:(NSError *)error{
    
    if(error){
        //Error
        return;
    }
    
    int startSafeNumber = [SMUtility getStartSafeNumber:iSMMaxPremiumNumber+numberOfRegistration];
    int endSafeNumber = startSafeNumber*10;
    
    PFQuery *query = [PFUser query];
    [query whereKey:kSMUserSafeNumberKey greaterThan:[NSNumber numberWithInt:startSafeNumber]];
    [query whereKey:kSMUserSafeNumberKey lessThan:[NSNumber numberWithInt:endSafeNumber]];
    [query orderByAscending:kSMUserSafeNumberKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *users, NSError *error) {
        if([users count] > 0){
            int currentNumber = -1;
            bool isSelected = NO;
            while(!isSelected){
                int randomFromTo = arc4random() % (int)([users count]/1.2);
                int currentNumber =  randomFromTo;
                for(int i = randomFromTo; i < [users count]; i++){
                    if([[[users objectAtIndex:i] objectForKey:kSMUserSafeNumberKey] intValue] != currentNumber){
                        isSelected = YES;
                        break;
                    }
                    currentNumber+=1;
                }
            }
            if(currentNumber != -1)
                [self verifyAndSetChannel:currentNumber];
        }else{
            //error
        }
    }];
    
}

//Key Process
- (void)verifyAndSetChannel:(int)mySafeNumber{
    
    PFUser *user = [PFUser currentUser];
    [user setObject:[NSNumber numberWithInt:mySafeNumber] forKey:kSMUserSafeNumberKey];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            PFQuery *query = [PFUser query];
            [query whereKey:kSMUserSafeNumberKey equalTo:[[PFUser currentUser] objectForKey:kSMUserSafeNumberKey]];
            [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                if(number > 1){
                    //What happen if there is more than three always error
                    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                    [currentInstallation setObject:@[@""] forKey:kSMInstallationChannelsKey];
                    [self createOrEditChannel];
                }else if(number == 1){
                    //Success
                    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                    NSString *channelName = [NSString stringWithFormat:@"user_%d", [[[PFUser currentUser] objectForKey:kSMUserSafeNumberKey] intValue]];
                    [currentInstallation setChannels:@[@""]];
                    [currentInstallation setChannels:[NSArray arrayWithObject:channelName]];
                }else{
                    //error
                }
            }];
        }
    }];
    
}


- (void)presentLoginViewControllerAnimated:(BOOL)animated {
    SMLogInViewController *logInViewController = [[SMLogInViewController alloc] init];
    [logInViewController setDelegate:self];
    
    [self.mainViewController presentViewController:logInViewController animated:NO completion:nil];
}

- (void)loginViewController:(SMLogInViewController *)loginViewController didLogInUser:(PFUser *)user{
    
}

- (void)loginViewController:(SMLogInViewController *)loginViewController didSignUpUser:(PFUser *)user{
    
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
