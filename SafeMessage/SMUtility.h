//
//  SMUtility.h
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMUtility : NSObject

//Color
+ (UIColor *)submitColor;
+ (UIColor *)changeColor;

//SafeNumber
+ (NSString *)getChannelString;
+ (NSNumber *)getSafeNumber;

//Utility
+ (int)getStartSafeNumber:(int)numberOfUsers;

@end
