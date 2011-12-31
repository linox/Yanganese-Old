//
//  DowloadViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionViewController.h"

@class Reachability;

@interface DownloadViewController : SelectionViewController {
	Reachability* internetReachable;
    Reachability* hostReachable;

	BOOL internetActive;
	BOOL hostActive;
	
	NSInteger start;
	
	NSString *oldPath;
	NSOperationQueue *queue;
}

@property BOOL internetActive;
@property BOOL hostActive;
@property (nonatomic, retain) NSString *oldPath;
@property (nonatomic, retain) NSOperationQueue *queue;

- (void)checkNetworkStatus:(NSNotification *)notice;
- (void)loadData;

@end
