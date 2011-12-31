//
//  GameViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "QuizResultsViewController.h"

#define kXTrans1 83
#define kXTrans2 -82
#define kYTrans1 58
#define kYTrans2 -7

@implementation GameViewController

@synthesize questionView;
@synthesize W, X, Y , Z;
@synthesize time, timer;
@synthesize score;
@synthesize buttons;

- (void)setTextFor:(UITextView *)questionView {
	// set question number
	NSString *updatedNumber = [[NSString alloc] initWithFormat:@"Question %d", (questionNumber + 1)];
	self.title = updatedNumber;
	
	// set question type in navigation bar
	NSString *typeString;
	if(!isBonus) {
		self.question = [tossupQuestions objectAtIndex:questionNumber];
		typeString = [[NSString alloc] initWithFormat:@"%@ : Toss-Up", [question objectForKey:@"Category"]];
	}
	else {
		self.question = [bonusQuestions objectAtIndex:questionNumber];
		typeString = [[NSString alloc] initWithFormat:@"%@ : Bonus", [question objectForKey:@"Category"]];
	}
	numberLabel.text = typeString;
	
	[super setTextFor:self.questionView];
}

- (IBAction)answer:(id)sender {	
	NSString *right = [question objectForKey:@"Answer"];
	NSString *catType = [question objectForKey:@"Category"];
	char catChar = [catType characterAtIndex:0];
	int catInt;
	switch (catChar) {
		case 'A':
			catInt = 0;
			break;
		case 'B':
			catInt = 1;
			break;
		case 'C':
			catInt = 2;
			break;
		case 'E':
			catInt = 3;
			break;
		case 'G':
			catInt = 4;
			break;
		case 'M':
			catInt = 5;
			break;
		case 'P':
			catInt = 6;
			break;
		default:
			break;
	}
	
	NSString *a = [sender titleForState:UIControlStateNormal];
	
	index = (int)[a characterAtIndex:0] - (int)'W';
	UIButton *button = [buttons objectAtIndex:index];
	
	if ([a isEqualToString:right]) {
		if(effectOn)
			AudioServicesPlaySystemSound(correct);
		
		[button setBackgroundImage:[UIImage imageNamed:@"Green.png"] forState:UIControlStateDisabled];
		
		if(!isBonus)	
			nScore += 4;
		else {
			nScore += 10;
			questionNumber++;
		}
		
		isBonus = !isBonus;
		correctCount[catInt]++;	
	}
	else {
		if(vibrateOn)
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		
		if(effectOn)
			AudioServicesPlaySystemSound(incorrect);
		
		[button setBackgroundImage:[UIImage imageNamed:@"Red.png"] forState:UIControlStateDisabled];
		
		if(!isBonus)
			questionTotal[catInt]++;
		
		isBonus = NO;
		questionNumber++;
	}
	
	button.enabled = NO;
	questionTotal[catInt]++;
	
	[self changeScoreToCurrent];
	
	[self toggleAnswer];
	
	[self performSelector:@selector(resetColor) withObject:nil afterDelay:1.5];
}

- (void)toggleAnswer {
	[UIView animateWithDuration:kTransitionTime animations:^ {
	
	UIButton *button = [buttons objectAtIndex:index];
        if(answerHidden) {
            // set answer text
            NSString *letter = [question objectForKey:@"Answer"];
            NSString *answer = [question objectForKey:letter];
            NSString *msg = [[NSString alloc] initWithFormat:@"%@. %@", letter, answer];
            answerLabel.text = msg;
            
            answerLabel.transform = transformAnswerDrop;
            answerLabel.alpha = 1.0;
            button.transform = translations[index];
        }
        else {
            // empty answer text
            answerLabel.text = @"";
            
            answerLabel.transform = transformOriginal;
            answerLabel.alpha = 0.0;
            button.transform = transformOriginal;
        }
        
        for(int i = 0; i < [buttons count]; i++) {
            if(i != index) {
                UIButton *not = [buttons objectAtIndex:i];
                not.alpha = answerHidden ? 0.0 : 1.0;
            }
        }
	}];
	
	answerHidden = !answerHidden;
}

- (void)resetColor {	
	[self toggleAnswer];
	
	UIButton *button = [buttons objectAtIndex:index];
	button.enabled = YES;
	
	if(questionNumber < [tossupQuestions count])
		[self setTextFor:questionView];
	else
		[self endRound];
	
}

- (void)endRound {
	self.title = @"Quiz";
	
	QuizResultsViewController *next = [[QuizResultsViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
	next.scoreString = score.text;
    
    NSMutableArray *initCount = [[NSMutableArray alloc] initWithCapacity:7];
    NSMutableArray *initTotal = [[NSMutableArray alloc] initWithCapacity:7];
    NSMutableArray *initPercentage = [[NSMutableArray alloc] initWithCapacity:7];
    for(int k = 0; k < 7; k++) {
        NSNumber *cNum = [[NSNumber alloc] initWithInt:correctCount[k]];
        NSNumber *tNum = [[NSNumber alloc] initWithInt:questionTotal[k]];
        double dc = (double)correctCount[k];
        double dt = (double)questionTotal[k];
        NSNumber *num = [[NSNumber alloc] initWithDouble:dc/dt];
        [initCount addObject:cNum];
        [initTotal addObject:tNum];
        [initPercentage addObject:num];	
    }
    
    next.countArray = initCount;
    next.totalArray = initTotal;
    next.percentageArray = initPercentage;
	
	next.correctCount = correctCount;
	next.questionTotal = questionTotal;
	
	[self changeTimeToCurrent];
	[timer invalidate];
	
	[self.navigationController pushViewController:next animated:YES];
}

- (void)changeScoreToCurrent {
	// set current score from instance variable
	NSString *newScore = [[NSString alloc] initWithFormat:@"Score: %d", nScore];
	score.text = newScore;
}

- (void)changeTimeToCurrent {
	// set current time from isntance variables
	NSString *newTime;
	
	//adds 0 for single digit numbers
	if(nTimeSec < 10)
		newTime = [[NSString alloc] initWithFormat:@"Time: %d:0%d", nTimeMin, nTimeSec];
	else
		newTime = [[NSString alloc] initWithFormat:@"Time: %d:%d", nTimeMin, nTimeSec];
	self.time.text = newTime;
}

- (void)exit {	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exiting" message:@"Are you sure you want to quit the current round?\nYour information will be lost." 
												   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
	[alert show];
}

- (void)updateTime:(NSTimer *)timer {
	nTimeSec++;
	nTimeMin += nTimeSec / 60;
	nTimeSec = nTimeSec % 60;

	[self changeTimeToCurrent];
}

- (void)refresh {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	vibrateOn = [defaults boolForKey:@"vibrate_preference"];
	effectOn = [defaults boolForKey:@"effect_preference"];
}

- (void)viewDidLoad {
	// set title and look
	self.title = @"Quiz";
	questionView.layer.cornerRadius = kCornerRadius;
	questionView.font = [UIFont fontWithName:@"Helvetica" size:kFontSize];
	
	// create and add quit button
	UIBarButtonItem *quit = [[UIBarButtonItem alloc] initWithTitle:@"Quit" style:UIBarButtonItemStyleBordered target:self action:@selector(exit)];
	[self.navigationItem setLeftBarButtonItem:quit];
	
	// initialize instance variables and labels
	h = NO;
	nScore = 0;
	nTimeMin = 0;
	nTimeSec = 0;
	isBonus = NO;
	answerHidden = YES;
	[self changeTimeToCurrent];
	[self changeScoreToCurrent];
	
	// preload sound effects
	NSString *correctPath = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"wav"];
	NSString *incorrectPath = [[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:correctPath], &correct);
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:incorrectPath], &incorrect);
	
	// add buttons to array
	NSArray *array = [[NSArray alloc] initWithObjects:W, X, Y, Z, nil];
	self.buttons = array;
	
	// initialize transitions
	int x[2] = {kXTrans1, kXTrans2};
	int y[2] = {kYTrans1, kYTrans2};
	for(int i = 0; i < [buttons count]; i++)
		translations[i] = CGAffineTransformMakeTranslation(x[i % 2], y[i / 2]);

	// begin timer 
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	
	// begin quiz
	[self setTextFor:questionView];
	
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[self refresh];
	[super viewDidAppear:animated];
}

#pragma mark -
#pragma mark Alert view delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex != [alertView cancelButtonIndex]) {
		[self.navigationController setNavigationBarHidden:YES animated:YES];
		
		[UIView animateWithDuration:kTransitionTime animations:^ {
            for(UIView *object in self.view.subviews) {
                object.alpha = 0.0;
            }
		}];
		[timer invalidate];
		
		[self.navigationController performSelector:@selector(popToViewControllerNotAnimated:) withObject:[self.navigationController.viewControllers objectAtIndex:0] afterDelay:kTransitionTime];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	self.questionView = nil;
	self.X = nil;
	self.Y = nil;
	self.Z = nil;
	self.W = nil;
	self.time = nil;
	self.timer = nil;
	self.score = nil;
	self.buttons = nil;
    [super viewDidUnload];
}

@end
