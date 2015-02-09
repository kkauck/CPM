//
//  ViewController.h
//  CPM1502_Week2
//
//  Created by Kyle K on 02/08/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController {
    
    NSString *username;
    NSString *password;
    IBOutlet UITextField *enteredPassword;
    IBOutlet UITextField *enteredUsername;
    
}

-(IBAction)login:(id)sender;


@end

