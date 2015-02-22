//
//  ViewController.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/08/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "ViewController.h"
#import "MainDisplay.h"
#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumedView) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    if([self connectionCheck]){
        
        [self connectionValid];
        
    } else {
        
        [self connectionInvalid];
        
    }
    
}

- (BOOL)connectionCheck{
    
    Reachability *findConnection = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [findConnection currentReachabilityStatus];
    return netStatus != NotReachable;
    
}

- (void) resumedView{
    
    if([self connectionCheck]){
        
        [self connectionValid];
        
    } else {
        
        [self connectionInvalid];
        
    }

    
}

- (void) connectionValid{
    
    loginButton.enabled = true;
    createButton.enabled = true;
    
    PFUser *current = [PFUser currentUser];
    if (current){
        
        MainDisplay *display = [self.storyboard instantiateViewControllerWithIdentifier:@"toViewDisplay"];
        [self presentViewController:display animated:YES completion:nil];
        
        current.ACL = [PFACL ACLWithUser:current];
        
    }
    
}

- (void) connectionInvalid{
    
    loginButton.enabled = false;
    createButton.enabled = false;
    
    UIAlertController *noConnection = [UIAlertController alertControllerWithTitle:@"No Network Connection" message:@"We are sorry we could not detect any connection, please try again when you have a network connection." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [noConnection dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [noConnection addAction:closeAlert];
    
    [self presentViewController:noConnection animated:YES completion:nil];
    
}


-(IBAction)login:(id)sender{
    
    if ([self connectionCheck]){
        
        [self networkConnected];
        
    }
    
}

- (void)networkConnected{
    
    username = enteredUsername.text;
    password = enteredPassword.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        
        if (user){
            
            UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Logged In" message:@"You have successfully logged in!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                enteredUsername.text = @"";
                enteredPassword.text = @"";
                
                [success dismissViewControllerAnimated:YES completion:nil];
                MainDisplay *display = [self.storyboard instantiateViewControllerWithIdentifier:@"toViewDisplay"];
                [self presentViewController:display animated:YES completion:nil];
                
            }];
            
            [success addAction:cancel];
            [self presentViewController:success animated:YES completion:nil];
            
            
        } else {
            
            UIAlertController *failed = [UIAlertController alertControllerWithTitle:@"Failed Login" message:@"Please check your username and password and try again." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                
                [failed dismissViewControllerAnimated:YES completion:nil];
                
            }];
            
            [failed addAction:cancel];
            [self presentViewController:failed animated:YES completion:nil];
            
        }
        
    }];

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
