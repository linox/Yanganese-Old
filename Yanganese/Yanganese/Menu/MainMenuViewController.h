//
//  MainMenuViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface MainMenuViewController : MenuViewController {
    UIButton *playButton;
	UIButton *scoresButton;
	UIButton *downloadButton;
	UIButton *reviewButton;
	
	UIButton *infoButton;
	UIControl *settingsView;
	UIButton *settingsButton;
	UIButton *aboutButton;
	
	BOOL settingsHidden;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *scoresButton;
@property (nonatomic, retain) IBOutlet UIButton *downloadButton;
@property (nonatomic, retain) IBOutlet UIButton *reviewButton;
@property (nonatomic, retain) IBOutlet UIButton *infoButton;
@property (nonatomic, retain) IBOutlet UIButton *settingsButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutButton;
@property (nonatomic, retain) IBOutlet UIControl *settingsView;
@property BOOL settingsHidden;

- (IBAction)showSettings:(id)sender;

@end
