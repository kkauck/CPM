//
//  MainDisplay.m
//  CPM1502_Week2
//
//  Created by Kyle K on 02/09/2015.
//  Copyright (c) 2015 Kyle Kauck. All rights reserved.
//

#import "MainDisplay.h"
#import "Reachability.h"
#import "AddGame.h"

@implementation MainDisplay

- (void) viewDidLoad{
    
    [super viewDidLoad];
    
    //This is used to ensure the resumedView is called whenever it is brought back into the foreground from being minimized on the phone.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumedView) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

    //This will be called to check the network connection is valid the add game button is enabled and if it is not then an alert will let the user know and they will be backed out of this screen.
- (void)viewDidAppear:(BOOL)animated{
    
    if([self connectionCheck]){
        
        [self connectionValid];
        
    } else {
        
        [self connectionInvalid];
        
    }

    
}

    //This is a function that is called for when the user has the application minimized and when it is brought back into the foreground is called and checks to make sure the user has a connection.
- (void)resumedView{
    
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

- (void)getGameData:(PFUser *)user {
    
    PFQuery *getData = [PFQuery queryWithClassName:@"Game"];
    [getData whereKey:@"user" equalTo:user];
    [getData findObjectsInBackgroundWithBlock:^(NSArray *games, NSError *error) {
        
        gameData = [[NSMutableArray alloc] initWithArray:games];
        [gameTable reloadData];
        
    }];
    
}

- (void)updateGameData{
    
    PFQuery *getData = [PFQuery queryWithClassName:@"Game"];
    [getData whereKey:@"user" equalTo:current];
    [getData findObjectsInBackgroundWithBlock:^(NSArray *games, NSError *error) {
        
        gameData = [[NSMutableArray alloc] initWithArray:games];
        [gameTable reloadData];
        
    }];
    
    
}

- (void) connectionValid{
    
    addGame.enabled = true;
    
    current = [PFUser currentUser];
    
    [self getGameData:current];
    
    [NSTimer scheduledTimerWithTimeInterval:20.0f target:self selector:@selector(updateGameData) userInfo:nil repeats:true];
    
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


- (IBAction)logout:(id)sender{
    
    //This will logout the user and set the current user to nil so it will not auto log back in at app launch.
    [PFUser logOut];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [gameData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    
    if (cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"customCell"];
        
    }
    
    PFObject *currentGame = [gameData objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentGame objectForKey:@"title"];
    
    NSNumber *price = [currentGame objectForKey:@"price"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%.2f", price.doubleValue];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *currentGame = [gameData objectAtIndex:indexPath.row];
    [currentGame deleteInBackground];
    
    [self updateGameData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"updateGame"]){
        
        AddGame *updateGame = segue.destinationViewController;
        
        if (updateGame != nil){
            
            UITableViewCell *cell = (UITableViewCell *)sender;
            NSIndexPath *indexPath = [gameTable indexPathForCell:cell];
            
            PFObject *currentGame = [gameData objectAtIndex:indexPath.row];
            updateGame.updateTitle = [currentGame objectForKey:@"title"];
            updateGame.updateID = currentGame.objectId;
            
            NSNumber *price = [currentGame objectForKey:@"price"];
            updateGame.updatePrice = [NSString stringWithFormat:@"%.2f", price.doubleValue];
            
        }
        
    } else if ([segue.identifier isEqualToString:@"addGame"]){
        
        AddGame *createGame = segue.destinationViewController;
        
        if (createGame != nil){
            
            createGame.updateID = @"";
            createGame.updatePrice = @"";
            createGame.updateTitle = @"";
            
        }
        
    }
    
}

- (IBAction)exitView:(UIStoryboardSegue *)closeView{
    
}

@end
