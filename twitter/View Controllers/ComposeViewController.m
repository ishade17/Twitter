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

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetComposerTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButtonItem;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetButtonTapped:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetComposerTextView.text completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
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
