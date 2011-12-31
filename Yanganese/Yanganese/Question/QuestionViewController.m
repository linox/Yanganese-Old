//
//  QuestionViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "QuestionViewController.h"

@implementation QuestionViewController

@synthesize dashView;
@synthesize numberLabel;
@synthesize answerLabel;
@synthesize tossupQuestions, bonusQuestions;
@synthesize question;

- (void)setTextFor:(UITextView *)questionView {
	// set question text from current question dictionary
	NSString *questionText = [question objectForKey:@"Question"];
	NSString *wText = [question objectForKey:@"W"];
	NSString *xText = [question objectForKey:@"X"];
	NSString *yText = [question objectForKey:@"Y"];
	NSString *zText = [question objectForKey:@"Z"];
	NSString *fullText = [[NSString alloc] initWithFormat:@"%@\n\nW. %@\nX. %@\nY. %@\nZ. %@", questionText, wText, xText, yText, zText];
	questionView.text = fullText;
}

- (void)viewDidLoad {
	// initialize style
	dashView.layer.cornerRadius = kCornerRadius;
	answerLabel.layer.cornerRadius = kCornerRadius;
	answerLabel.alpha = 0.0;
		
	// initialize transformation constants
	transformOriginal = CGAffineTransformMakeTranslation(0.0, 0.0);
	transformAnswerDrop = CGAffineTransformMakeTranslation(0.0, 63.0);
	
	// initialize question number
	questionNumber = 0;
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	[super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {    
	self.dashView = nil;
	self.numberLabel = nil;
	self.answerLabel = nil;
	self.tossupQuestions = nil;
	self.bonusQuestions = nil;
	self.question = nil;
	[super viewDidUnload];
}

@end