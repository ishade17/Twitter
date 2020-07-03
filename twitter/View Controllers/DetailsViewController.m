//
//  DetailsViewController.m
//  twitter
//
//  Created by Isaac Schaider on 7/2/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "Tweet.h"

@interface DetailsViewController ()
//@property (weak, nonatomic) IBOutlet UIButton *retweetButtonDetails;
//@property (weak, nonatomic) IBOutlet UIButton *likeButtonDetails;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *profilePicURL = [NSURL URLWithString:self.tweet.user.profilePic];
    self.detailsProfilePicImageView.image = nil;
    [self.detailsProfilePicImageView setImageWithURL:profilePicURL];
    self.detailsProfilePicImageView.layer.cornerRadius = 6;
    
    self.detailsProfileNameLabel.text = self.tweet.user.name;
    self.detailsProfileHandleLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.detailsTweetDateLabel.text = self.tweet.timeAgoString;
    self.detailsTweetBodyLabel.text = self.tweet.text;
    self.detailsRetweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.detailsLikedCountLabel.text =[NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    if (self.tweet.retweeted == YES) {
        [self.detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [self.detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.favorited == YES) {
        [self.detailsLikeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [self.detailsLikeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)didTapRetweetDetails:(id)sender {
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self.detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            //NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        } else {
            //NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
        }];
    } else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        [self.detailsRetweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            //NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
        } else {
            //NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
        }
        }];
    }
    [self refreshData];
}

- (IBAction)didTapFavoriteDetails:(id)sender {
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [self.detailsLikeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            //NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        } else {
            //NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
        }];
    } else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [self.detailsLikeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            //NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
        } else {
            //NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
        }
        }];
    }
    [self refreshData];
}

- (void)refreshData {
    self.detailsLikedCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.detailsRetweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
}

@end
