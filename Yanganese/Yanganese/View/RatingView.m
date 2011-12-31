//
//  RatingView.m
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RatingView.h"

#define kMaxRating 5.0

@implementation RatingView

- (void)commonInit
{
    backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsBackground.png"]];
    backgroundView.contentMode = UIViewContentModeLeft;
    [self addSubview:backgroundView];
    
    foregroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsForeground.png"]];
    foregroundView.contentMode = UIViewContentModeLeft;
    foregroundView.clipsToBounds = YES;
    [self addSubview:foregroundView];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
		[self commonInit];
	
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
        [self commonInit];
    
    return self;
}

- (void)setRating:(float)newRating
{
    rating = newRating;
	int backWidth = backgroundView.frame.size.width;
	int frontWidth = foregroundView.bounds.size.height;
    foregroundView.frame = CGRectMake(0.0, 0.0, backWidth * (rating / kMaxRating), frontWidth);
}

- (float)rating
{
    return rating;
}

@end