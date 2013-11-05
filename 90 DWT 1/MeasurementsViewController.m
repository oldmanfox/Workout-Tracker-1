//
//  MeasurementsViewController.m
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "MeasurementsViewController.h"

@interface MeasurementsViewController ()

@end

@implementation MeasurementsViewController
@synthesize weight;
@synthesize chest;
@synthesize leftArm;
@synthesize rightArm;
@synthesize waist;
@synthesize hips;
@synthesize leftThigh;
@synthesize rightThigh;
@synthesize measurementsDictonary;

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
    
    [self loadMeasurements];
}

- (void)viewDidUnload
{
    [self setWeight:nil];
    [self setChest:nil];
    [self setLeftArm:nil];
    [self setRightArm:nil];
    [self setWaist:nil];
    [self setHips:nil];
    [self setLeftThigh:nil];
    [self setRightThigh:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)emailMeasurements:(id)sender {
    // Send email
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    [writeString appendString:[NSString stringWithFormat:@"Phase,Weight,Chest,Left Arm,Right Arm,Waist,Hips,Left Thigh,Right Thigh\n"]];
    
    [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                               self.navigationItem.title, 
                               [measurementsDictonary objectForKey:@"Weight"],
                               [measurementsDictonary objectForKey:@"Chest"], 
                               [measurementsDictonary objectForKey:@"Left Arm"], 
                               [measurementsDictonary objectForKey:@"Right Arm"], 
                               [measurementsDictonary objectForKey:@"Waist"], 
                               [measurementsDictonary objectForKey:@"Hips"],
                               [measurementsDictonary objectForKey:@"Left Thigh"], 
                               [measurementsDictonary objectForKey:@"Right Thigh"]]];
    
    NSData *csvData = [writeString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *fileName = [self.navigationItem.title stringByAppendingString:@" Measurements.csv"];
    
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
    
    NSString *subject = @"i90X";
    subject = [subject stringByAppendingFormat:@" %@ Measurements", self.navigationItem.title];
    [mailComposer setSubject:subject];
    [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:fileName];
    [self presentModalViewController:mailComposer animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendTwitter:(id)sender {
    TWTweetComposeViewController *tweetComposer;
    tweetComposer = [[TWTweetComposeViewController alloc] init];
    
    if ([TWTweetComposeViewController canSendTweet]) {
        
        //[tweetComposer setInitialText:writeString];
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

- (void)loadMeasurements {
    NSString *fileTitle = self.navigationItem.title;
    fileTitle = [fileTitle stringByAppendingString:@" Measurements.out"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileTitle]; //add our title to the path
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        // Read back in new collection
        measurementsDictonary = nil;
        measurementsDictonary = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        
        weight.text = [measurementsDictonary objectForKey:@"Weight"];
        chest.text = [measurementsDictonary objectForKey:@"Chest"];
        leftArm.text = [measurementsDictonary objectForKey:@"Left Arm"];
        rightArm.text = [measurementsDictonary objectForKey:@"Right Arm"];
        waist.text = [measurementsDictonary objectForKey:@"Waist"];
        hips.text = [measurementsDictonary objectForKey:@"Hips"];
        leftThigh.text = [measurementsDictonary objectForKey:@"Left Thigh"];
        rightThigh.text = [measurementsDictonary objectForKey:@"Right Thigh"];
    }
}

- (IBAction)saveMeasurements:(id)sender {
    NSString *fileTitle = self.navigationItem.title;
    fileTitle = [fileTitle stringByAppendingString:@" Measurements.out"];
    
    measurementsDictonary = nil;
    measurementsDictonary = [[NSDictionary alloc] initWithObjectsAndKeys:
                             weight.text, @"Weight",
                             chest.text, @"Chest",
                             leftArm.text, @"Left Arm",
                             rightArm.text, @"Right Arm",
                             waist.text, @"Waist",
                             hips.text, @"Hips",
                             leftThigh.text, @"Left Thigh",
                             rightThigh.text, @"Right Thigh", nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileTitle]; //add our title to the path
    
    // Write dictionary
    [measurementsDictonary writeToFile:fullPath atomically:YES];    
    NSLog(@"dictionary saved");
    
    UIAlertView *alert;
    
    alert = [[UIAlertView alloc] initWithTitle:@"Save Success!"
                                       message:@"Your data was successfully saved."
                                      delegate:self
                             cancelButtonTitle:@"Ok"
                             otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.weight resignFirstResponder];
    [self.chest resignFirstResponder];
    [self.leftArm resignFirstResponder];
    [self.rightArm resignFirstResponder];
    [self.waist resignFirstResponder];
    [self.hips resignFirstResponder];
    [self.leftThigh resignFirstResponder];
    [self.rightThigh resignFirstResponder];
}
@end
