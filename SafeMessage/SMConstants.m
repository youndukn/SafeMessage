//
//  SMConstants.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMConstants.h"

@implementation SMConstants

#pragma mark - Safe Number

int const iSMMaxPremiumNumber = 9999;
float const fSMSafeNumberEmptyPercent = 0.25;

#pragma mark - User Class

NSString *const kSMUserUsernameKey = @"username";
NSString *const kSMUserSafeNumberKey = @"safeNumber";
NSString *const kSMUserFixedMessagesKey = @"fixedMessages";

#pragma mark - FixedMessages Class

NSString *const kSMFixedMessagesClassKey = @"FixedMessage";
NSString *const kSMFixedMessagesUserKey = @"user";

#pragma mark - Installation Class

NSString *const kSMInstallationChannelsKey = @"channels";

#pragma mark - Notifications

NSString *const kSMLoginConrollerUsernameFoundNotification           = @"com.parse.SafeMessage.loginController.didRecieveUsernameNotification";

#pragma mark - NSDefault

NSString *const kSMNSUserDefaultPreviousUserKey = @"previousUser";

@end
