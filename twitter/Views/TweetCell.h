//
//  TweetCell.h
//  twitter
//
//  Created by Isaac Schaider on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetBodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likedCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;

@end

NS_ASSUME_NONNULL_END
