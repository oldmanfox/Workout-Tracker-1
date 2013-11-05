//
//  NotesViewController.h
//  i90X
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import "DataNavController.h"
#import "AppDelegate.h"
#import "Workout_AbRipper_ResultsViewController.h"
#import "AppDelegate.h"

@interface NotesViewController : UIViewController <ADBannerViewDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *currentNotes;
@property (strong, nonatomic) IBOutlet UILabel *exerciseName;
@property (strong, nonatomic) IBOutlet UILabel *round;
@property (strong, nonatomic) IBOutlet UITextView *previousNotes;

- (IBAction)submitEntry:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)emailResults:(id)sender;
- (IBAction)sendTwitter:(id)sender;

@end
