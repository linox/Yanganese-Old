//
//  ScoreSelectionViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreSelectionViewController.h"
#import "ResultViewController.h"

@implementation ScoreSelectionViewController

- (void)viewDidLoad {
	self.title = @"History";
	
    [super viewDidLoad];
	
    //TODO: remove?
    // undo changes made in superclass
	self.navigationItem.hidesBackButton = NO;
	self.navigationItem.leftBarButtonItem = nil;
}	

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// initialize next view controllers properties
    ResultViewController *next = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
	next.title = [quizTitleList objectAtIndex:[indexPath row]];
	NSDictionary *info = [quizDict objectForKey:next.title];
	next.scoreString = [info objectForKey:@"Score"];
	next.percentageArray = [info objectForKey:@"Percent"];
	next.timeString = nil;
	
	[self.navigationController pushViewController:next animated:YES];
}

@end
