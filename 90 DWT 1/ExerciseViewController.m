//
//  ExerciseViewController.m
//  i90X
//
//  Created by Jared Grant on 7/15/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "ExerciseViewController.h"

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController
@synthesize currentReps;
@synthesize currentWeight;
@synthesize currentNotes;
@synthesize exerciseName;
@synthesize round;
@synthesize previousReps;
@synthesize previousWeight;
@synthesize previousNotes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         self.exerciseName.text,
                         self.round.text,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    int workoutIndex = [((DataNavController *)self.parentViewController).index integerValue];
    
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
            
            matches = [objects objectAtIndex:[objects count] -1];
            
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
            matches = [objects objectAtIndex:[objects count] -1];
            
            self.currentReps.placeholder = [matches valueForKey:@"reps"];
            self.currentWeight.placeholder = [matches valueForKey:@"weight"];
            self.currentNotes.placeholder = [matches valueForKey:@"notes"];
        }
        
        // This workout with this index has NOT been done befoe.
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
                             self.exerciseName.text,
                             self.round.text,
                             [((DataNavController *)self.parentViewController).index integerValue] -1];  // Previous workout index.
        [request setPredicate:pred];
        NSManagedObject *matches = nil;
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if ([objects count] == 1) {
            matches = [objects objectAtIndex:[objects count]-1];
            
            self.previousReps.text = [matches valueForKey:@"reps"];
            self.previousWeight.text = [matches valueForKey:@"weight"];
            self.previousNotes.text = [matches valueForKey:@"notes"];
        }
        
        else {
            self.previousNotes.text = @"No record for the last workout";
        }
    }
}

- (void)viewDidUnload
{
    [self setCurrentReps:nil];
    [self setCurrentWeight:nil];
    [self setCurrentNotes:nil];
    [self setExerciseName:nil];
    [self setRound:nil];
    [self setPreviousReps:nil];
    [self setPreviousWeight:nil];
    [self setPreviousNotes:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated 
{
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (mainAppDelegate.mainBannerView.bannerLoaded) 
    {
        [self.view addSubview:(mainAppDelegate.mainBannerView)];
    }
    
    mainAppDelegate.mainBannerView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self viewDidLoad];
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

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error 
{
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainAppDelegate.mainBannerView removeFromSuperview];
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner 
{
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner 
{
    AppDelegate *mainAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view addSubview:(mainAppDelegate.mainBannerView)];
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner 
{
    
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
                         self.exerciseName.text,
                         self.round.text,
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
        [newExercise setValue:self.exerciseName.text forKey:@"exercise"];
        [newExercise setValue:self.round.text forKey:@"round"];
        [newExercise setValue:((DataNavController *)self.parentViewController).routine forKey:@"routine"];
        [newExercise setValue:((DataNavController *)self.parentViewController).phase forKey:@"phase"];
        [newExercise setValue:((DataNavController *)self.parentViewController).week forKey:@"week"];
        [newExercise setValue:((DataNavController *)self.parentViewController).workout forKey:@"workout"];
        [newExercise setValue:((DataNavController *)self.parentViewController).index forKey:@"index"];
        
    } else {
        //NSLog(@"submitEntry = Match found - update existing record and save");
        
        matches = [objects objectAtIndex:[objects count]-1];
        
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
        matches = [objects objectAtIndex:[objects count]-1];
        self.currentReps.placeholder = [matches valueForKey:@"reps"];
        self.currentWeight.placeholder = [matches valueForKey:@"weight"];
        self.currentNotes.placeholder = [matches valueForKey:@"notes"];
    }
    
    self.currentReps.text = @"";
    self.currentWeight.text = @"";
    self.currentNotes.text = @"";
}

- (IBAction)hideKeyboard:(id)sender {
    [self.currentReps resignFirstResponder];
    [self.currentWeight resignFirstResponder];
    [self.currentNotes resignFirstResponder];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ResultsViewController *resultsVC = (ResultsViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"coreSynergistics"])
    {
        resultsVC.exerciseNames = ((DataNavController *)self.parentViewController).coreSynergistics;
    }
}

@end
