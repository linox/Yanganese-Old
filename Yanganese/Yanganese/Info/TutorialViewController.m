//
//  TutorialViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TutorialViewController.h"
#import "ScrollLayerViewController.h"

#define kTutorialNumberOfPages 3

static NSString *kTutorialName = @"tutorial";

@implementation TutorialViewController

@synthesize scrollView;
@synthesize viewControllers;
@synthesize textArray, imageArray;
@synthesize pageControl;

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0 || page >= kTutorialNumberOfPages) 
		return;
	
    ScrollLayerViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
		controller = [[ScrollLayerViewController alloc] initWithNibName:@"ScrollLayerViewController" bundle:nil];
		controller.textString = [textArray objectAtIndex:page];
		NSString *name = [imageArray objectAtIndex:page];
		if(!([name isEqualToString:@""]))
			controller.image = [UIImage imageNamed:name];
		[viewControllers replaceObjectAtIndex:page withObject:controller];
    }
	
    if (controller.view.superview == nil) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
	
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
    pageControlUsed = YES;
}

- (void)viewDidLoad {
	self.title = @"Tutorial";
	
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kTutorialNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
		
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kTutorialNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
	NSString *path = [[NSBundle mainBundle] pathForResource:kTutorialName ofType:@"plist"];
	NSDictionary *info = [[NSDictionary alloc] initWithContentsOfFile:path];
	NSArray *text = [info objectForKey:@"Text"];
	self.textArray = text;
	NSArray *image = [info objectForKey:@"Image"];
	self.imageArray = image;

	pageControl.numberOfPages = kTutorialNumberOfPages;
	pageControl.layer.cornerRadius = kCornerRadius;
	pageControl.currentPage = 0;
		
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];

	[super viewDidLoad];
}

- (void)viewDidUnload {
	self.scrollView = nil;
	self.pageControl = nil;
	self.viewControllers = nil;
	self.textArray = nil;
	self.imageArray = nil;
	[super viewDidUnload];
}

#pragma mark -
#pragma mark Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {

	if (pageControlUsed)
        return;
	
	CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

@end
