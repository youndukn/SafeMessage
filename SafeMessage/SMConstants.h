//
//  SMConstants.h
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMConstants : NSObject

#pragma mark - Safe Number

//Maximum of the preimium Number
extern int const iSMMaxPremiumNumber;
//Percent Decider
extern float const fSMSafeNumberEmptyPercent;

#pragma mark - User Class

extern NSString *const kSMUserUsernameKey;
extern NSString *const kSMUserSafeNumberKey;
extern NSString *const kSMUserFixedMessagesKey;

#pragma mark - FixedMessages Class

extern NSString *const kSMFixedMessagesClassKey;
extern NSString *const kSMFixedMessagesUserKey;

#pragma mark - Installation Class

extern NSString *const kSMInstallationChannelsKey;

#pragma mark - Notifications

extern NSString *const kSMLoginConrollerUsernameFoundNotification;

#pragma mark - NSUserDefault

extern NSString *const kSMNSUserDefaultPreviousUserKey;


@end
