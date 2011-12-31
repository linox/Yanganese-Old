//
//  SettingsViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController : UIViewController {
    UIView *paneView;
	UISwitch *vibrateSwitch;
	UISwitch *effectSwitch;
	UIButton *tutorialButton;
}

@property (nonatomic, retain) IBOutlet UIView *paneView;
@property (nonatomic, retain) IBOutlet UISwitch *vibrateSwitch;
@property (nonatomic, retain) IBOutlet UISwitch *effectSwitch;
@property (nonatomic, retain) IBOutlet UIButton *tutorialButton;

- (IBAction)pushTutorial;
- (void)back;
- (void)refresh;

@end
