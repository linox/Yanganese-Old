//
//  SettingsViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "MainMenuViewController.h"
#import "TutorialViewController.h"

@implementation SettingsViewController

@synthesize paneView;
@synthesize vibrateSwitch, effectSwitch;
@synthesize tutorialButton;

- (IBAction)pushTutorial {
	TutorialViewController *next = [[TutorialViewController alloc] initWithNibName:@"TutorialViewController" bundle:nil];
	[self.navigationController pushViewController:next animated:YES];
}

- (void)back {
	NSArray *controllers = [self.navigationController viewControllers];
	MainMenuViewController *past = (MainMenuViewController *)[controllers objectAtIndex:([controllers count] - 2)];
	past.settingsHidden = !past.settingsHidden;
	[past showSettings:self];
	
    [self.navigationController setNavigationBarHidden:YES animated:YES];
	
	[UIView animateWithDuration:kTransitionTime animations:^ {
        paneView.alpha = 0.0;
        tutorialButton.alpha = 0.0;
	}];
	
	[self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:kTransitionTime];
}

- (void)refresh {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	vibrateSwitch.on = [defaults boolForKey:@"vibrate_preference"];
	effectSwitch.on = [defaults boolForKey:@"effect_preference"];
}

- (void)viewDidLoad {
	[self refresh];
	
	paneView.layer.cornerRadius = kCornerRadius;
	paneView.alpha = 0.0;
	tutorialButton.alpha = 0.0;
	
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.hidesBackButton = YES;
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	
	[UIView animateWithDuration:kTransitionTime animations:^ {
        paneView.alpha = 1.0;
        tutorialButton.alpha = 1.0;
	}];
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:vibrateSwitch.on forKey:@"vibrate_preference"];
	[defaults setBool:effectSwitch.on forKey:@"effect_preference"];
	[super viewWillDisappear:animated];
}

- (void)viewDidUnload {
	self.paneView = nil;
	self.vibrateSwitch = nil;
	self.effectSwitch = nil;
	self.tutorialButton = nil;
    
	[super viewDidUnload];
}

@end
