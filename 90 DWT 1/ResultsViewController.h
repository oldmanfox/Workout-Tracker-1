//
//  ResultsViewController.h
//  i90X
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "DataNavController.h"
#import "AppDelegate.h"

@interface ResultsViewController : UIViewController <ADBannerViewDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *workoutSummary;
@property (strong, nonatomic) NSArray *exerciseNames;

- (IBAction)emailResults:(id)sender;
- (IBAction)sendTwitter:(id)sender;

@end