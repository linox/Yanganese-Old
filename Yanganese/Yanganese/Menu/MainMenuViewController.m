//
//  MainMenuViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainMenuViewController.h"

#import "ScoresViewController.h"
#import "AboutViewController.h"
#import "DownloadViewController.h"
#import "ReviewSelectViewController.h"
#import "SettingsViewController.h"
#import "QuizSelectionViewController.h"

@implementation MainMenuViewController

@synthesize playButton, scoresButton, downloadButton, reviewButton;
@synthesize infoButton, settingsView, settingsButton, aboutButton;
@synthesize settingsHidden;

- (IBAction)showSettings:(id)sender {	
	if(![sender isKindOfClass:[UIButton class]] && settingsHidden)
		return;
	
    [UIView animateWithDuration:kTransitionTime animations:^ {
        CGAffineTransform move;
        BOOL buttonEnabled;
        if(settingsHidden)
        {
            move = translateRight;
            self.view.backgroundColor = [UIColor lightTransparentBlack];
            buttonEnabled = NO;
            self.titleImage.image = [UIImage imageNamed:@"yanganeseDisabled.png"];
        }   
        else 
        {
            move = translateOriginal;
            self.view.backgroundColor = [UIColor clearColor];
            buttonEnabled = YES;
            self.titleImage.image = [UIImage imageNamed:@"yanganese.png"];
            
        }
        for(UIView *object in self.view.subviews) {
            if([object isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)object;
                button.enabled = buttonEnabled;
            }
        }
        settingsView.transform = move;
    }];
	
	settingsHidden = !settingsHidden;
}

- (void)translateOut {
	playButton.transform = translateLeft;
	downloadButton.transform = translateLeft;
	scoresButton.transform = translateRight;
	reviewButton.transform = translateRight;
	infoButton.transform = translateDown;
	
	[super translateOut];
}

- (IBAction)select:(id)sender {
	[UIView animateWithDuration:kTransitionTime animations:^ {
        if(!settingsHidden) {
            CGAffineTransform original = CGAffineTransformMakeTranslation(0.0, 0.0);
            settingsView.transform = original;
            settingsHidden = !settingsHidden;
        }
        [self translateOut];
	}];
	
	[super select:sender];
}

- (void)viewDidLoad {
	settingsHidden = YES;
	
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	self.menu = dictionary;
	
	QuizSelectionViewController *play = [[QuizSelectionViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
    //t
    play.title = @"Play";
	[menu setObject:play forKey:play.title];
	DownloadViewController *download = [[DownloadViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
	download.title = @"Download";
	[menu setObject:download forKey:download.title];
	ReviewSelectViewController *review = [[ReviewSelectViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
	review.title = @"Review";
	[menu setObject:review forKey:review.title];
	ScoresViewController *score = [[ScoresViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
	score.title = @"Scores";
	[menu setObject:score forKey:score.title];
	AboutViewController *about = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
	about.title = @"About";
	[menu setObject:about forKey:@"About"];
    SettingsViewController *settings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    settings.title = @"Settings";
    [menu setObject:settings forKey:settings.title];
	
	[super viewDidLoad];
}

- (void)viewDidUnload {
	self.playButton = nil;
	self.scoresButton = nil;
	self.downloadButton = nil;
	self.reviewButton = nil;
	self.infoButton = nil;
	self.settingsView = nil;
	self.settingsButton = nil;
	self.aboutButton = nil;
	
    [super viewDidUnload];
}

@end
