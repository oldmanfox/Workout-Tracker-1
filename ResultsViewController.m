//
//  ResultsViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/17/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

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
        for (int a = 0; a < [self.exerciseNames count]; a++)
        {
            BOOL matchFound = false;
            NSString *arrayExerciseNameRound = self.exerciseNames[a];
            
            // Remove the (Round #) at the end of the exercise name.
            NSString *exerciseNameClean = [arrayExerciseNameRound substringToIndex:[arrayExerciseNameRound length] - 8];
            
            for (int i = 0; i < [objects count]; i++) 
            {
                matches = objects[i];
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
    
    self.workoutSummary.text = writeString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)viewWillAppear:(BOOL)animated 
{

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

}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner 
{
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner 
{
    
}

- (void)bannerViewWillLoadAd:(ADBannerView *)banner 
{
    
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
        [writeString appendString:[NSString stringWithFormat:@"Routine,Month,Week,Workout,Round,Exercise,Reps,Weight,Notes,Date\n"]];
        for (int a = 0; a < [self.exerciseNames count]; a++) 
        {
            BOOL matchFound = false;
            NSString *arrayExerciseNameRound = self.exerciseNames[a];
            
            // Remove the (Round #) at the end of the exercise name.
            NSString *exerciseNameClean = [arrayExerciseNameRound substringToIndex:[arrayExerciseNameRound length] - 8];
            
            for (int i = 0; i < [objects count]; i++) 
            {
                matches = objects[i];
                NSString *routine =     [matches valueForKey:@"routine"];
                NSString *month =       [matches valueForKey:@"month"];
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
                                               routine, month, week, workout, round, exercise, reps, weight, notes, date]];
                    matchFound = true;
                }
            }
            
            if (!matchFound) 
            {
                [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,,%@,,,,\n",
                                           ((DataNavController *)self.parentViewController).routine,
                                           ((DataNavController *)self.parentViewController).month,
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
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *defaultEmailFile = nil;
    defaultEmailFile = [docDir stringByAppendingPathComponent:@"Default Email.out"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:defaultEmailFile]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultEmailFile];
        
        NSString *defaultEmail = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        
        // There is a default email address.
        emailAddresses = @[defaultEmail];
    }
    else {
        // There is NOT a default email address.  Put an empty email address in the arrary.
        emailAddresses = @[@""];
    }
    
    [mailComposer setToRecipients:emailAddresses];
    [mailComposer setSubject:@"90 DWT 1 Workout Data"];
    [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:workoutName];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendTwitter:(id)sender 
{
    [self twitter];
}
@end