//
//  AboutViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {
	UILabel *versionLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *versionLabel;

- (IBAction)back;
- (IBAction)send;

@end
