//
//  ExerciseViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/15/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "ExerciseViewController.h"
#import "SWRevealViewController.h"
#import "ScatterPlotViewController.h"

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setUpVariables {
    
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mainAppDelegate.routine = ((DataNavController *)self.parentViewController).routine;
    mainAppDelegate.week = ((DataNavController *)self.parentViewController).week;
    mainAppDelegate.workout =((DataNavController *)self.parentViewController).workout;
    mainAppDelegate.index = ((DataNavController *)self.parentViewController).index;
    mainAppDelegate.exerciseName = self.currentExercise.title;
    mainAppDelegate.exerciseRound = self.renamedRound;
}

- (void)renameRoundText {
    
    if ([self.roundButton.title isEqualToString:@"R1"]) {
        self.renamedRound = @"Round 1";
    }
    
    else if ([self.roundButton.title isEqualToString:@"R2"])
    {
        self.renamedRound = @"Round 2";
    }
    
    else if ([self.roundButton.title isEqualToString:@"R3"])
    {
        self.renamedRound = @"Round 3";
    }
}

-(void)keyboardType {
    
    // Set keyboard type
    if (self.view.frame.size.width <= 640) {
        
        // IPHONE - Set the keyboard type of the REPS text box to DECIMAL NUMBER PAD.
        self.currentReps.keyboardType = UIKeyboardTypeDecimalPad;
        
        // Set the keyboard type of the WEIGHT field
        if ([((MainTBC *)self.parentViewController.parentViewController).bandSetting isEqualToString:@"ON"]) {
            self.currentWeight.keyboardType = UIKeyboardTypeDefault;
        }
        
        else {
            self.currentWeight.keyboardType = UIKeyboardTypeDecimalPad;
        }
    }
    
    else {
        
        // IPAD - No decimal pad on ipad so set it to numbers and punctuation.
        self.currentReps.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        // Set the keyboard type of the WEIGHT field
        if ([((MainTBC *)self.parentViewController.parentViewController).bandSetting isEqualToString:@"ON"]) {
            self.currentWeight.keyboardType = UIKeyboardTypeDefault;
        }
        
        else {
            self.currentWeight.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
    }
}

-(void)queryDatabase {
    
    // Get Data from the database.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.currentExercise.title,
                         self.renamedRound,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    int workoutIndex = [((DataNavController *)self.parentViewController).index intValue];
    //NSLog(@"Workout = %@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
    
    // 1st time exercise is done only.
    if (workoutIndex == 1) {
        // The workout has not been done before.
        // Do NOT get previous workout data.
        // Set the current placeholders to defaults/nil.
        
        if ([objects count] == 0) {
            //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
            
            self.currentReps.placeholder = @"0";
            self.currentWeight.placeholder = @"0.0";
            self.currentNotes.placeholder = @"Type any notes here";
            
            self.previousReps.text = @"";
            self.previousWeight.text = @"";
            self.previousNotes.text = @"";
        }
        
        // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
        // Only use the current 1st week workout data when the user comes back to this screen.
        
        else {
            //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
            
            matches = objects[[objects count] -1];
            
            self.currentReps.placeholder = @"";
            self.currentWeight.placeholder = @"";
            self.currentNotes.placeholder = @"";
            
            self.previousReps.text = [matches valueForKey:@"reps"];
            self.previousWeight.text = [matches valueForKey:@"weight"];
            self.previousNotes.text = [matches valueForKey:@"notes"];
        }
        
    }
    
    // 2nd time exercise has been done and beyond.
    else {
        
        // This workout with this index has been done before.
        // User came back to look at his results so display this weeks results in the current results section.
        if ([objects count] == 1) {
            matches = objects[[objects count] -1];
            
            self.currentReps.placeholder = [matches valueForKey:@"reps"];
            self.currentWeight.placeholder = [matches valueForKey:@"weight"];
            self.currentNotes.placeholder = [matches valueForKey:@"notes"];
            //NSLog(@"Current Reps = %@", self.currentReps.placeholder);
            //NSLog(@"Current Weight = %@", self.currentWeight.placeholder);
            //NSLog(@"Current Notes = %@", self.currentNotes.placeholder);
        }
        
        // This workout with this index has NOT been done before.
        // Set the current placeholders to defaults/nil.
        else {
            self.currentReps.placeholder = @"0";
            self.currentWeight.placeholder = @"0.0";
            self.currentNotes.placeholder = @"Type any notes here";
        }
        
        // This is at least the 2nd time a particular workout has been started.
        // Get the previous workout data and present it to the user in the previous section.
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                             ((DataNavController *)self.parentViewController).routine,
                             ((DataNavController *)self.parentViewController).workout,
                             self.currentExercise.title,
                             self.renamedRound,
                             [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects count] == 1) {
            matches = objects[[objects count]-1];
            
            self.previousReps.text = [matches valueForKey:@"reps"];
            self.previousWeight.text = [matches valueForKey:@"weight"];
            self.previousNotes.text = [matches valueForKey:@"notes"];
            //NSLog(@"Previous Reps = %@", self.previousReps.text);
            //NSLog(@"Previous Weight = %@", self.previousWeight.text);
            //NSLog(@"Previous Notes = %@", self.previousNotes.text);
        }
        
        else {
            self.previousReps.text = @"";
            self.previousWeight.text = @"";
            self.previousNotes.text = @"No record for the last workout";
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self configureViewForIOSVersion];
    [self keyboardType];
    [self renameRoundText];
    [self queryDatabase];
    
    if (self.view.frame.size.width < 768) {
        [self createSliderButton];
    }
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iPhone
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"4bed96fcb70a4371b972bf19d149e433"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"7c80f30698634a22b77778b084e3087e"
                                                        size:MOPUB_LEADERBOARD_SIZE];
            self.bannerSize = MOPUB_LEADERBOARD_SIZE;
            
        }
        
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.view.bounds.size.height - self.bannerSize.height - self.tabBarController.tabBar.bounds.size.height,
                                       self.bannerSize.width, self.bannerSize.height);
        
        [self.view addSubview:self.adView];
        
        [self.adView loadAd];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self setUpVariables];
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        self.adView.delegate = nil;
        self.adView = nil;
        [self.adView removeFromSuperview];
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        self.adView.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self renameRoundText];
    [self setUpVariables];
    [self queryDatabase];
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // Don't show ads.
        self.adView.delegate = nil;
        self.adView = nil;
        [self.adView removeFromSuperview];
        
    } else {
        
        // Show ads
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                      self.view.bounds.size.height - self.bannerSize.height - self.tabBarController.tabBar.bounds.size.height,
                                       self.bannerSize.width, self.bannerSize.height);
        self.adView.hidden = NO;
    }
}

- (void)createSliderButton {
    
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.slidergraph"]) {
        
        //NSLog(@"Allow Slider");
        self.sliderButton.enabled = YES;
        
        // Slider Setup
        [self.sliderButton setTarget: self.revealViewController];
        [self.sliderButton setAction: @selector(revealToggle:)];
        [self.toolbar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submitEntry:(id)sender
{
    NSDate *todaysDate = [NSDate date];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.currentExercise.title,
                         self.renamedRound,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        //NSLog(@"submitEntry = No matches - create new record and save");
        
        NSManagedObject *newExercise;
        newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Workout" inManagedObjectContext:context];
        [newExercise setValue:self.currentReps.text forKey:@"reps"];
        [newExercise setValue:self.currentWeight.text forKey:@"weight"];
        [newExercise setValue:self.currentNotes.text forKey:@"notes"];
        [newExercise setValue:todaysDate forKey:@"date"];
        [newExercise setValue:self.currentExercise.title forKey:@"exercise"];
        [newExercise setValue:self.renamedRound forKey:@"round"];
        [newExercise setValue:((DataNavController *)self.parentViewController).routine forKey:@"routine"];
        [newExercise setValue:((DataNavController *)self.parentViewController).month forKey:@"month"];
        [newExercise setValue:((DataNavController *)self.parentViewController).week forKey:@"week"];
        [newExercise setValue:((DataNavController *)self.parentViewController).workout forKey:@"workout"];
        [newExercise setValue:((DataNavController *)self.parentViewController).index forKey:@"index"];
        
    } else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        matches = objects[[objects count]-1];
        
        // Only update the fields that have been changed.
        if (self.currentReps.text.length != 0) {
            [matches setValue:self.currentReps.text forKey:@"reps"];
            
        }
        if (self.currentWeight.text.length != 0) {
            [matches setValue:self.currentWeight.text forKey:@"weight"];
            
        }
        if (self.currentNotes.text.length != 0) {
            [matches setValue:self.currentNotes.text forKey:@"notes"];
        }
        [matches setValue:todaysDate forKey:@"date"];
        
    }
    
    [context save:&error];
    
    [request setPredicate:pred];
    matches = nil;
    objects = nil;
    objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 1) {
        matches = objects[[objects count]-1];
        self.currentReps.placeholder = [matches valueForKey:@"reps"];
        self.currentWeight.placeholder = [matches valueForKey:@"weight"];
        self.currentNotes.placeholder = [matches valueForKey:@"notes"];
    }
    
    self.currentReps.text = @"";
    self.currentWeight.text = @"";
    self.currentNotes.text = @"";
    
    [self hideKeyboard:sender];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.currentReps resignFirstResponder];
    [self.currentWeight resignFirstResponder];
    [self.currentNotes resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ResultsViewController *resultsVC = (ResultsViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"coreFitness"])
    {
        resultsVC.exerciseNames = ((DataNavController *)self.parentViewController).coreFitness;
    }
}

- (void)configureViewForIOSVersion {
    
    // Colors
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    UIColor *midGrey = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f];
    UIColor *darkGrey = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f];
    UIColor* blueColor = [UIColor colorWithRed:0/255.0f green:122/255.0f blue:255/255.0f alpha:1.0f];
    
    //UIColor *midGreyLaunch = [UIColor colorWithRed:219/255.0f green:218/255.0f blue:218/255.0f alpha:1.0f];
    
    UIColor *lightGreyBlueColor = [UIColor colorWithRed:219/255.0f green:224/255.0f blue:234/255.0f alpha:1.0f];
    
    // Apply Text Colors
    self.currentRepsLabel.textColor = blueColor;
    self.currentWeightLabel.textColor = blueColor;
    self.currentNotesLabel.textColor = blueColor;
    
    self.previousRepsLabel.textColor = darkGrey;
    self.previousWeightLabel.textColor = darkGrey;
    self.previousNotesLabel.textColor = darkGrey;
    
    self.previousReps.textColor = darkGrey;
    self.previousWeight.textColor = darkGrey;
    self.previousNotes.textColor = darkGrey;
    
    self.sliderButton.tintColor = blueColor;
    self.currentExercise.tintColor = blueColor;
    self.roundButton.tintColor = blueColor;
    
    self.currentExercise.style = UIBarButtonItemStyleDone;
    
    // Apply Background Colors
    self.previousReps.backgroundColor = lightGreyBlueColor;
    self.previousWeight.backgroundColor = lightGreyBlueColor;
    self.previousNotes.backgroundColor = lightGreyBlueColor;
    
    self.view.backgroundColor = lightGrey;
    self.toolbar.backgroundColor = midGrey;
    
    // Launch Image Color
    //self.view.backgroundColor = midGreyLaunch;
    
    // Apply Keyboard Color
    self.currentReps.keyboardAppearance = UIKeyboardAppearanceDark;
    self.currentWeight.keyboardAppearance = UIKeyboardAppearanceDark;
    self.currentNotes.keyboardAppearance = UIKeyboardAppearanceDark;
    
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.view.bounds.size.height - size.height - self.tabBarController.tabBar.bounds.size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    self.adView.hidden = YES;
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize size = [self.adView adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.view.bounds.size.height - size.height - self.tabBarController.tabBar.bounds.size.height;
    self.adView.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    self.adView.hidden = NO;
}
@end
