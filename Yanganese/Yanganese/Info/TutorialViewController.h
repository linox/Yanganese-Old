//
//  TutorialViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIPageControl *pageControl;
	
    NSMutableArray *viewControllers;
	NSArray *textArray;
	NSArray *imageArray;
	
	BOOL pageControlUsed;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) NSArray *textArray;
@property (nonatomic, retain) NSArray *imageArray;

- (void)loadScrollViewWithPage:(int)page;
- (IBAction)changePage:(id)sender;

@end
