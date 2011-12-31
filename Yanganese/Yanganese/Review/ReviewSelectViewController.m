//
//  ReviewSelectViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ReviewSelectViewController.h"
#import "ReviewViewController.h"

@implementation ReviewSelectViewController

@synthesize scoreFilepath;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSString *filePathString = [path stringByAppendingPathComponent:@"questions.plist"];
	self.filePath = filePathString;
	
	NSString *scorePath = [path stringByAppendingPathComponent:@"score.plist"];
	self.scoreFilepath = scorePath;
	
	NSDictionary *quizFiles = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	
	self.allQuizzes = quizFiles;
	
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = nil;
}



- (void)viewWillAppear:(BOOL)animated {
	self.quizDict = nil;
	
	NSDictionary *quizFiles = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	self.allQuizzes = quizFiles;
		
	[super resetSearch];
	
	[self.tableView reloadData];
	
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	NSDictionary *scoreDict = [[NSDictionary alloc] initWithContentsOfFile:scoreFilepath];
	if([scoreDict objectForKey:[quizTitleList objectAtIndex:[indexPath row]]] == nil) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Access Denied" message:@"Please complete the quiz prior to accessing the review." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		
		[alert show];
		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		return;
	}
	
	ReviewViewController *next = [[ReviewViewController alloc] initWithNibName:@"ReviewViewController" bundle:nil];
	NSDictionary *allQuestions = [quizDict objectForKey:[quizTitleList objectAtIndex:[indexPath row]]];
	next.tossupQuestions = [allQuestions objectForKey:@"Toss-up"];
	next.bonusQuestions = [allQuestions objectForKey:@"Bonus"];
	[self.navigationController pushViewController:next animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.scoreFilepath = nil;
	[super  viewDidUnload];
}

@end
