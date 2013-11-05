//
//  EmailViewController.m
//  i90X
//
//  Created by Jared Grant on 7/12/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController
@synthesize defaultEmail;

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
    defaultEmail.text = ((SettingsNavController *)self.parentViewController).emailAddress;
}

- (void)viewDidUnload
{
    [self setDefaultEmail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)hideKeyboard:(id)sender {
    [self.defaultEmail resignFirstResponder];
}

- (IBAction)saveEmail:(id)sender {
    // Get path to documents directory
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *defaultEmailFile = nil;
    defaultEmailFile = [docDir stringByAppendingPathComponent:@"Default Email.out"];
    
    // Create the file
    [[NSFileManager defaultManager] createFileAtPath:defaultEmailFile contents:nil attributes:nil];
    
    // Write file to documents directory
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:defaultEmailFile];
    [fileHandle writeData:[defaultEmail.text dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
    ((SettingsNavController *)self.parentViewController).emailAddress = defaultEmail.text;
    
    // Clear the text field and show the placeholder text.
    defaultEmail.placeholder = defaultEmail.text;
    defaultEmail.text = @"";
}
@end
