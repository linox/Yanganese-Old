//
//  UINavigationController+No_Animation.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationController+No_Animation.h"

@implementation UINavigationController (No_Animation)

- (void)pushViewControllerNotAnimated:(UIViewController *)viewController {
    [self pushViewController:viewController animated:NO];
}

- (void)popToViewControllerNotAnimated:(UIViewController *)viewController {
	[self popToViewController:viewController animated:NO];
}

@end
