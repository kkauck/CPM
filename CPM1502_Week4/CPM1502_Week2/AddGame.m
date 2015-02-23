//
//  AddGame.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "AddGame.h"
#import "Reachability.h"

@implementation AddGame

@synthesize updateID,updatePrice,updateTitle, addGame;

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
    
    if ([updateID isEqualToString:@""]){
        
        [addGame setTitle:@"Add Game" forState:UIControlStateNormal];
        
    } else {
        
        [addGame setTitle:@"Update Game" forState:UIControlStateNormal];
        enteredName.text = updateTitle;
        enteredPrice.text = updatePrice;
        
    }
    
}

- (void) resumedView{
    
    if([self connectionCheck]){
        
        [self connectionValid];
        
    } else {
     
        [self connectionInvalid];
        
    }
    
}

- (IBAction)addGame:(id)sender{
    
    if ([updateID isEqualToString:@""]){
    
        NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
        [formater setNumberStyle:NSNumberFormatterDecimalStyle];
        
        gameName = enteredName.text;
        gamePrice = [formater numberFromString:enteredPrice.text];
        
        if(!gamePrice && [gameName isEqualToString:@""]){
            
            [self invalidData];
            
        } else if (!gamePrice) {
            
            [self invalidPrice];
            
        } else  if ([gameName isEqualToString:@""]){
            
            [self invalidTitle];
            
        } else {
            
            [PFACL setDefaultACL:[PFACL ACL] withAccessForCurrentUser:YES];
            
            PFObject *gameData = [PFObject objectWithClassName:@"Game"];
            gameData[@"user"] = current;
            gameData[@"title"] = gameName;
            gameData[@"price"] = gamePrice;
            
            [gameData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded){
                    
                    UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Created New Game" message:@"We have successfully created your new game" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *userCreated = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        enteredName.text = @"";
                        enteredPrice.text = @"";
                        
                        [success dismissViewControllerAnimated:YES completion:nil];
                        
                    }];
                    
                    [success addAction:userCreated];
                    [self presentViewController:success animated:YES completion:nil];
                    
                }
                
            }];
            
        }
        
    } else {
        
        NSNumberFormatter *formater = [[NSNumberFormatter alloc] init];
        [formater setNumberStyle:NSNumberFormatterDecimalStyle];
        
        gameName = enteredName.text;
        gamePrice = [formater numberFromString:enteredPrice.text];
        
        if(!gamePrice && [gameName isEqualToString:@""]){
            
            [self invalidData];
            
        } else if (!gamePrice) {
            
            [self invalidPrice];
            
        } else  if ([gameName isEqualToString:@""]){
            
            [self invalidTitle];
            
        } else {
            
            [PFACL setDefaultACL:[PFACL ACL] withAccessForCurrentUser:YES];
            
            PFQuery *getData = [PFQuery queryWithClassName:@"Game"];
            
            [getData getObjectInBackgroundWithId:updateID block:^(PFObject *gameData, NSError *error) {
                
                gameData[@"user"] = current;
                gameData[@"title"] = gameName;
                gameData[@"price"] = gamePrice;
                
                [gameData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded){
                        
                        UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Created New Game" message:@"We have successfully created your new game" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *userCreated = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            enteredName.text = @"";
                            enteredPrice.text = @"";
                            
                            [self dismissViewControllerAnimated:YES completion:nil];
                            [success dismissViewControllerAnimated:YES completion:nil];
                            
                        }];
                        
                        [success addAction:userCreated];
                        [self presentViewController:success animated:YES completion:nil];
                        
                    }

                    }];
                
            }];
        }
        
    }
    
}

- (BOOL)connectionCheck{
    
    Reachability *findConnection = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [findConnection currentReachabilityStatus];
    return netStatus != NotReachable;
    
}

- (void) connectionValid{
    
    addGame.enabled = true;
    
    current = [PFUser currentUser];
    
}

- (void) connectionInvalid{
    
    addGame.enabled = false;
    
    UIAlertController *noConnection = [UIAlertController alertControllerWithTitle:@"No Network Connection" message:@"We are sorry we could not detect any connection, please try again when you have a network connection." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [noConnection dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [noConnection addAction:closeAlert];
    
    [self presentViewController:noConnection animated:YES completion:nil];
    
    
}

- (void) invalidData{
    
    UIAlertController *invalidData = [UIAlertController alertControllerWithTitle:@"Invalid Title & Price" message:@"Please make sure you entered a game title as well as a valid price for the game, example 9.99 - Do not use $." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [invalidData dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [invalidData addAction:closeAlert];
    
    [self presentViewController:invalidData animated:YES completion:nil];
    
}

- (void) invalidTitle{
    
    
    UIAlertController *invalidData = [UIAlertController alertControllerWithTitle:@"Invalid Title" message:@"Please make sure you entered a valid game title." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [invalidData dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [invalidData addAction:closeAlert];
    
    [self presentViewController:invalidData animated:YES completion:nil];
    
}

- (void) invalidPrice{
    
    UIAlertController *invalidData = [UIAlertController alertControllerWithTitle:@"Invalid Price" message:@"Please make sure you entered a valid price, example 9.99 - Do not use $." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *closeAlert = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [invalidData dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    [invalidData addAction:closeAlert];
    
    [self presentViewController:invalidData animated:YES completion:nil];
    
}

- (IBAction)clear:(id)sender{
    
    enteredName.text = @"";
    enteredPrice.text = @"";
    
}

@end
