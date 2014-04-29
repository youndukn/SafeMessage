//
//  SMMainViewController.h
//  SafeMessage
//
//  Created by Younduk Nam on 4/2/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMMainViewController : UITableViewController
{

@protected
    UITextField *safeNumberField;
    NSArray *messages;
    UIScrollView *messageHolderView;
    
}

@property (nonatomic, strong) UITextField *safeNumberField;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) UIScrollView *messageHolderView;

- (void)setMessageButtons;
- (void)messagesButtonPressed:(id)sender;

@end
