//
//  SMMainViewController.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMMainViewController.h"

#import <Parse/Parse.h>
#import "SMAppDelegate.h"

#import "SMConstants.h"
#import "SMUtility.h"

@interface SMMainViewController ()


@end

@implementation SMMainViewController

@synthesize safeNumberField;

@synthesize messageHolderView;

@synthesize messages;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(![PFUser currentUser]){
        [(SMAppDelegate *)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //SafeNumberField
    safeNumberField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 30.0f)];
    
    [safeNumberField setPlaceholder:@"Reciever"];
    [safeNumberField setTextAlignment:NSTextAlignmentCenter];
    [safeNumberField setFont:[UIFont systemFontOfSize:20]];
    [safeNumberField setBorderStyle:UITextBorderStyleRoundedRect];
    [safeNumberField setKeyboardType:UIKeyboardTypeDefault];
    [safeNumberField setTextColor:[SMUtility gMainColor]];
    if([[NSUserDefaults standardUserDefaults] objectForKey:kSMNSUserDefaultPreviousUserKey]){
        [safeNumberField setText:[[NSUserDefaults standardUserDefaults] objectForKey:kSMNSUserDefaultPreviousUserKey]];
    }
    
    self.navigationItem.titleView = safeNumberField;
    
}

- (void)setMessageButtons{
    
    //Submit Button
    if(!messageHolderView){
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        messageHolderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topInset*1+fieldHeight*2, screenRect.size.width, screenRect.size.height-topInset*2+fieldHeight)];
        [self.view addSubview:messageHolderView];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    int sideRL = sideInset;
    int middleRL = 8;
    int sideTB = 10;
    int middleTB = 5;
    
    for(UIView *view in [messageHolderView subviews]){
        [view removeFromSuperview];
    }
    
    messageHolderView.contentSize = CGSizeMake(screenRect.size.width, 40.0f*[messages count]+10*2 + middleTB*[messages count]);
    
    NSArray *messagesRect = [SMUtility getFramesWithColumns:1 Row:(int)([messages count]) Width:messageHolderView.contentSize.width Height:messageHolderView.contentSize.height SideRL:sideRL MiddleRL:middleRL SideTB:sideTB MiddleTB:middleTB];
    
    for(int i = 0; i < [messages count]; i++){
        UIButton *submitButton = [[UIButton alloc] initWithFrame:[[messagesRect objectAtIndex:i] CGRectValue]];
        
        [submitButton setTitle:[messages objectAtIndex:i] forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [submitButton setBackgroundImage:[SMUtility imageWithColor:[SMUtility gSubmitColor]] forState:UIControlStateNormal];
        [submitButton setBackgroundImage:[SMUtility imageWithColor:[SMUtility gSubmitPColor]] forState:UIControlStateHighlighted];
        
        [submitButton addTarget:self action:@selector(messagesButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [submitButton setTag:i];
        
        [self.messageHolderView addSubview:submitButton];
    }
    
}

- (void)messagesButtonPressed:(id)sender{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
