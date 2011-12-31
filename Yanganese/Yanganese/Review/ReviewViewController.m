//
//  ReviewViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ReviewViewController.h"

@implementation ReviewViewController

@synthesize questionScroll;
@synthesize prevTextView, currTextView, nextTextView;
@synthesize change;
@synthesize dataArray;
@synthesize currentPage;

- (IBAction)show {
	[change setTitle:(answerHidden ? @"Hide" : @"Show") forState:UIControlStateNormal];
	
	[UIView animateWithDuration:kTransitionTime animations:^ {
        if(answerHidden) {
            NSString *letter = [question objectForKey:@"Answer"];
            NSString *answer = [question objectForKey:letter];		
            NSString *msg = [[NSString alloc] initWithFormat:@"%@. %@", letter, answer];
            answerLabel.text = msg;
        }
        else {
            answerLabel.text = @"";
        }
        
        answerLabel.transform = answerHidden ? transformAnswerDrop : transformOriginal;
        
        answerLabel.alpha = (answerHidden ? 1.0 : 0.0);
	}];
	
	answerHidden = !answerHidden;
}

- (void)refreshTitle {
	NSString *titleString = [[NSString alloc] initWithFormat:@"Question %d", (questionNumber / 2 + 1)];
	self.title = titleString;
	
	NSString *typeString;
	if(questionNumber % 2 == 0)
		typeString = [[NSString alloc] initWithFormat:@"%@ : Toss-Up", [question objectForKey:@"Category"]];
	else
		typeString = [[NSString alloc] initWithFormat:@"%@ : Bonus", [question objectForKey:@"Category"]];
	numberLabel.text = typeString;
}

- (void)loadScrollViewWithPage:(int)page {	
	if(page != 0)
		questionNumber = page - 1;
	else
		questionNumber = [dataArray count] - 1;
	isBonus = !(questionNumber % 2 == 0);
	[self setTextFor:prevTextView];
		
	if(page != [dataArray count] - 1)
		questionNumber = page + 1;
	else
		questionNumber = 0;
	isBonus = !(questionNumber % 2 == 0);
	[self setTextFor:nextTextView];
		
	questionNumber = page;
	isBonus = !(questionNumber % 2 == 0);
	[self setTextFor:currTextView];
}

- (void)setTextFor:(UITextView *)questionView {
	self.question = [dataArray objectAtIndex:questionNumber];
	
	[super setTextFor:questionView];
}

- (void)viewDidLoad {	
	isBonus = NO;
	answerHidden = YES;
	
	[change setTitle:@"Show" forState:UIControlStateNormal];
	[change setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
	[change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

	int size = [self.tossupQuestions count];
	NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:(size * 2)];
	for(int i = 0; i < size; i++) {
		[data addObject:[self.tossupQuestions objectAtIndex:i]];
		[data addObject:[self.bonusQuestions objectAtIndex:i]];
	}
	self.dataArray = data;
		
	UITextView* prev = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 280, 230)];
	UITextView* curr = [[UITextView alloc] initWithFrame:CGRectMake(340, 0, 280, 230)];
	UITextView* next = [[UITextView alloc] initWithFrame:CGRectMake(660, 0, 280, 230)];
	self.prevTextView = prev;
	self.currTextView = curr;
	self.nextTextView = next;
	
	[questionScroll addSubview:prev];
	[questionScroll addSubview:curr];
	[questionScroll addSubview:next];
	
	for(UIView *object in questionScroll.subviews) {
		if([object isKindOfClass:[UITextView class]]) {
			UITextView *cast = (UITextView *)object;
			cast.backgroundColor = [UIColor transparentBlack];
			cast.layer.cornerRadius = kCornerRadius;
			cast.editable = NO;
			cast.textColor = [UIColor whiteColor];
			cast.font = [UIFont fontWithName:@"Helvetica" size:16.0];
		}
	}
	
	[self loadScrollViewWithPage:0];
	
	questionScroll.contentSize = CGSizeMake(960, 230);	
	[questionScroll scrollRectToVisible:CGRectMake(320,0,320,230) animated:NO];
		
	[self refreshTitle];
	
	[super viewDidLoad];
}

#pragma mark -
#pragma mark Scroll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {     
	if(questionScroll.contentOffset.x > questionScroll.frame.size.width)         
		[self loadScrollViewWithPage:(questionNumber >= ([dataArray count] - 1) ? 0 : (questionNumber + 1))];
	else if(questionScroll.contentOffset.x < questionScroll.frame.size.width)
		[self loadScrollViewWithPage:(questionNumber <= 0 ? ([dataArray count] - 1) : (questionNumber - 1))];

	[questionScroll scrollRectToVisible:CGRectMake(320,0,320,230) animated:NO]; 
	
	[self refreshTitle];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(!answerHidden)
		[self show];
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	self.questionScroll = nil;
	self.prevTextView = nil;
	self.currTextView = nil;
	self.nextTextView = nil;
	self.change = nil;
	self.dataArray = nil;
    [super viewDidUnload];
}

@end
