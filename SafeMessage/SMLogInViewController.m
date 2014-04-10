//
//  SMLogiViewController.m
//  SafeMessage
//
//  Created by youndukn on 4/8/14.
//  Copyright (c) 2014 Younduk Nam. All rights reserved.
//

#import "SMLogInViewController.h"

#import "SMUtility.h"

#import "SMKeyboardHandler.h"
#import "SMKeyboardHandler.h"

@interface SMLogInViewController (){
    SMKeyboardHandler *keyboard;
}
@property (nonatomic, strong) UIImageView *fieldsBackground;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *logInButton;
@property (nonatomic, strong) UIButton *signUpButton;
@end

@implementation SMLogInViewController

@synthesize fieldsBackground;
@synthesize logo;
@synthesize usernameField;
@synthesize passwordField;
@synthesize logInButton;
@synthesize signUpButton;

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
    
    keyboard = [[SMKeyboardHandler alloc] init];
    keyboard.delegate = self;
    
    UITapGestureRecognizer *tapGuester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardAction)];
    [self.view addGestureRecognizer:tapGuester];
    
    
    //[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[self.view setBackgroundColor:[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1]];
    [self setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
    [self.view addSubview:logo];
    
    // Set field text color
    self.fieldsBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_loginfield.png"]];
    [self.view insertSubview:fieldsBackground atIndex:1];
    
    self.usernameField = [[UITextField alloc] init];
    [self.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.usernameField setPlaceholder:@"Username"];
    self.usernameField.textAlignment = NSTextAlignmentCenter;
    self.usernameField.tag = 0;
    self.usernameField.delegate = self;
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] init];
    [self.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
    [self.passwordField setPlaceholder:@"Password"];
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.textAlignment = NSTextAlignmentCenter;
    self.passwordField.tag = 1;
    [self.passwordField setSecureTextEntry:YES];
    self.passwordField.delegate = self;
    [self.view addSubview:self.passwordField];
    
    // Set buttons appearance
    self.logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.logInButton setBackgroundImage:[SMUtility imageWithColor:[SMUtility submitColor]] forState:UIControlStateNormal];
    [self.logInButton setBackgroundImage:[SMUtility imageWithColor:[SMUtility submitPColor]] forState:UIControlStateHighlighted];
    [self.logInButton setTitle:@"로그인" forState:UIControlStateNormal];
    [self.logInButton setTitle:@"로그인" forState:UIControlStateHighlighted];
    [self.logInButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logInButton];
    
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.signUpButton setBackgroundImage:[SMUtility imageWithColor:[SMUtility changeColor]] forState:UIControlStateNormal];
    [self.signUpButton setBackgroundImage:[SMUtility imageWithColor:[SMUtility changePColor]] forState:UIControlStateHighlighted];
    [self.signUpButton setTitle:@"가입" forState:UIControlStateNormal];
    [self.signUpButton setTitle:@"가입" forState:UIControlStateHighlighted];
    [self.signUpButton addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpButton];
    
    
}

- (void)loginAction{
    if([self.usernameField.text length] == 0 || [self.passwordField.text length] == 0 ){
        return;
    }
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self.delegate loginViewController:self didLogInUser:user];
                                        } else {
                                            NSString *errorString = [[error userInfo] objectForKey:@"error"];
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"로그인할 수 없습니다" message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인",nil];
                                            [alert show];
                                        }
                                    }];
}

- (void)signUpAction{
    
    if([self.usernameField.text length] == 0 || [self.passwordField.text length] == 0){
        return;
    }
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate loginViewController:self didSignUpUser:user];
        } else {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            // Show the errorString somewhere and let the user try again.
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"가입 할수 없습니다" message:errorString delegate:self cancelButtonTitle:@"돌아가기" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float inset = 35.0f;
    // Set frame for elements
    [self.logo setFrame:CGRectMake(screenRect.size.width/2-logo.image.size.width/4, 50.0f, logo.image.size.width/2, logo.image.size.height/2)];
    [self.fieldsBackground setFrame:CGRectMake(inset, screenRect.size.height-230.0f, screenRect.size.width-inset*2, 100.0f)];
    [self.usernameField setFrame:CGRectMake(inset, screenRect.size.height-230.0f, screenRect.size.width-inset*2, 50.0f)];
    [self.passwordField setFrame:CGRectMake(inset, screenRect.size.height-180.0f, screenRect.size.width-inset*2, 50.0f)];
    [self.logInButton setFrame:CGRectMake(inset, screenRect.size.height-120.0f, screenRect.size.width-inset*2, 40.0f)];
    [self.signUpButton setFrame:CGRectMake(inset, screenRect.size.height-70.0f, screenRect.size.width-inset*2, 40.0f)];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if( textField.tag == 0){
        [textField resignFirstResponder];
        [self.passwordField becomeFirstResponder];
    }else if(textField.tag == 1){
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)keyboardSizeChanged:(CGSize)delta{
    CGRect frame = self.view.frame;
    frame.origin.y -= delta.height;
    self.view.frame = frame;
}

- (void)hideKeyboardAction{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
