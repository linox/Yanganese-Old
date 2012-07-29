//
//  AppDelegate.m
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window, navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [navController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [window addSubview:navController.view];
    [window makeKeyAndVisible];
    
    return YES;
}

@end
