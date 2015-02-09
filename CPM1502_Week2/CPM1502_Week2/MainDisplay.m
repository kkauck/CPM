//
//  MainDisplay.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "MainDisplay.h"

@implementation MainDisplay

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
}

- (IBAction)logout:(id)sender{
    
    //This will logout the user and set the current user to nil so it will not auto log back in at app launch.
    [PFUser logOut];
    PFUser *current = [PFUser currentUser];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
