//
//  ComposeViewController.m
//  twitter
//
//  Created by Isaac Schaider on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "Tweet.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tweetComposerTextView.delegate = self;
    //[self.tweetComposerTextView addSubview:self.placeholderLabel];
    
    [[APIManager shared] getProfileInfo:^(User *user, NSError *error) {
        if (user) {
            NSString *profilePicURLString = user.profilePic;
            NSURL *profilePicURL = [NSURL URLWithString:profilePicURLString];
            [self.profilePicComposeImage setImageWithURL:profilePicURL];
            self.profilePicComposeImage.layer.cornerRadius = 6;
            
            self.profileNameCompose.text = [NSString stringWithFormat:@"@%@", user.name];
            self.profileHandleCompose.text = user.screenName;
        } else {
            NSLog(@"Error getting profile: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetButtonTapped:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetComposerTextView.text completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            //NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        } else {
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}


@end
