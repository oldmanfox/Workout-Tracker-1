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

// Current Labels
@property (weak, nonatomic) IBOutlet UILabel *currentRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentNotesLabel;

// Current TextFields
@property (weak, nonatomic) IBOutlet UITextField *currentReps;
@property (weak, nonatomic) IBOutlet UITextField *currentWeight;
@property (weak, nonatomic) IBOutlet UITextField *currentNotes;

// Previous Labels
@property (weak, nonatomic) IBOutlet UILabel *previousRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *previousWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *previousNotesLabel;

// Previous TextFields
@property (weak, nonatomic) IBOutlet UITextField *previousReps;
@property (weak, nonatomic) IBOutlet UITextField *previousWeight;
@property (weak, nonatomic) IBOutlet UITextField *previousNotes;

// Toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sliderButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *roundButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *currentExercise;

@property (weak, nonatomic) IBOutlet UIButton *hideKeyboardButton;
@property (weak, nonatomic) NSString *renamedRound;

- (IBAction)submitEntry:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
