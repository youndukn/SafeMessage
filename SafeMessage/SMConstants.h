//
//  SMConstants.h
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMConstants : NSObject

#pragma mark - Inset Numbers

extern float const sideInset;
extern float const topInset;
extern float const fieldHeight;

#pragma mark - Safe Number
extern int const iSMPremiumLength;

#pragma mark - User Class
extern NSString *const kSMUserClassKey;

extern NSString *const kSMUserUsernameKey;
extern NSString *const kSMUserFriendsKey;
extern NSString *const kSMUserFriendsCategoryKey;
extern NSString *const kSMUserFixedMessagesKey;

#pragma mark - Users Relation
extern NSString *const kSMRelationUserClassKey;

extern NSString *const kSMRelationUserFromUserKey;
extern NSString *const kSMRelationUserToUserKey;
extern NSString *const kSMRelationUserCategoryKey;

extern NSString *const kSMRelationUserCategoryNoneValue;

#pragma mark - FixedMessages Class
extern NSString *const kSMFixedMessagesClassKey;
extern NSString *const kSMFixedMessagesUserKey;

#pragma mark - Installation Class
extern NSString *const kSMInstallationChannelsKey;

#pragma mark - Notifications

#pragma mark - NSUserDefault
extern NSString *const kSMNSUserDefaultPreviousUserKey;


@end
