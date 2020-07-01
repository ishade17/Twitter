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
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            /*for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }*/
            self.tweetsArray = (NSMutableArray *)tweets;
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
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
    
    NSURL *profilePicURL = [NSURL URLWithString:tweetInfo.user.profilePic];
    cell.profilePicImageView.image = nil;
    [cell.profilePicImageView setImageWithURL:profilePicURL];
    
    cell.profileNameLabel.text = tweetInfo.user.name;
    cell.profileHandleLabel.text = [@"@" stringByAppendingString:tweetInfo.user.screenName];
    cell.tweetDateLabel.text = tweetInfo.createdAtString;
    cell.tweetBodyLabel.text = tweetInfo.text;
    cell.retweetCountLabel.text = [NSString stringWithFormat:@"%d", tweetInfo.retweetCount];
    cell.likedCountLabel.text =[NSString stringWithFormat:@"%d", tweetInfo.favoriteCount];
    
    return cell;
}

- (void)didTweet:(id)tweet {
    [self.tweetsArray addObject:tweet]; //at beginning though
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
