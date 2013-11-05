//
//  MeasurementsViewController.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>

@interface MeasurementsViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *weight;
@property (strong, nonatomic) IBOutlet UITextField *chest;
@property (strong, nonatomic) IBOutlet UITextField *leftArm;
@property (strong, nonatomic) IBOutlet UITextField *rightArm;
@property (strong, nonatomic) IBOutlet UITextField *waist;
@property (strong, nonatomic) IBOutlet UITextField *hips;
@property (strong, nonatomic) IBOutlet UITextField *leftThigh;
@property (strong, nonatomic) IBOutlet UITextField *rightThigh;
@property (strong, nonatomic) NSDictionary *measurementsDictonary;

- (IBAction)emailMeasurements:(id)sender;
- (IBAction)sendTwitter:(id)sender;
- (IBAction)saveMeasurements:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@end
