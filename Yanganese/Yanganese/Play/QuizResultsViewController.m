//
//  QuizResultsViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QuizResultsViewController.h"
#import "QuizSelectionViewController.h"

@implementation QuizResultsViewController

@synthesize infoDelegate;
@synthesize countArray, totalArray;
@synthesize correctCount, questionTotal;

- (void)save {	
	// find path for score file
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSString *file = [path stringByAppendingPathComponent:@"score.plist"];
	
    // load file or create new
	NSMutableDictionary *data;
	if([[NSFileManager defaultManager] fileExistsAtPath:file])
		data = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
	else
		data = [[NSMutableDictionary alloc] init];
    
	// find quiz information
	NSArray *controllers = [self.navigationController viewControllers];
	QuizSelectionViewController *selectionController = [controllers objectAtIndex:([controllers count] - 3)];
	NSString *name = [selectionController.quizTitleList objectAtIndex:selectionController.saverow];
	NSDictionary *info = [[selectionController.quizDict objectForKey:name] objectForKey:@"Info"];
	
	// write quiz information 
	NSDictionary *new = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"Name", self.scoreString, @"Score", self.percentageArray, @"Percent", info, @"Info",nil];
	[data setObject:new forKey:name];
	
	NSMutableDictionary *overall = [data objectForKey:@"Overall"];
	if(overall == nil) {
		overall = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Overall", @"Name", self.scoreString, @"Score", self.percentageArray, @"Percent", self.countArray, @"Count", self.totalArray, @"Total", nil];
	}
	else {
		// add new score
		NSString *fileScore = [overall objectForKey:@"Score"];
		NSString *filePart = [[fileScore componentsSeparatedByString:@": "] objectAtIndex:1];
		int s = [filePart intValue];
		NSString *intPart = [[self.scoreString componentsSeparatedByString:@": "] objectAtIndex:1];
		s += [intPart intValue];
		NSString *newScore = [[NSString alloc] initWithFormat:@"Score: %d", s];
		self.scoreString = newScore;
		[overall setObject:self.scoreString forKey:@"Score"];
		
		// add individual counts
		int c, t;
		double d;
		NSArray *fileCount = [overall objectForKey:@"Count"];
		NSArray *fileTotal = [overall objectForKey:@"Total"];		
		NSMutableArray *newCountArray = [[NSMutableArray alloc] init];
		NSMutableArray *newTotalArray = [[NSMutableArray alloc] init];
		NSMutableArray *percArray = [[NSMutableArray alloc] initWithCapacity:kCategoryNumber];
		for(int i = 0; i < kCategoryNumber; i++) {
			c = [[fileCount objectAtIndex:i] intValue] + correctCount[i];
			t = [[fileTotal objectAtIndex:i] intValue] + questionTotal[i];
			NSNumber *count = [NSNumber numberWithInt:c];
			NSNumber *total = [NSNumber numberWithInt:t];
			[newCountArray addObject:count];
			[newTotalArray addObject:total];
			d = (double) c / t;
			NSNumber *percentage = [NSNumber numberWithDouble:d];
			[percArray addObject:percentage];
		}
		[overall setObject:newCountArray forKey:@"Count"];
		[overall setObject:newTotalArray forKey:@"Total"];
		
		self.percentageArray = percArray;
		[overall setObject:self.percentageArray forKey:@"Percent"];
		
	}
	
	[data setObject:overall forKey:@"Overall"];
	
	[data writeToFile:file atomically:YES];
		
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save" message:@"You will now be returned to the menu." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

	[alert show];
}

- (void)viewDidLoad {
	self.title = @"Quiz Results";
	
	UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
	[self.navigationItem setLeftBarButtonItem:save];
	
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Alert view delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex != [alertView cancelButtonIndex]) {
		[self.navigationController setNavigationBarHidden:YES animated:YES];
		
		[UIView animateWithDuration:kTransitionTime animations:^ {
            for(UIView *object in self.view.subviews)
			object.alpha = 0.0;
		}];
		
		[self.navigationController performSelector:@selector(popToViewControllerNotAnimated:) withObject:[self.navigationController.viewControllers objectAtIndex:0] afterDelay:kTransitionTime];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	self.infoDelegate = nil;
	self.countArray = nil;
	self.totalArray = nil;
	
	[self viewDidUnload];
}

@end
