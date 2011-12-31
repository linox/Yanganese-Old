//
//  QuestionViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface QuestionViewController : UIViewController {
	// contains dashboard with scores and time
	UIView *dashView;
	// displays question number and category
	UILabel *numberLabel;
	// displays correct answer
	UILabel *answerLabel;
	
	// stores toss-up questions
	NSArray *tossupQuestions;
	// stores bonus questions
	NSArray *bonusQuestions;
	// stores current question
	NSDictionary *question;
	
	// constant contains default transform
	CGAffineTransform transformOriginal;
	// constant contains show answer transform
	CGAffineTransform transformAnswerDrop;
	
	// stores current question number
	NSUInteger questionNumber;
	// determines bonus question availability
	BOOL isBonus;
	// determines answer label transform
	BOOL answerHidden;
}

@property (nonatomic, retain) IBOutlet UIView *dashView;
@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@property (nonatomic, retain) IBOutlet UILabel *answerLabel;
@property (nonatomic, retain) NSArray *tossupQuestions;
@property (nonatomic, retain) NSArray *bonusQuestions;
@property (nonatomic, retain) NSDictionary *question;

// set text view text to current question
- (void)setTextFor:(UITextView *)questionView;

@end
