//
//  SMProfileViewController.m
//  SafeMessage
//
//  Created by Younduk Nam on 4/12/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMProfileViewController.h"

#import <Parse/Parse.h>

#import "SMAppDelegate.h"

#import "SMAppDelegate.h"
#import "SMConstants.h"
#import "SMUtility.h"

@interface SMProfileViewController ()

@property (nonatomic, strong) UIButton *myNumberButton;
@end

@implementation SMProfileViewController

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
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    //Change Button
    NSString *myNumberString = @"번호 바꾸기:";
    
    if([[SMUtility getSafeNumber] stringValue]){
        [myNumberString stringByAppendingString:[[SMUtility getSafeNumber] stringValue]];
    }
    
    [self setMySafeNumber:myNumberString];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
