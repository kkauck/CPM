//
//  AddGame.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "AddGame.h"

@implementation AddGame

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
}

- (IBAction)addGame:(id)sender{
    
    NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
    [formater setNumberStyle:NSNumberFormatterDecimalStyle];
    
    gameName = enteredName.text;
    gamePrice = [formater numberFromString:enteredPrice.text];
        
    [PFACL setDefaultACL:[PFACL ACL] withAccessForCurrentUser:YES];
        
    PFObject *gameData = [PFObject objectWithClassName:@"iOSGameData"];
    gameData[@"name"] = gameName;
    gameData[@"price"] = gamePrice;
        
    [gameData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
        if (succeeded){
                
            UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Created New Game" message:@"We have successfully created your new game" preferredStyle:UIAlertControllerStyleAlert];
                
            UIAlertAction *userCreated = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                enteredName.text = @"";
                enteredPrice.text = @"";
                    
                [success dismissViewControllerAnimated:YES completion:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                    
            }];
                
            [success addAction:userCreated];
            [self presentViewController:success animated:YES completion:nil];
                
            }
            
        }];
    
    
}

- (IBAction)clear:(id)sender{
    
    enteredName.text = @"";
    enteredPrice.text = @"";
    
}

@end
