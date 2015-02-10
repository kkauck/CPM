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

-(void) viewWillAppear:(BOOL)animated{
    
    current = [PFUser currentUser];
    
    [self getGameData:current];
    
}

- (void)getGameData:(PFUser *)user {
    
    PFQuery *getData = [PFQuery queryWithClassName:@"iOSGameData"];
    [getData findObjectsInBackgroundWithBlock:^(NSArray *games, NSError *error) {
        
        gameData = [[NSMutableArray alloc] initWithArray:games];
        [gameTable reloadData];
        
    }];
    
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
    cell.textLabel.text = [currentGame objectForKey:@"name"];
    
    NSNumber *price = [currentGame objectForKey:@"price"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", price];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *currentGame = [gameData objectAtIndex:indexPath.row];
    [currentGame deleteInBackground];
    
    [self getGameData:current];
    
}

@end
