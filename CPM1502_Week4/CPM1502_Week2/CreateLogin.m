//
//  CreateLogin.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "CreateLogin.h"
#import "Reachability.h"

@implementation CreateLogin

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumedView) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    if([self connectionCheck]){
        
        [self connectionValid];
        
    } else {
        
        [self connectionInvalid];
        
    }
    
}

- (void) resumedView{
    
    if([self connectionCheck]){
        
        [self connectionValid];
        
    } else {
        
        [self connectionInvalid];
        
    }
    
}

- (void) connectionValid{
    
    createButton.enabled = true;
    
}

- (void) connectionInvalid{
    
    createButton.enabled = false;
    
    UIAlertController *noConnection = [UIAlertController alertControllerWithTitle:@"No Network Connection" message:@"We are sorry we could not detect any connection, please try again when you have a network connection." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [noConnection dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [noConnection addAction:closeAlert];
    
    [self presentViewController:noConnection animated:YES completion:nil];
    
}

- (IBAction)createAccount:(id)sender{
    
    enteredUsername = newUsername.text;
    enteredPassword = newPassword.text;
    
    if ([newUsername.text isEqual: @""] || [newPassword.text  isEqual: @""]){
        
        //Creates an alert that lets the user know the save failed.
        UIAlertController *cannotCreate = [UIAlertController alertControllerWithTitle:@"Cannot Create Account" message:@"We are sorry but we could not create a new account, please check the username and password." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [cannotCreate dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
        [cannotCreate addAction:closeAlert];
        
        [self presentViewController:cannotCreate animated:YES completion:nil];

        
    } else {
    
        PFUser *newUser = [PFUser user];
        newUser.username = enteredUsername;
        newUser.password = enteredPassword;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error){
                
                //Upon successfully saving the user an alert pops up with an action that will dismiss the alert and return the user to the login page.
                UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Created Account" message:@"We have successfully created your new account" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *userCreated = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    newUsername.text = @"";
                    newPassword.text = @"";
                    
                    [success dismissViewControllerAnimated:YES completion:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                
                [success addAction:userCreated];
                [self presentViewController:success animated:YES completion:nil];
                
            }
            
        }];
        
    }
    
}

- (BOOL)connectionCheck{
    
    Reachability *findConnection = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [findConnection currentReachabilityStatus];
    return netStatus != NotReachable;
    
}

@end
