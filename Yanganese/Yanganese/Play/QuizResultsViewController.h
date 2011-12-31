//
//  QuizResultsViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ResultViewController.h"
#import "GameViewController.h"

@interface QuizResultsViewController : ResultViewController <UIAlertViewDelegate> {
	int *correctCount;
	int *questionTotal;
	
	NSMutableArray *countArray;
	NSMutableArray *totalArray;
	
	GameViewController *infoDelegate;
}

@property (nonatomic, retain) NSMutableArray *countArray;
@property (nonatomic, retain) NSMutableArray *totalArray;
@property int *correctCount;
@property int *questionTotal;
@property (nonatomic, retain) GameViewController *infoDelegate;

- (void)save;

@end
