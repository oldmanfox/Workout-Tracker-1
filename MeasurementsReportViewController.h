//
//  MeasurementsReportViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UIViewController+Social.h"

@interface MeasurementsReportViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *htmlView;
@property (strong, nonatomic) NSDictionary *month1Dict;
@property (strong, nonatomic) NSDictionary *month2Dict;
@property (strong, nonatomic) NSDictionary *month3Dict;
@property (strong, nonatomic) NSDictionary *finalDict;

- (IBAction)emailSummary:(id)sender;
- (IBAction)sendTweet:(id)sender;
@end
