//
//  ResultView.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ResultViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	// displays total score
	UILabel *scoreLabel;
	// displays total time
	UILabel *timeLabel;
	// displays individual category percentages
	UITableView *resultTable;	
	
	// constant stores list of all categories
	NSArray *categoryList;
	// stores score file path
	NSString *filePath;
	// stores category percentages
	NSArray *percentageArray; //Trying regular C Array
    // stores score for lazy loading
	NSString *scoreString;
	// stores time for lazy loading
	NSString *timeString;
}

@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UITableView *resultTable;
@property (nonatomic, retain) NSArray *categoryList;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSArray *percentageArray;
@property (nonatomic, retain) NSString *scoreString;
@property (nonatomic, retain) NSString *timeString;

@end