//
//  AddGame.h
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface AddGame : UIViewController {
    
    NSNumber *gamePrice;
    NSString *gameName;
    PFUser *current;
    
    IBOutlet UITextField *enteredName;
    IBOutlet UITextField *enteredPrice;
    IBOutlet UIButton *addGame;
    
}

- (IBAction)clear:(id)sender;
- (IBAction)addGame:(id)sender;
- (BOOL)connectionCheck;

@end
