//
//  ExerciseViewController.h
//  90 DWT 1
//
//  Created by Jared Grant on 7/15/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "DataNavController.h"
#import "AppDelegate.h"
#import "ResultsViewController.h"
#import "MainTBC.h"
#import "ScatterPlotViewController.h"
#import "DWT1IAPHelper.h"

@interface ExerciseViewController : UIViewController <ADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *currentReps;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes;
@property (weak, nonatomic) IBOutlet UILabel *exerciseName;
@property (weak, nonatomic) IBOutlet UILabel *round;
@property (weak, nonatomic) IBOutlet UITextField *previousReps;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes;

@property (weak, nonatomic) IBOutlet UIToolbar *sliderToolbar;

- (IBAction)submitEntry:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
