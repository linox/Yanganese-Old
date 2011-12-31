//
//  CustomQuizCell.h
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"

@interface CustomQuizCell : UITableViewCell {
	// contains icon image
	UIImageView *iconView;
	// displays author label
    UILabel *authorLabel;
	// displays quiz name
    UILabel *nameLabel;
	// contains rating image
	RatingView *ratingView;

	// stores rating
	float rating;	
}

@property (nonatomic, retain) IBOutlet UIImageView *iconView;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet RatingView *ratingView;
@property float rating;

@end