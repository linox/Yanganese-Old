//
//  UINavigationController+No_Animation.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (No_Animation)

// Push method without animation
- (void)pushViewControllerNotAnimated:(UIViewController *)viewController;
// Pop method without animation
- (void)popToViewControllerNotAnimated:(UIViewController *)viewController;

@end
