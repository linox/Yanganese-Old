//
//  ScrollLayerViewController.h
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ScrollLayerViewController : UIViewController {
	UITextView *textView;
	UIImageView *imageView;

	UIImage *image;
	NSString *textString;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *textString;

@end
