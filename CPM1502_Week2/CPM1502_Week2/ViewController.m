//
//  ViewController.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/08/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "ViewController.h"
#import "MainDisplay.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    
    PFUser *current = [PFUser currentUser];
    if (current){
        
        MainDisplay *display = [self.storyboard instantiateViewControllerWithIdentifier:@"toViewDisplay"];
        [self presentViewController:display animated:YES completion:nil];
        
        current.ACL = [PFACL ACLWithUser:current];
        
    }
    
}

-(IBAction)login:(id)sender{
    
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
