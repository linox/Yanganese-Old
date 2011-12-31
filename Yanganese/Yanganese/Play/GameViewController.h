//
//  GameViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "QuestionViewController.h"

#define kTranslationNumber 4

/*typedef enum Categories {
	Astro,
	Bio,
	Chem,
	Earth,
	Gen,
	Math,
	Phys
} Category;
*/
@interface GameViewController : QuestionViewController <UIAlertViewDelegate> {	
	// NSDictionary *categories
	int correctCount[7];
	int questionTotal[7];
	
	UITextView *questionView;
	UIButton *X;
	UIButton *Y;
	UIButton *Z;
	UIButton *W;
	UILabel *time;
	UILabel *score;
	
	NSUInteger nScore;
	NSUInteger nTimeMin;
	NSUInteger nTimeSec;
	NSUInteger index;
	NSTimer *timer;
	NSArray *buttons;
	
	CGAffineTransform translations[kTranslationNumber];
	
	SystemSoundID correct;
	SystemSoundID incorrect;
	
	BOOL h;
	BOOL vibrateOn;
	BOOL effectOn;
}

@property (nonatomic, retain) NSArray *buttons;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) IBOutlet UITextView *questionView;
@property (nonatomic, retain) IBOutlet UIButton *X;
@property (nonatomic, retain) IBOutlet UIButton *Y;
@property (nonatomic, retain) IBOutlet UIButton *Z;
@property (nonatomic, retain) IBOutlet UIButton *W;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) IBOutlet UILabel *score;

- (IBAction)answer:(id)sender;
- (void)toggleAnswer;
- (void)resetColor;
- (void)refresh;
- (void)exit;
- (void)endRound;
- (void)changeTimeToCurrent;
- (void)changeScoreToCurrent;

@end
