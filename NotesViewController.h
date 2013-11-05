//
//  NotesViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <MessageUI/MessageUI.h>
#import "DataNavController.h"
#import "AppDelegate.h"
#import "Workout_AbRipper_ResultsViewController.h"
#import "UIViewController+Social.h"

@interface NotesViewController : UIViewController <ADBannerViewDelegate, MFMailComposeViewControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *currentNotes;
@property (weak, nonatomic) IBOutlet UILabel *exerciseName;
@property (weak, nonatomic) IBOutlet UILabel *round;
@property (weak, nonatomic) IBOutlet UITextView *previousNotes;

- (IBAction)submitEntry:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)emailResults:(id)sender;
- (IBAction)sendTwitter:(id)sender;

@end
