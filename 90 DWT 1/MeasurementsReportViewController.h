//
//  MeasurementsReportViewController.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

@interface MeasurementsReportViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *htmlView;
@property (strong, nonatomic) NSDictionary *phase1Dict;
@property (strong, nonatomic) NSDictionary *phase2Dict;
@property (strong, nonatomic) NSDictionary *phase3Dict;
@property (strong, nonatomic) NSDictionary *finalDict;

- (IBAction)emailSummary:(id)sender;
- (IBAction)sendTweet:(id)sender;
@end
