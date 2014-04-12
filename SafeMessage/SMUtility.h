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
+ (UIColor *)submitPColor;
+ (UIColor *)changeColor;
+ (UIColor *)changePColor;
+ (UIImage *)imageWithColor:(UIColor *)color;

//SafeNumber
+ (NSString *)getChannelString;
+ (NSNumber *)getSafeNumber;

//Utility
+ (int)getStartSafeNumber:(int)numberOfUsers;
+ (NSArray *)getFramesWithColumns:(int)columns Row:(int)rows
             Width:(float)width Height:(float)height
            SideRL:(float)sideRL MiddleRL:(float)middleRL
            SideTB:(float)sideTB MiddleTB:(float)middleTB;

@end
