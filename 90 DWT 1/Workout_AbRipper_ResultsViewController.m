//
//  Workout_AbRipper_ResultsViewController.m
//  i90X
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "Workout_AbRipper_ResultsViewController.h"

@interface Workout_AbRipper_ResultsViewController ()

@end

@implementation Workout_AbRipper_ResultsViewController
@synthesize workoutSummary;
@synthesize exerciseNames;

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
        for (int a = 0; a < [exerciseNames count]; a++) 
        {
            BOOL matchFound = false;
            NSString *arrayExerciseNameRound = [exerciseNames objectAtIndex:a];
            NSString *exerciseNameClean = [arrayExerciseNameRound substringToIndex:[arrayExerciseNameRound length] - 8];
            
            for (int i = 0; i < [objects count]; i++) 
            {
                matches = [objects objectAtIndex:i];
                NSString *exercise = [matches valueForKey:@"exercise"];
                NSString *reps = [matches valueForKey:@"reps"];
                NSString *weight = [matches valueForKey:@"weight"];
                NSString *notes = [matches valueForKey:@"notes"];
                NSString *round = [matches valueForKey:@"round"];
                
                
                NSString *combinedExerciseNameRound = [exercise stringByAppendingString:@" "];
                combinedExerciseNameRound = [combinedExerciseNameRound stringByAppendingString:round];
                
                if ([arrayExerciseNameRound isEqualToString:combinedExerciseNameRound]) 
                {
                    [writeString appendString:[NSString stringWithFormat:@"%@ \n  Reps: %@  Wt: %@ \n  Notes: %@ \n\n",
                                               exercise, reps, weight, notes]];
                    matchFound = true;
                }
            }
            
            if (!matchFound) 
            {
                [writeString appendString:[NSString stringWithFormat:@"%@ \n  Reps:    Wt:   \n  Notes: \n\n", exerciseNameClean]]; 
            }
        }
    }
    workoutSummary.text = writeString;
}

- (void)viewDidUnload
{
    [self setWorkoutSummary:nil];
    [self setExerciseNames:nil];
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

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
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
        [writeString appendString:[NSString stringWithFormat:@"Routine,Phase,Week,Workout,Round,Exercise,Reps,Weight,Notes,Date\n"]];
        for (int a = 0; a < [exerciseNames count]; a++) 
        {
            BOOL matchFound = false;
            NSString *arrayExerciseNameRound = [exerciseNames objectAtIndex:a];
            
            // Remove the (Round #) at the end of the exercise name.
            NSString *exerciseNameClean = [arrayExerciseNameRound substringToIndex:[arrayExerciseNameRound length] - 8];
            
            for (int i = 0; i < [objects count]; i++) 
            {
                matches = [objects objectAtIndex:i];
                NSString *routine =     [matches valueForKey:@"routine"];
                NSString *phase =       [matches valueForKey:@"phase"];
                NSString *week  =       [matches valueForKey:@"week"];
                NSString *workout =     [matches valueForKey:@"workout"];
                NSString *round =       [matches valueForKey:@"round"];
                NSString *exercise =    [matches valueForKey:@"exercise"];
                NSString *reps =        [matches valueForKey:@"reps"];
                NSString *weight =      [matches valueForKey:@"weight"];
                NSString *notes =       [matches valueForKey:@"notes"];
                NSString *date =        [matches valueForKey:@"date"];
                
                NSString *combinedExerciseNameRound = [exercise stringByAppendingString:@" "];
                combinedExerciseNameRound = [combinedExerciseNameRound stringByAppendingString:round];
                
                if ([arrayExerciseNameRound isEqualToString:combinedExerciseNameRound]) 
                {
                    [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                                               routine, phase, week, workout, round, exercise, reps, weight, notes, date]];
                    matchFound = true;
                }
            }
            
            if (!matchFound) 
            {
                [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,,%@,,,,\n",
                                           ((DataNavController *)self.parentViewController).routine,
                                           ((DataNavController *)self.parentViewController).phase,
                                           ((DataNavController *)self.parentViewController).week,
                                           ((DataNavController *)self.parentViewController).workout,
                                           exerciseNameClean]];
            }
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
@end