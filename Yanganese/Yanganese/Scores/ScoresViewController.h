//
//  ScoresViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"

@interface ScoresViewController : ResultViewController {

}

// used to combine animation and transition 
- (void)animateBack;
- (void)loadInfo;
- (void)selection;

@end
