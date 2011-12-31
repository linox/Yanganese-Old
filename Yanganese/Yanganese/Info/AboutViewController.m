//
//  AboutViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "MainMenuViewController.h"

@implementation AboutViewController

@synthesize versionLabel;

- (IBAction)back {
    NSArray *controllers = [self.navigationController viewControllers];
	MainMenuViewController *past = (MainMenuViewController *)[controllers objectAtIndex:([controllers count] - 2)];
	past.settingsHidden = !past.settingsHidden;
	[past showSettings:self];
		
	[UIApplication sharedApplication].statusBarHidden = NO;
	self.navigationController.navigationBar.alpha = 1.0;
	[UIView animateWithDuration:kTransitionTime animations:^ {
        self.view.alpha = 0.0;
	}];
	
	[self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:nil afterDelay:kTransitionTime];
}

- (IBAction)send {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"E-mail" message:@"Switch to the mail app?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	
	[alert show];
}

- (void)viewDidLoad {
	self.title = @"About";
	self.view.alpha = 0.0;
	
	NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *formattedVersion = [[NSString alloc] initWithFormat:@"v%@", version];
    versionLabel.text = formattedVersion;
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {	
	self.navigationController.navigationBar.alpha = 0.0;
	[UIApplication sharedApplication].statusBarHidden = YES;
	[UIView animateWithDuration:kTransitionTime animations:^ {
        self.view.alpha = 1.0;
	}];

	[super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Alert view delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if(buttonIndex != [alertView cancelButtonIndex]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kMailAddress]];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    self.versionLabel = nil;
    
    [super viewDidUnload];
}

@end
