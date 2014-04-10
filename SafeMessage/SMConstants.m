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

#pragma mark - Installation Class

NSString *const kSMUserSafeNumberKey = @"safeNumber";

#pragma mark - Installation Class

NSString *const kSMInstallationChannelsKey = @"channels";

#pragma mark - Notifications

NSString *const SMLoginConrollerUsernameFoundNotification           = @"com.parse.SafeMessage.loginController.didRecieveUsernameNotification";


@end
