//
//  CreateLogin.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "CreateLogin.h"

@implementation CreateLogin

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
}

- (IBAction)createAccount:(id)sender{
    
    enteredUsername = newUsername.text;
    enteredPassword = newPassword.text;
    
    if ([newUsername isEqual: @""] || [newPassword  isEqual: @""]){
        
        //Creates an alert that lets the user know the save failed.
        UIAlertController *failed = [UIAlertController alertControllerWithTitle:@"Failed Account Creation" message:@"Sorry but we failed to create your account, please check username and password" preferredStyle:UIAlertControllerStyleAlert];
        [failed presentViewController:failed animated:YES completion:nil];
        
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

@end
