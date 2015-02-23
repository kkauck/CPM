//
//  CreateLogin.h
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface CreateLogin : UIViewController {
    
    IBOutlet UITextField *newUsername;
    IBOutlet UITextField *newPassword;
    IBOutlet UIButton *createButton;
    
    NSString *enteredPassword;
    NSString *enteredUsername;
    
}

- (IBAction)createAccount:(id)sender;

@end