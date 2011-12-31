//
//  MenuViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController {
    UIImageView *titleImage;
	
	NSMutableDictionary *menu;
	
	CGAffineTransform translateOriginal;
	CGAffineTransform translateLeft;
	CGAffineTransform translateRight;
	CGAffineTransform translateDown;
	CGAffineTransform translateUp;
}

@property (nonatomic, retain) IBOutlet UIImageView *titleImage;
@property (nonatomic, retain) NSMutableDictionary *menu;

// Method for containing transitions
- (void)translateOut;
// Method to select menu item
- (IBAction)select:(id)sender;

@end
