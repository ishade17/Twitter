//
//  TweetCell.m
//  twitter
//
//  Created by Isaac Schaider on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
        }];
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
        }
        }];
    }
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
        }];
    } else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
        }
        }];
    }
    [self refreshData];
}

- (void)refreshData {
    self.likedCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
}



@end
