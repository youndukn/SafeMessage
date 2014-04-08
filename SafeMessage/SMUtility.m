//
//  SMUtility.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMUtility.h"

#import <Parse/Parse.h>

#import "SMConstants.h"

@implementation SMUtility

+ (UIColor *)submitColor{
    return [UIColor colorWithRed:112/255.0f  green:204/255.0f blue:131/255.0f alpha:1];
}
+ (UIColor *)changeColor{
    return [UIColor colorWithRed:246/255.0f  green:141/255.0f blue:93/255.0f alpha:1];
}

+ (NSString *)getChannelString{
    if([PFInstallation currentInstallation].channels){
        return[[PFInstallation currentInstallation].channels objectAtIndex:0];
    }
    return nil;
}

+ (NSNumber *)getSafeNumber{
    NSNumber *mySafeNumber = [[PFInstallation currentInstallation] valueForKey:kSMInstallationSafeNumberKey];
    if(mySafeNumber)
        return mySafeNumber;
    return nil;
}

+ (int)getStartSafeNumber:(int)numberOfUsers{
    int i=1;
    do {
        i*=10;
    } while (numberOfUsers/i*(1.0f/(1.0f-fSMSafeNumberEmptyPercent))<10.0f);
    return i;
}

@end
