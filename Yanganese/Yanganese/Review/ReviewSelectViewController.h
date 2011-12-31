//
//  ResearchReviewSelectViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionViewController.h"

@interface ReviewSelectViewController : SelectionViewController {
	NSString *scoreFilepath;
}

@property (nonatomic, retain) NSString *scoreFilepath;

@end
