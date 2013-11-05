//
//  NotesViewController.m
//  i90X
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "NotesViewController.h"

@interface NotesViewController ()

@end

@implementation NotesViewController
@synthesize currentNotes;
@synthesize exerciseName;
@synthesize round;
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
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
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
        
        if ([objects count] == 0) {
            //NSLog(@"viewDidLoad = No matches - Exercise has not been done before - set previous textfields to nil");
            
            self.currentNotes.text = @"Type any notes here";
            self.previousNotes.text = @"";
        }
        
        // The workout has been done 1 time but the user came back to the 1st week workout screen to update or view.
        // Only use the current 1st week workout data when the user comes back to this screen.
        
        else {
            //NSLog(@"viewDidLoad = Match found - set previous textfields to stored values for this weeks workout");
            
            matches = [objects objectAtIndex:[objects count] -1];
            
            self.previousNotes.text = [matches valueForKey:@"notes"];
        }
        
    }
    
    // 2nd time exercise has been done and beyond.
    else {
        // This workout with this index has been done before.
        // User came back to look at his results so display this weeks results in the current results section.
        
        if ([objects count] == 1) {
            matches = [objects objectAtIndex:[objects count] -1];
            
            self.currentNotes.text = [matches valueForKey:@"notes"];
        }
        
        // This workout with this index has NOT been done befoe.
        // Set the current placeholders to defaults/nil.
        else {
            self.currentNotes.text = @"Type any notes here";
        }
        
        // This is at least the 2nd time a particular workout has been started.
        // Get the previous workout data and present it to the user in the previous section.
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(workout = %@) AND (exercise = %@) AND (round = %@) AND (index = %d)",
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
            
            self.previousNotes.text = [matches valueForKey:@"notes"];
        }
        
        else {
            self.previousNotes.text = @"No record for the last workout";
        }
    }
}

- (void)viewDidUnload
{
    [self setCurrentNotes:nil];
    [self setExerciseName:nil];
    [self setRound:nil];
    [self setPreviousNotes:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
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

- (IBAction)submitEntry:(id)sender {
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
        
        self.currentNotes.text = [matches valueForKey:@"notes"];
    }
    
    self.currentNotes.textColor = [UIColor grayColor];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.currentNotes resignFirstResponder];
}

- (IBAction)emailResults:(id)sender 
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Workout" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(routine = %@) AND (workout = %@) AND (index = %d)",
                         ((DataNavController *)self.parentViewController).routine,
                         ((DataNavController *)self.parentViewController).workout,
                         [((DataNavController *)self.parentViewController).index integerValue]];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    
    if ([objects count] != 0)
    {
        // Get data from database
        
        [writeString appendString:[NSString stringWithFormat:@"Routine,Phase,Week,Workout,Notes,Date\n"]];
        
        for (int i = 0; i < [objects count]; i++) {
            matches = [objects objectAtIndex:i];
            NSString *routine =     [matches valueForKey:@"routine"];
            NSString *phase =       [matches valueForKey:@"phase"];
            NSString *week  =       [matches valueForKey:@"week"];
            NSString *workout =     [matches valueForKey:@"workout"];
            NSString *notes =       [matches valueForKey:@"notes"];
            NSString *date =        [matches valueForKey:@"date"];
            
            [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@\n",
                                       routine, phase, week, workout, notes, date]];
        }
    }
    
    // Send email
    
    NSData *csvData = [writeString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *workoutName = ((DataNavController *)self.parentViewController).workout;
    workoutName = [workoutName stringByAppendingString:@".csv"];
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    
    // Array to store the default email address.
    NSArray *emailAddresses; 
    
    // Get path to documents directory to get default email address.
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *defaultEmailFile = nil;
    defaultEmailFile = [docDir stringByAppendingPathComponent:@"Default Email.out"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:defaultEmailFile]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultEmailFile];
        
        NSString *defaultEmail = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        
        // There is a default email address.
        emailAddresses = [[NSArray alloc] initWithObjects:defaultEmail, nil];
    }
    else {
        // There is NOT a default email address.  Put an empty email address in the arrary.
        emailAddresses = [[NSArray alloc] initWithObjects:@"", nil];
    }
    
    [mailComposer setToRecipients:emailAddresses];
    [mailComposer setSubject:@"i90X Workout Data"];
    [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:workoutName];
    [self presentModalViewController:mailComposer animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendTwitter:(id)sender 
{
    TWTweetComposeViewController *tweetComposer;
    tweetComposer = [[TWTweetComposeViewController alloc] init];
    if ([TWTweetComposeViewController canSendTweet]) {
        //[tweetComposer setInitialText:@"I'm on my way."];
        [self presentModalViewController:tweetComposer animated:YES];
    }else {
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc]
                       initWithTitle:@"Unable To Tweet Right Now."
                       message:@"Please ensure you are connected to a network and that your device is enabled to send Tweets by checking your device Settings -> Twitter tab."
                       delegate: nil
                       cancelButtonTitle: @"Ok"
                       otherButtonTitles: nil];
        [alertDialog show];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *workoutName = ((DataNavController *)self.parentViewController).workout;
    Workout_AbRipper_ResultsViewController *summaryVC = (Workout_AbRipper_ResultsViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"toSummary"])
    {
        if ([workoutName isEqualToString:@"Chest + Back & Abs"]) {
            summaryVC.exerciseNames = ((DataNavController *)self.parentViewController).chestBack;
        }
        
        if ([workoutName isEqualToString:@"Shoulders + Arms & Ab Ripper X"]) {
            summaryVC.exerciseNames = ((DataNavController *)self.parentViewController).shouldersArms;
        }
        
        if ([workoutName isEqualToString:@"Legs + Back & Ab Ripper X"]) {
            summaryVC.exerciseNames = ((DataNavController *)self.parentViewController).legsBack;
        }
        
        if ([workoutName isEqualToString:@"Chest + Shoulders + Triceps & Ab Ripper X"]) {
            summaryVC.exerciseNames = ((DataNavController *)self.parentViewController).chestShouldersTriceps;
        }
        
        if ([workoutName isEqualToString:@"Back + Biceps & Ab Ripper X"]) {
            summaryVC.exerciseNames = ((DataNavController *)self.parentViewController).backBiceps;
        }
    }
}
@end