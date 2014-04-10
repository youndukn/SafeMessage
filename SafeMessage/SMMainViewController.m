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

#import "SMAppDelegate.h"
#import "SMConstants.h"
#import "SMUtility.h"

@interface SMMainViewController ()
@property (nonatomic, strong) UITextField *safeNumberField;
@property (nonatomic, strong) UISwitch *loginSwitch;
@property (nonatomic, strong) UIButton *myNumberButton;
@end

@implementation SMMainViewController

@synthesize safeNumberField;
@synthesize loginSwitch;
@synthesize myNumberButton;

const float sideInset = 10.0f;
const float topInset = 40.0f;
const float fieldHeight = 60.0f;
const float buttonHeight = 40.0f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(![PFUser currentUser]){
        [(SMAppDelegate *)[[UIApplication sharedApplication] delegate] presentLoginViewControllerAnimated:NO];
        return;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];

    //Set Navigation Items
    self.navigationItem.title = @"안전문자";
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    
    //LoginButton
    loginSwitch = [[UISwitch alloc] init];
    [loginSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:loginSwitch];
    
    //Change Button
    NSString *myNumberString = @"번호 바꾸기:";
    
    if([PFUser currentUser]){
        [loginSwitch setOn:YES];
        //[myNumberString stringByAppendingString:[[SMUtility getSafeNumber] stringValue]];
    }else{
        [loginSwitch setOn:NO];
        //myNumberString = @"번호 받기";
    }
    
    [self setMySafeNumber:myNumberString];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //SafeNumberField
    safeNumberField = [[UITextField alloc] initWithFrame:CGRectMake(sideInset, topInset*2, screenRect.size.width-sideInset*2, fieldHeight)];
    
    [safeNumberField setPlaceholder:@"안전번호"];
    [safeNumberField setTextAlignment:NSTextAlignmentCenter];
    [safeNumberField setFont:[UIFont systemFontOfSize:30]];
    [safeNumberField setBorderStyle:UITextBorderStyleRoundedRect];
    [safeNumberField setKeyboardType:UIKeyboardTypeNumberPad];
    
    [self.view addSubview:safeNumberField];
    
    //Submit Button
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(sideInset, topInset*2+fieldHeight+topInset/2, screenRect.size.width-sideInset*2, buttonHeight)];
    
    [submitButton setTitle:@"자동차 빼주세요" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [submitButton setBackgroundColor:[SMUtility submitColor]];
    [submitButton addTarget:self action:@selector(submitMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setState:(id)sender{
    if([sender isOn]){
        
    }else{
        [(SMAppDelegate *)[[UIApplication sharedApplication] delegate] logOut];
    }
}

- (void)submitMessage{
    if([safeNumberField.text length] > 0){
        
    }
}




- (void)setMySafeNumber:(NSString *)numberString{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    if(!myNumberButton){
        
        myNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(sideInset, topInset*2+fieldHeight+topInset/2+topInset+5, screenRect.size.width-sideInset*2, buttonHeight)];
        
        [myNumberButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [myNumberButton setBackgroundColor:[SMUtility changeColor]];
        [myNumberButton addTarget:self action:@selector(createOrEditChannel) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:myNumberButton];
    }
    
    [myNumberButton setTitle:numberString forState:UIControlStateNormal];
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
