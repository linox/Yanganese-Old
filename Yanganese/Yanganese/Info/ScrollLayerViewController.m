//
//  ScrollLayerViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScrollLayerViewController.h"

@implementation ScrollLayerViewController

@synthesize textView, imageView;
@synthesize textString, image;

- (void)viewDidLoad {
	imageView.image = self.image;
	textView.text = textString;
	textView.layer.cornerRadius = kCornerRadius;
	textView.font = [UIFont fontWithName:@"Helvetica" size:16.0];
	imageView.layer.cornerRadius = kCornerRadius;
	
	CGRect textFrame = textView.frame;
	textFrame.size.height = textView.contentSize.height;
	textView.frame = textFrame;
	CGRect imageFrame = CGRectMake(kSideMargin, textFrame.size.height + 54, textFrame.size.width, 356 - textFrame.size.height - 8);
	//NSLog(@"%.2f", imageFrame.size.height);
	imageView.frame = imageFrame;
	
	[super viewDidLoad];
}

- (void)viewDidUnload {
	self.textView = nil;
	self.imageView = nil;
	self.image = nil;
	self.textString = nil;
    [super viewDidUnload];
}

@end
