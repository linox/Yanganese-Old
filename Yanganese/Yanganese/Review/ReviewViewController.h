//
//  ReviewViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionViewController.h"

@interface ReviewViewController : QuestionViewController <UIScrollViewDelegate> {
	UIScrollView *questionScroll;
	UITextView *prevTextView;
	UITextView *currTextView;
	UITextView *nextTextView;

	UIButton	*change;
	
	NSMutableArray *dataArray;
	
	int currentPage;
}

@property (nonatomic, retain) IBOutlet UIScrollView *questionScroll;
@property (nonatomic, retain) UITextView *prevTextView;
@property (nonatomic, retain) UITextView *currTextView;
@property (nonatomic, retain) UITextView *nextTextView;
@property (nonatomic, retain) IBOutlet UIButton *change;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property int currentPage;

- (IBAction)show;
- (void)refreshTitle;
- (void)loadScrollViewWithPage:(int)page;

@end
