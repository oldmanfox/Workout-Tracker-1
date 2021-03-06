//
//  MeasurementsReportViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "MeasurementsReportViewController.h"

@interface MeasurementsReportViewController ()

@end

@implementation MeasurementsReportViewController

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
    UIColor *lightGrey = [UIColor colorWithRed:234/255.0f green:234/255.0f blue:234/255.0f alpha:1.0f];
    self.view.backgroundColor = lightGrey;
    
    [self loadDictionary];
    [self.htmlView loadHTMLString:[self createHTML] baseURL:nil];
    self.htmlView.backgroundColor = [UIColor clearColor];
    self.htmlView.opaque = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)emailSummary {
    // Send email
    
    // Create an array of measurements to iterate thru when building the table rows.
    NSArray *measurementsArray = @[self.month1Dict, self.month2Dict, self.month3Dict, self.finalDict];
    NSArray *measurementsMonth = @[@"Start Month 1", @"Start Month 2", @"Start Month 3", @"Final"];
    
    NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
    [writeString appendString:[NSString stringWithFormat:@"Month,Weight,Chest,Left Arm,Right Arm,Waist,Hips,Left Thigh,Right Thigh\n"]];
    
    for (int i = 0; i < measurementsMonth.count; i++) {
        [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
                                   measurementsMonth[i],
                                   measurementsArray[i][@"Weight"],
                                   measurementsArray[i][@"Chest"], 
                                   measurementsArray[i][@"Left Arm"], 
                                   measurementsArray[i][@"Right Arm"], 
                                   measurementsArray[i][@"Waist"], 
                                   measurementsArray[i][@"Hips"],
                                   measurementsArray[i][@"Left Thigh"], 
                                   measurementsArray[i][@"Right Thigh"]]];
    }
    
    NSData *csvData = [writeString dataUsingEncoding:NSASCIIStringEncoding];
    NSString *fileName = [self.navigationItem.title stringByAppendingString:@" Measurements.csv"];
    
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.navigationBar.tintColor = [UIColor whiteColor];
    
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
    [self presentViewController:mailComposer animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

- (IBAction)actionSheet:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Email", @"Facebook", @"Twitter", nil];
    [action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self emailSummary];
    }
    
    if (buttonIndex == 1) {
        [self facebook];
    }
    
    if (buttonIndex == 2) {
        [self twitter];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadDictionary {
    // Get path to documents directory
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dictionaryFile = nil;
    
    // Month 1
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Start Month 1 Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        self.month1Dict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        self.month1Dict = @{@"Weight": @"0",
                      @"Chest": @"0",
                      @"Left Arm": @"0",
                      @"Right Arm": @"0",
                      @"Waist": @"0",
                      @"Hips": @"0",
                      @"Left Thigh": @"0",
                      @"Right Thigh": @"0"};
    }
    
    // Month 2
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Start Month 2 Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        self.month2Dict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        self.month2Dict = @{@"Weight": @"0",
                      @"Chest": @"0",
                      @"Left Arm": @"0",
                      @"Right Arm": @"0",
                      @"Waist": @"0",
                      @"Hips": @"0",
                      @"Left Thigh": @"0",
                      @"Right Thigh": @"0"};
    }
    
    // Month 3
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Start Month 3 Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        self.month3Dict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        self.month3Dict = @{@"Weight": @"0",
                      @"Chest": @"0",
                      @"Left Arm": @"0",
                      @"Right Arm": @"0",
                      @"Waist": @"0",
                      @"Hips": @"0",
                      @"Left Thigh": @"0",
                      @"Right Thigh": @"0"};
    }
    
    // Final
    dictionaryFile = [docDir stringByAppendingPathComponent:@"Final Measurements.out"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dictionaryFile]) {
        self.finalDict = [NSDictionary dictionaryWithContentsOfFile:dictionaryFile];
    }
    else {
        self.finalDict = @{@"Weight": @"0",
                     @"Chest": @"0",
                     @"Left Arm": @"0",
                     @"Right Arm": @"0",
                     @"Waist": @"0",
                     @"Hips": @"0",
                     @"Left Thigh": @"0",
                     @"Right Thigh": @"0"};    }
}

- (NSString*)createHTML {
    // Create an array of measurements to iterate thru when building the table rows.
    NSArray *measurementsArray = @[self.month1Dict, self.month2Dict, self.month3Dict, self.finalDict];
    NSArray *measurementsNameArray = @[@"Weight", @"Chest", @"Left Arm", @"Right Arm", @"Waist", @"Hips", @"Left Thigh", @"Right Thigh"];
    
    NSString *myHTML = @"<html><head>";
    
    // Table Style
    myHTML = [myHTML stringByAppendingFormat:@"<STYLE TYPE='text/css'><!--TD{font-family: Arial; font-size: 12pt;}TH{font-family: Arial; font-size: 14pt;}---></STYLE></head><body><table border='1' bordercolor='#3399FF' style='background-color:#CCCCCC' width='%f' cellpadding='2' cellspacing='1'>", (self.htmlView.frame.size.width - 15)];
    
    // Table Headers
    myHTML = [myHTML stringByAppendingString:@"<tr><th style='background-color:#999999'></th><th style='background-color:#999999'>1</th><th style='background-color:#999999'>2</th><th style='background-color:#999999'>3</th><th style='background-color:#999999'>Final</th></tr>"];
    
    // Table Data
    for (int i = 0; i < measurementsNameArray.count; i++) {
        myHTML = [myHTML stringByAppendingFormat:@"<tr><td style='background-color:#999999'>%@</td>", measurementsNameArray[i]];
        
        for (int a = 0; a < measurementsArray.count; a++) {
            myHTML = [myHTML stringByAppendingFormat:@"<td>%@</td>",
                      measurementsArray[a][measurementsNameArray[i]]];
        }
        
        myHTML = [myHTML stringByAppendingString:@"</tr>"];
    }
    
    // HTML closing tags
    myHTML = [myHTML stringByAppendingString:@"</table></body></html>"];
    
    return myHTML;
}
@end
