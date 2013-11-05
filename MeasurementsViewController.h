//
//  MeasurementsViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UIViewController+Social.h"

@interface MeasurementsViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *chest;
@property (weak, nonatomic) IBOutlet UITextField *leftArm;
@property (weak, nonatomic) IBOutlet UITextField *rightArm;
@property (weak, nonatomic) IBOutlet UITextField *waist;
@property (weak, nonatomic) IBOutlet UITextField *hips;
@property (weak, nonatomic) IBOutlet UITextField *leftThigh;
@property (weak, nonatomic) IBOutlet UITextField *rightThigh;
@property (strong, nonatomic) NSDictionary *measurementsDictonary;

- (IBAction)emailMeasurements:(id)sender;
- (IBAction)sendTwitter:(id)sender;
- (IBAction)saveMeasurements:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@end
