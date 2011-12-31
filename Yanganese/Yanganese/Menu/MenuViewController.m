//
//  MenuViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@implementation MenuViewController

@synthesize titleImage;
@synthesize menu;

- (void)translateOut {
	// Translate image upward
    titleImage.transform = translateUp;
	
    // Fade images
	for(UIView *object in self.view.subviews) {
		if([object isKindOfClass:[UIButton class]] || [object isKindOfClass:[UIImageView class]]) {
			object.alpha = 0.0;
		}
	}
}

- (IBAction)select:(id)sender {
    // P-ush view controller based on sender name
	UIViewController *next = [self.menu objectForKey:[sender titleForState:UIControlStateNormal]];
	[self.navigationController performSelector:@selector(pushViewControllerNotAnimated:) withObject:next afterDelay:kTransitionTime];
}

- (void)viewDidLoad {		
    // Initialize translation constants
	double shift = titleImage.frame.size.height + kSideMargin;
	
	translateOriginal = CGAffineTransformMakeTranslation(0.0, 0.0);
	translateUp = CGAffineTransformMakeTranslation(0.0, -titleImage.frame.size.height);
	translateLeft = CGAffineTransformMakeTranslation(-shift, 0.0);
	translateRight = CGAffineTransformMakeTranslation(shift, 0.0);
	translateDown = CGAffineTransformMakeTranslation(0.0, shift/2);
	
    // Set initial positions
	[self translateOut];
	
	[super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {	
    // Fade and translate in
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	[UIView beginAnimations:@"Slide In" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:kTransitionTime];
	for(UIView *object in self.view.subviews) {
		if([object isKindOfClass:[UIButton class]] || [object isKindOfClass:[UIImageView class]]) {
			object.transform = translateOriginal;
			object.alpha = 1.0;
		}
	}
	[UIView commitAnimations];
	
	[super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
	self.titleImage = nil;
	self.menu = nil;
	
    [super viewDidUnload];
}

@end
