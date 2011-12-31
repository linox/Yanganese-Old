//
//  SelectionViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomQuizCell.h"

@interface SelectionViewController : UITableViewController <UISearchBarDelegate> {
	// reference to search bar
	UISearchBar *listSearchBar;
	
	// template for custom cell
	CustomQuizCell *tempCell;

	// stores all quizzes
	NSDictionary *allQuizzes;
	// mutable dictionary for searching purposes
	NSMutableDictionary *quizDict;
	// list to display quiz cells
	NSMutableArray *quizTitleList;
	// file path to quizzes
	NSString *filePath;
}

@property (nonatomic, retain) IBOutlet UISearchBar *listSearchBar;
@property (nonatomic, retain) IBOutlet CustomQuizCell *tempCell;
@property (nonatomic, retain) NSDictionary *allQuizzes;
@property (nonatomic, retain) NSMutableDictionary *quizDict;
@property (nonatomic, retain) NSMutableArray *quizTitleList;
@property (nonatomic, retain) NSString *filePath;

// combined animation and transition
- (void)animateBack;
// resets the mutable dictionary and list
- (void)resetSearch;
// searches for term
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end
