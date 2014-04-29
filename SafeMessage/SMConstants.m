//
//  SMConstants.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMConstants.h"

@implementation SMConstants

#pragma mark - Inset Numbers
float const sideInset = 30.0f;
float const topInset = 40.0f;
float const fieldHeight = 40.0f;

#pragma mark - Safe Number
int const iSMPremiumLength = 2;

#pragma mark - User Class
NSString *const kSMUserClassKey = @"User";

NSString *const kSMUserUsernameKey = @"username";
NSString *const kSMUserFriendsKey = @"friends";
NSString *const kSMUserFixedMessagesKey = @"fixedMessages";
NSString *const kSMUserFriendsCategoryKey = @"friendsCategory";

#pragma mark - Users Relation
NSString *const kSMRelationUserClassKey = @"RelationUser";

NSString *const kSMRelationUserFromUserKey = @"fromUser";
NSString *const kSMRelationUserToUserKey = @"toUser";
NSString *const kSMRelationUserCategoryKey = @"category";

NSString *const kSMRelationUserCategoryNoneValue = @"none";

#pragma mark - FixedMessages Class
NSString *const kSMFixedMessagesClassKey = @"FixedMessage";

NSString *const kSMFixedMessagesUserKey = @"user";

#pragma mark - Installation Class
NSString *const kSMInstallationChannelsKey = @"channels";

#pragma mark - Notifications

#pragma mark - NSDefault
NSString *const kSMNSUserDefaultPreviousUserKey = @"previousUser";

@end
