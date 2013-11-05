//
//  MeasurementsViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "MeasurementsViewController.h"

@interface MeasurementsViewController ()

@end

@implementation MeasurementsViewController

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)emailMeasurements:(id)sender {
    // Send email
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    [writeString appendString:[NSString stringWithFormat:@"Month,Weight,Chest,Left Arm,Right Arm,Waist,Hips,Left Thigh,Right Thigh\n"]];
    
    [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                               self.navigationItem.title, 
                               self.measurementsDictonary[@"Weight"],
                               self.measurementsDictonary[@"Chest"], 
                               self.measurementsDictonary[@"Left Arm"], 
                               self.measurementsDictonary[@"Right Arm"], 
                               self.measurementsDictonary[@"Waist"], 
                               self.measurementsDictonary[@"Hips"],
                               self.measurementsDictonary[@"Left Thigh"], 
                               self.measurementsDictonary[@"Right Thigh"]]];
    
    NSData *csvData = [writeString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *fileName = [self.navigationItem.title stringByAppendingString:@" Measurements.csv"];
    
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
    
    NSString *subject = @"90 DWT 1";
    subject = [subject stringByAppendingFormat:@" %@ Measurements", self.navigationItem.title];
    [mailComposer setSubject:subject];
    [mailComposer addAttachmentData:csvData mimeType:@"text/csv" fileName:fileName];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendTwitter:(id)sender {
    
    [self twitter];
}

- (void)loadMeasurements {
    NSString *fileTitle = self.navigationItem.title;
    fileTitle = [fileTitle stringByAppendingString:@" Measurements.out"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = paths[0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileTitle]; //add our title to the path
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        // Read back in new collection
        self.measurementsDictonary = nil;
        self.measurementsDictonary = [NSDictionary dictionaryWithContentsOfFile:fullPath];
        
        self.weight.text = self.measurementsDictonary[@"Weight"];
        self.chest.text = self.measurementsDictonary[@"Chest"];
        self.leftArm.text = self.measurementsDictonary[@"Left Arm"];
        self.rightArm.text = self.measurementsDictonary[@"Right Arm"];
        self.waist.text = self.measurementsDictonary[@"Waist"];
        self.hips.text = self.measurementsDictonary[@"Hips"];
        self.leftThigh.text = self.measurementsDictonary[@"Left Thigh"];
        self.rightThigh.text = self.measurementsDictonary[@"Right Thigh"];
    }
}

- (IBAction)saveMeasurements:(id)sender {
    NSString *fileTitle = self.navigationItem.title;
    fileTitle = [fileTitle stringByAppendingString:@" Measurements.out"];
    
    self.measurementsDictonary = nil;
    self.measurementsDictonary = @{@"Weight": self.weight.text,
                             @"Chest": self.chest.text,
                             @"Left Arm": self.leftArm.text,
                             @"Right Arm": self.rightArm.text,
                             @"Waist": self.waist.text,
                             @"Hips": self.hips.text,
                             @"Left Thigh": self.leftThigh.text,
                             @"Right Thigh": self.rightThigh.text};
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = paths[0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileTitle]; //add our title to the path
    
    // Write dictionary
    [self.measurementsDictonary writeToFile:fullPath atomically:YES];    
    //NSLog(@"dictionary saved");
    
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
