//
//  ResultViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"

@implementation ResultViewController

@synthesize scoreLabel, timeLabel, resultTable;
@synthesize categoryList;
@synthesize filePath;
@synthesize percentageArray;
@synthesize scoreString;
@synthesize timeString;

- (void)viewDidLoad {
	// initialize style
	scoreLabel.layer.cornerRadius = kCornerRadius;
	timeLabel.layer.cornerRadius = kCornerRadius / 2;
	resultTable.layer.cornerRadius = kCornerRadius;
	resultTable.alpha = 0.0;
	scoreLabel.alpha = 0.0;
	
	// initialize list of categories
	NSArray *categories = [[NSArray alloc] initWithObjects:@"Astro", @"Bio", @"Chem", @"Earth", @"Gen", @"Math", @"Phys", nil];
	self.categoryList = categories;
    
	// set the score from string (from last controller in stack)
	self.scoreLabel.text = scoreString;
	
	// initializes time if available
	if(timeString == nil)
		timeLabel.hidden = YES;
	else
		self.timeLabel.text = timeString;
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	// fade elements in
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[UIView animateWithDuration:kTransitionTime animations:^ {
        for(UIView *subview in self.view.subviews)
		subview.alpha = 1.0;
	}];
	
	[super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categoryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *ResultCellIdentifier = @"Result Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultCellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ResultCellIdentifier];
	
	// initialize cell properties
	cell.textLabel.text = [categoryList objectAtIndex:[indexPath row]];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.contentView.backgroundColor = [UIColor transparentBlack];
	cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:kFontSize];	
	// show percentage if value exists
	double percent = [[percentageArray objectAtIndex:[indexPath row]] doubleValue];
	BOOL isReal = (int)(percent/2 + 1) == 1;
	if(isReal)
	{
		cell.detailTextLabel.textColor = [UIColor whiteColor];
		NSString *label = [[NSString alloc] initWithFormat:@"%.2f%%", percent * 100];
		cell.detailTextLabel.text = label;
	}
	else
		cell.detailTextLabel.textColor = [UIColor clearColor];
	
	return cell;
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	self.scoreLabel = nil;
	self.timeLabel = nil;
	self.resultTable = nil;
	self.categoryList = nil;
	self.filePath = nil;
	self.percentageArray = nil;
	self.scoreString = nil;
	self.timeString = nil;
	
    [super viewDidUnload];
}

@end