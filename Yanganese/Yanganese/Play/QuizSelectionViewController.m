//
//  QuizSelectionViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QuizSelectionViewController.h"
#import "GameViewController.h"

@implementation QuizSelectionViewController

@synthesize saverow;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSString *filePathString = [path stringByAppendingPathComponent:@"questions.plist"];
	self.filePath = filePathString;
	
	NSDictionary *original = [[NSDictionary alloc] initWithContentsOfFile:filePath];

	NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber *version = [standardDefaults objectForKey:@"Version"];
	double v = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] doubleValue];
	NSNumber *vNumber = [NSNumber numberWithDouble:v];
	
	if(version == nil || [version doubleValue] != v) {
		[standardDefaults setObject:vNumber forKey:@"Version"];
		
		path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"plist"];
		original = [[NSDictionary alloc] initWithContentsOfFile:path];
		[original writeToFile:filePath atomically:YES];
	}
	
	if(original == nil ) {
		path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"plist"];
		original = [[NSDictionary alloc] initWithContentsOfFile:path];
		[original writeToFile:filePath atomically:YES];
	}
	
	self.allQuizzes = original;
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	self.quizDict = nil;
	
	NSDictionary *original = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	self.allQuizzes = original;
		
	[super resetSearch];
	
	[self.tableView reloadData];
	
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GameViewController *next = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
	NSDictionary *original = [quizDict objectForKey:[quizTitleList objectAtIndex:[indexPath row]]];
	next.tossupQuestions = [original objectForKey:@"Toss-up"];
	next.bonusQuestions = [original objectForKey:@"Bonus"];
	[self.navigationController pushViewController:next animated:YES];
	saverow = [indexPath row];
}

@end

