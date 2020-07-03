//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailsViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tweetsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeTweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchFeed];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchFeed) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)fetchFeed {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            //NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweetsArray = (NSMutableArray *)tweets;
        } else {
            //NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *tweetInfo = self.tweetsArray[indexPath.row];
    cell.tweet = tweetInfo;
    
    if (cell.tweet.retweeted == YES) {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    if (cell.tweet.favorited == YES) {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    NSURL *profilePicURL = [NSURL URLWithString:tweetInfo.user.profilePic];
    cell.profilePicImageView.image = nil;
    [cell.profilePicImageView setImageWithURL:profilePicURL];
    cell.profilePicImageView.layer.cornerRadius = 6;
    
    cell.profileNameLabel.text = tweetInfo.user.name;
    cell.profileHandleLabel.text = [@"@" stringByAppendingString:tweetInfo.user.screenName];
    cell.tweetDateLabel.text = tweetInfo.timeAgoString;
    cell.tweetBodyLabel.text = tweetInfo.text;
    cell.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweetInfo.retweetCount];
    cell.likedCountLabel.text = [NSString stringWithFormat:@"%d", tweetInfo.favoriteCount];
    
    return cell;
}

- (void)didTweet:(id)tweet {
    [self.tweetsArray insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

- (IBAction)tappedLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier  isEqual: @"tweetCompose"]){
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeView = (ComposeViewController *)navigationController.topViewController;
        composeView.delegate = self;
        
    } else if ([segue.identifier  isEqual: @"tweetDetails"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *passedTweet = self.tweetsArray[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = passedTweet;
    }
}



@end
