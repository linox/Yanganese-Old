//
//  SelectionViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectionViewController.h"

@implementation SelectionViewController

@synthesize listSearchBar;
@synthesize tempCell;
@synthesize allQuizzes;
@synthesize quizDict;
@synthesize quizTitleList;
@synthesize filePath;

- (void)animateBack {
	// fade elements out
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	[UIView animateWithDuration:kTransitionTime animations:^ {
        self.tableView.alpha = 0.0;
	}];

    // return to previous view controller
	[self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:kTransitionTime];
}	

- (void)resetSearch {
	// restore visible quizzes by copying from original dictionary
    NSMutableDictionary *allCopy = [self.allQuizzes mutableDeepCopy];
	self.quizDict = allCopy;
	
    // restore list from original dictionary
	NSMutableArray *listCopy = [[NSMutableArray alloc] init];
	[listCopy addObjectsFromArray:[[self.allQuizzes allKeys] sortedArrayUsingSelector:@selector(compare:)]];
	self.quizTitleList = listCopy;
}

- (void)handleSearchForTerm:(NSString *)searchTerm {
	// restore list when handling new term
    [self resetSearch];
	
    // fill array with quizzes that do not match term
    NSMutableArray *toRemove = [[NSMutableArray alloc] init];
	for (NSString *item in quizTitleList) {
		if([item rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound)
			[toRemove addObject:item];		
	}
	
    // remove from visible list cells from array
	[quizTitleList removeObjectsInArray:toRemove];
	
    // refresh list to visualize changes
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	// initialize style
	self.tableView.backgroundColor = [UIColor lightTransparentBlack];
	self.tableView.rowHeight = kRowHeight;
	self.tableView.alpha = 0.0;
	[self.tableView setContentOffset:CGPointMake(0.0, self.navigationController.navigationBar.frame.size.height) animated:NO];
	for(UIView *subView in listSearchBar.subviews) {
		if([subView isKindOfClass: [UITextField class]])
			[(UITextField *)subView setKeyboardAppearance:UIKeyboardAppearanceAlert];
	}
	
	// set tableView data
	[self resetSearch];
	[self.tableView reloadData];
	
	// create button to handle custom back method animation
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(animateBack)];
	self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton = YES;

    // show button for item deletion
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	// fade elements in
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[UIView animateWithDuration:kTransitionTime animations:^ {
        self.tableView.alpha = 1.0;
	}];
	
	[super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [quizTitleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ListCellIdentifier = @"List Cell";
    
    CustomQuizCell *cell = (CustomQuizCell *)[tableView dequeueReusableCellWithIdentifier:ListCellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CustomQuizCell" owner:self options:nil];
		cell = tempCell;
		self.tempCell = nil;
    }
	
    // set cell properties
	NSDictionary *data = [[quizDict objectForKey:[quizTitleList objectAtIndex:[indexPath row]]] objectForKey:@"Info"];
	cell.nameLabel.text = [data objectForKey:@"Name"];
	cell.nameLabel.highlightedTextColor = [UIColor grayColor];
	cell.iconView.image = [UIImage imageNamed:[data objectForKey:@"Icon"]];
	cell.authorLabel.text = [data objectForKey:@"Author"];
	cell.ratingView.rating = [[data objectForKey:@"Rating"] floatValue];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	UIImageView *highlight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectHighlight.png"]];
	cell.selectedBackgroundView = highlight;
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[listSearchBar resignFirstResponder];
	return indexPath;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // initialize mutable array from original (immutable) dictionary
	NSMutableDictionary *delete = [[NSMutableDictionary alloc] init];
	[delete setDictionary:allQuizzes];
    
    // remove object from mutable array
	[delete removeObjectForKey:[quizTitleList objectAtIndex:[indexPath row]]];
	
    // refresh original dictionary and write it to file
	self.allQuizzes = (NSDictionary *)delete;	
	[allQuizzes writeToFile:filePath atomically:YES];
    
    // update visible list and animate change
	[quizTitleList removeObjectAtIndex:[indexPath row]];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark -
#pragma mark Search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	NSString *searchTerm = [searchBar text];
	[self handleSearchForTerm:searchTerm];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm {
	// perform no search with empty search bar
    if([searchTerm length] == 0) {
		[self resetSearch];
		[self.tableView reloadData];
		return;
	}
    
	[self handleSearchForTerm:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	// reset search bar and table
    searchBar.text = @"";
	[self resetSearch];
	[self.tableView reloadData];
	[searchBar resignFirstResponder];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
	// show cancel button and hide navigation bar when editin begins
    [searchBar setShowsCancelButton:YES animated:YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    // hide search bar when editing ends
	[searchBar setShowsCancelButton:NO animated:YES];	
	return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	self.listSearchBar = nil;
	self.tempCell = nil;
	self.allQuizzes = nil;
	self.quizDict = nil;
    self.quizTitleList = nil;
	self.filePath = nil;
	
	[super viewDidUnload];
}

@end

