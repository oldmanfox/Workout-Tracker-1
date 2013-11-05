//
//  SettingsTVC.m
//  i90X
//
//  Created by Jared Grant on 7/11/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "SettingsTVC.h"

@interface SettingsTVC ()

@end

@implementation SettingsTVC
@synthesize defaultWorkout;
@synthesize cell1;
@synthesize cell2;
@synthesize cell3;
@synthesize cell4;
@synthesize emailDetail;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure tableview.
    [self configureTableView];

    // Get path to documents directory
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    
    // Email File
    NSString *defaultEmailFile = nil;
    defaultEmailFile = [docDir stringByAppendingPathComponent:@"Default Email.out"];
    
    if  ([[NSFileManager defaultManager] fileExistsAtPath:defaultEmailFile]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultEmailFile];
        ((SettingsNavController *)self.parentViewController).emailAddress = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
    }
    else {
        ((SettingsNavController *)self.parentViewController).emailAddress = @"";
    }
    
    // Workout File
    NSString *defaultWorkoutFile = nil;
    defaultWorkoutFile = [docDir stringByAppendingPathComponent:@"Default Workout.out"];
    
    if  ([[NSFileManager defaultManager] fileExistsAtPath:defaultWorkoutFile]) {
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:defaultWorkoutFile];
        NSString *workoutTitle = [[NSString alloc] initWithData:[fileHandle availableData] encoding:NSUTF8StringEncoding];
        [fileHandle closeFile];
        
        for (int i = 0; i < 3; i++) {
            if ([[defaultWorkout titleForSegmentAtIndex:i] isEqualToString:workoutTitle]) {
                self.defaultWorkout.selectedSegmentIndex = i;
            }
        }
    }
}
  
- (void)viewDidAppear:(BOOL)animated {
    if ([((SettingsNavController *)self.parentViewController).emailAddress isEqualToString:@""]) {
        emailDetail.text = @"youremail@abc.com";
    }
    else {
        emailDetail.text = ((SettingsNavController *)self.parentViewController).emailAddress;
    }
}

- (void)viewDidUnload
{
    [self setCell1:nil];
    [self setCell2:nil];
    [self setCell3:nil];
    [self setCell4:nil];
    [self setEmailDetail:nil];
    [self setDefaultWorkout:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    else {
        return 3;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...*/
     // Pass the selected object to the new view controller.
     //[self.navigationController pushViewController:emailviewcontroller animated:YES];
     
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"email"]) {
        ((SettingsNavController *)self.parentViewController).emailAddress = emailDetail.text;
    }
}

- (void)configureTableView {
    UIImage *backgroundImage;
    UIColor *backgroundColor;
    UIImage *cellbackgroundImage;
    UIColor *cellbackgroundColor;
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    
    [self.tableView setBackgroundColor:[UIColor clearColor]]; // this is for iPhone
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        // iPad
        backgroundImage = [UIImage imageNamed:@"background-iPad-chrome.png"];
        backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
        cellbackgroundImage = [UIImage imageNamed:@"tableviewcell-iPad-chrome.png"];
        cellbackgroundColor = [UIColor colorWithPatternImage:cellbackgroundImage];
        
    }
    else {
        // iPhone
        backgroundImage = [UIImage imageNamed:@"background-iPhone-chrome.png"];
        backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        
        cellbackgroundImage = [UIImage imageNamed:@"tableviewcell-iPhone-chrome.png"];
        cellbackgroundColor = [UIColor colorWithPatternImage:cellbackgroundImage];
    }
    
    // TableView background color
    self.tableView.backgroundColor = backgroundColor;
    
    // Cell background color
    cell1.backgroundColor = cellbackgroundColor;
    cell2.backgroundColor = cellbackgroundColor;
    cell3.backgroundColor = cellbackgroundColor;
    cell4.backgroundColor = cellbackgroundColor;
        
    // Label backgrounds
    cell1.textLabel.backgroundColor = [UIColor clearColor];
    cell1.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell2.textLabel.backgroundColor = [UIColor clearColor];
    cell2.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell3.textLabel.backgroundColor = [UIColor clearColor];
    cell3.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell4.textLabel.backgroundColor = [UIColor clearColor];
    cell4.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"icon-arrow-blue.png"];
    UIImageView* accessoryView1 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView4 = [[UIImageView alloc] initWithImage:accessory];
        
    cell1.accessoryView = accessoryView1;
    cell4.accessoryView = accessoryView4;
}
- (IBAction)selectDefaultWorkout:(id)sender {
    // Get path to documents directory
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    NSString *defaultWorkoutFile = nil;
    defaultWorkoutFile = [docDir stringByAppendingPathComponent:@"Default Workout.out"];
    
    // Create the file
    [[NSFileManager defaultManager] createFileAtPath:defaultWorkoutFile contents:nil attributes:nil];
    
    // Write file to documents directory
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:defaultWorkoutFile];
    [fileHandle writeData:[[self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex] dataUsingEncoding:NSUTF8StringEncoding]];
    [fileHandle closeFile];
    
    // Save default workout to SettingsNavController
    ((SettingsNavController *)self.parentViewController).defaultWorkout = [self.defaultWorkout titleForSegmentAtIndex:self.defaultWorkout.selectedSegmentIndex];
    
    ((MainTBC *)self.parentViewController.parentViewController).workoutChanged = YES;
}
@end
