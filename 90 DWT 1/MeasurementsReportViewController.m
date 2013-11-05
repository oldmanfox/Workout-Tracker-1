//
//  MeasurementsReportViewController.m
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "MeasurementsReportViewController.h"

@interface MeasurementsReportViewController ()

@end

@implementation MeasurementsReportViewController
@synthesize htmlView;
@synthesize phase1Dict;
@synthesize phase2Dict;
@synthesize phase3Dict;
@synthesize finalDict;

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
    
    [self loadDictionary];
    [htmlView loadHTMLString:[self createHTML] baseURL:nil];
    self.htmlView.backgroundColor = [UIColor clearColor];
    self.htmlView.opaque = NO;
}

- (void)viewDidUnload
{
    [self setHtmlView:nil];
    [self setPhase1Dict:nil];
    [self setPhase2Dict:nil];
    [self setPhase3Dict:nil];
    [self setFinalDict:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)emailSummary:(id)sender {
    // Send email
    
    // Create an array of measurements to iterate thru when building the table rows.
    NSArray *measurementsArray = [[NSArray alloc] initWithObjects:phase1Dict, phase2Dict, phase3Dict, finalDict, nil];
    NSArray *measurementsPhase = [[NSArray alloc] initWithObjects:@"Start Phase 1", @"Start Phase 2", @"Start Phase 3", @"Final", nil];
    
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    [writeString appendString:[NSString stringWithFormat:@"Phase,Weight,Chest,Left Arm,Right Arm,Waist,Hips,Left Thigh,Right Thigh\n"]];
    
    for (int i = 0; i < measurementsPhase.count; i++) {
        [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                                   [measurementsPhase objectAtIndex:i],
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Weight"],
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Chest"], 
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Left Arm"], 
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Right Arm"], 
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Waist"], 
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Hips"],
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Left Thigh"], 
                                   [[measurementsArray objectAtIndex:i] objectForKey:@"Right Thigh"]]];
    }
    
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

- (IBAction)sendTweet:(id)sender {
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

- (void)loadDictionary {
    // Get path to documents directory
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *dictionaryFile = nil;
    
    // Phase 1
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Start Phase 1 Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        phase1Dict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        phase1Dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"0", @"Weight",
                      @"0", @"Chest",
                      @"0", @"Left Arm",
                      @"0", @"Right Arm",
                      @"0", @"Waist",
                      @"0", @"Hips",
                      @"0", @"Left Thigh",
                      @"0", @"Right Thigh", nil];
    }
    
    // Phase 2
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Start Phase 2 Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        phase2Dict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        phase2Dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"0", @"Weight",
                      @"0", @"Chest",
                      @"0", @"Left Arm",
                      @"0", @"Right Arm",
                      @"0", @"Waist",
                      @"0", @"Hips",
                      @"0", @"Left Thigh",
                      @"0", @"Right Thigh", nil];
    }
    
    // Phase 3
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Start Phase 3 Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        phase3Dict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        phase3Dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                      @"0", @"Weight",
                      @"0", @"Chest",
                      @"0", @"Left Arm",
                      @"0", @"Right Arm",
                      @"0", @"Waist",
                      @"0", @"Hips",
                      @"0", @"Left Thigh",
                      @"0", @"Right Thigh", nil];
    }
    
    // Final
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Final Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        finalDict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        finalDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                     @"0", @"Weight",
                     @"0", @"Chest",
                     @"0", @"Left Arm",
                     @"0", @"Right Arm",
                     @"0", @"Waist",
                     @"0", @"Hips",
                     @"0", @"Left Thigh",
                     @"0", @"Right Thigh", nil];    }
}

- (NSString*)createHTML {
    // Create an array of measurements to iterate thru when building the table rows.
    NSArray *measurementsArray = [[NSArray alloc] initWithObjects:phase1Dict, phase2Dict, phase3Dict, finalDict, nil];
    NSArray *measurementsNameArray = [[NSArray alloc] initWithObjects:@"Weight", @"Chest", @"Left Arm", @"Right Arm", @"Waist", @"Hips", @"Left Thigh", @"Right Thigh", nil];
    
    NSString *myHTML = @"<html><head>";
    
    // Table Style
    myHTML = [myHTML stringByAppendingFormat:@"<STYLE TYPE='text/css'><!--TD{font-family: Arial; font-size: 12pt;}TH{font-family: Arial; font-size: 14pt;}---></STYLE></head><body><table border='1' bordercolor='#3399FF' style='background-color:#CCCCCC' width='%f' cellpadding='2' cellspacing='1'>", (self.htmlView.frame.size.width - 15)];
    
    // Table Headers
    myHTML = [myHTML stringByAppendingString:@"<tr><th style='background-color:#999999'></th><th style='background-color:#999999'>1</th><th style='background-color:#999999'>2</th><th style='background-color:#999999'>3</th><th style='background-color:#999999'>Final</th></tr>"];
    
    // Table Data
    for (int i = 0; i < measurementsNameArray.count; i++) {
        myHTML = [myHTML stringByAppendingFormat:@"<tr><td style='background-color:#999999'>%@</td>", [measurementsNameArray objectAtIndex:i]];
        
        for (int a = 0; a < measurementsArray.count; a++) {
            myHTML = [myHTML stringByAppendingFormat:@"<td>%@</td>",
                      [[measurementsArray objectAtIndex:a] objectForKey:[measurementsNameArray objectAtIndex:i]]];
        }
        
        myHTML = [myHTML stringByAppendingString:@"</tr>"];
    }
    
    // HTML closing tags
    myHTML = [myHTML stringByAppendingString:@"</table></body></html>"];
    
    return myHTML;
}
@end
