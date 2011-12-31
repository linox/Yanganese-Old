//
//  RatingView.h
//  Yanganese
//
//  Created by Michael Yang on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingView : UIView
{
    float rating;
    UIImageView *backgroundView;
    UIImageView *foregroundView;
}

@property float rating;

@end
