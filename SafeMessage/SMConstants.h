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

#pragma mark - Installation Class

extern NSString *const kSMUserSafeNumberKey;

#pragma mark - Installation Class

extern NSString *const kSMInstallationChannelsKey;

#pragma mark - Notifications

extern NSString *const SMLoginConrollerUsernameFoundNotification;

@end
