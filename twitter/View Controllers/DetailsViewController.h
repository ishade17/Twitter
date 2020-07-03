//
//  DetailsViewController.h
//  twitter
//
//  Created by Isaac Schaider on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *detailsProfilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailsProfileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsProfileHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsTweetDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsTweetBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsRetweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLikedCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailsRetweetButton;
@property (weak, nonatomic) IBOutlet UIButton *detailsLikeButton;


@end

NS_ASSUME_NONNULL_END
