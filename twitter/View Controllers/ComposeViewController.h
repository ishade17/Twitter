//
//  ComposeViewController.h
//  twitter
//
//  Created by Isaac Schaider on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end


@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePicComposeImage;
@property (weak, nonatomic) IBOutlet UILabel *profileNameCompose;
@property (weak, nonatomic) IBOutlet UILabel *profileHandleCompose;
@property (weak, nonatomic) IBOutlet UITextView *tweetComposerTextView;

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
//@property (nonatomic, strong) User *user;

@end

NS_ASSUME_NONNULL_END
