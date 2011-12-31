//
//  ScoresViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoresViewController.h"
#import "ScoreSelectionViewController.h"

@implementation ScoresViewController

- (void)animateBack {
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	
	[UIView animateWithDuration:kTransitionTime animations:^ {
        self.resultTable.alpha = 0.0;
        self.scoreLabel.alpha = 0.0;
	}];
	
	[self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:kTransitionTime];
}

- (void)selection {
	ScoreSelectionViewController *selector = [[ScoreSelectionViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
	
	NSMutableDictionary *this = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	[this removeObjectForKey:@"Overall"];
	selector.allQuizzes = this;
	selector.filePath = filePath;
	
	self.title = @"Overall";
	
	[self.navigationController pushViewController:selector animated:YES];
}

- (void)loadInfo {
	NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	NSDictionary *spec = [data objectForKey:@"Overall"];
	self.scoreString = [spec objectForKey:@"Score"];
	self.percentageArray = [spec objectForKey:@"Percent"];
	self.scoreLabel.text = scoreString;
	[self.resultTable reloadData];
}

- (void)viewDidLoad {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSString *file = [path stringByAppendingPathComponent:@"score.plist"];
	self.filePath = file;
	
	[self.timeLabel setHidden:YES];
	
	[self loadInfo];
	
	UIBarButtonItem *all = [[UIBarButtonItem alloc] initWithTitle:@"All" style:UIBarButtonItemStyleBordered target:self action:@selector(selection)];
	self.navigationItem.rightBarButtonItem = all;
	UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(animateBack)];
	self.navigationItem.leftBarButtonItem = left;

    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	self.title = @"Scores";
	
	[self loadInfo];
		
	[super viewWillAppear:animated];
}	

@end
