//
//  WorkoutListDoublesPhase3-1TVC.m
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListDoublesPhase3-1TVC.h"

@interface WorkoutListDoublesPhase3_1TVC ()

@end

@implementation WorkoutListDoublesPhase3_1TVC
@synthesize cell1;
@synthesize cell2;
@synthesize cell3;
@synthesize cell4;
@synthesize cell5;
@synthesize cell6;
@synthesize cell7;
@synthesize cell8;
@synthesize cell9;
@synthesize cell10;
@synthesize cell11;

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
}

- (void)viewDidUnload
{
    [self setCell1:nil];
    [self setCell2:nil];
    [self setCell3:nil];
    [self setCell4:nil];
    [self setCell5:nil];
    [self setCell6:nil];
    [self setCell7:nil];
    [self setCell8:nil];
    [self setCell9:nil];
    [self setCell10:nil];
    [self setCell11:nil];
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
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        
        return 2;
    }
    
    else if (section == 1) {
        
        return 2;
    }
    
    else if (section == 2) {
        
        return 1;
    }
    
    else if (section == 3) {
        
        return 2;
    }
    
    else if (section == 4) {
        
        return 2;
    }
    
    else if (section == 5) {
        
        return 1;
    }
    
    else {
        return 1;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSArray *workoutArray;
    
    workoutArray = [[NSArray alloc] initWithObjects:@"Cardio X",
                    @"Chest + Back",
                    @"Cardio X",
                    @"Plyometrics",
                    @"Shoulders + Arms",
                    @"Cardio X",
                    @"Yoga X",
                    @"Cardio X",
                    @"Legs + Back",
                    @"Kenpo X",
                    @"X Stretch",
                    nil];
    
    // Week 9
    if ([week isEqualToString:@"Week 9"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 10
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:10];
            }
            
            else if (indexPath.row == 1) {
            
            // Chest + Back 4
            ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:4];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 11
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:11];
            }
            
            else if (indexPath.row == 1) {
                
                // Plyometrics 7
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:7];
            }
        }

        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Shoulders + Arms 4
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:4];
            }
        }

        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 12
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:12];
            }
            
            else if (indexPath.row == 1) {
                
                // Yoga X 11
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:11];
            }
        }

        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 13
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:13];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 7
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:7];
            }
        }

        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Kenpo X 9
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:9];
            }
        }

        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // X Stretch 11
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:11];
            }
        }
    }
    
    // Week 11
    else if ([week isEqualToString:@"Week 11"]) {
        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 18
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:18];
            }
            
            else if (indexPath.row == 1) {
                
                // Chest + Back 5
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:5];
            }
        }
        
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 19
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:19];
            }
            
            else if (indexPath.row == 1) {
                
                // Plyometrics 9
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:9];
            }
        }
        
        else if (indexPath.section == 2) {
            
            if (indexPath.row == 0) {
                
                // Shoulders + Arms 5
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:5];
            }
        }
        
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 20
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:20];
            }
            
            else if (indexPath.row == 1) {
                
                // Yoga X 13
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:13];
            }
        }
        
        else if (indexPath.section == 4) {
            
            if (indexPath.row == 0) {
                
                // Cardio X 21
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:21];
            }
            
            else if (indexPath.row == 1) {
                
                // Legs + Back 9
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:9];
            }
        }
        
        else if (indexPath.section == 5) {
            
            if (indexPath.row == 0) {
                
                // Kenpo X 11
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:11];
            }
        }
        
        else if (indexPath.section == 6) {
            
            if (indexPath.row == 0) {
                
                // X Stretch 13
                ((DataNavController *)self.parentViewController).index = [NSNumber numberWithInt:13];
            }
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *routineWeek;
    
    if (section == 0) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 1) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 2) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 3) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 4) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else if (section == 5) {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    else {
        
        routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Day %d", ((DataNavController *)self.parentViewController).week, section + 1];
    }
    
    return routineWeek;
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
    cell5.backgroundColor = cellbackgroundColor;
    cell6.backgroundColor = cellbackgroundColor;
    cell7.backgroundColor = cellbackgroundColor;
    cell8.backgroundColor = cellbackgroundColor;
    cell9.backgroundColor = cellbackgroundColor;
    cell10.backgroundColor = cellbackgroundColor;
    cell11.backgroundColor = cellbackgroundColor;
    
    // Label backgrounds
    cell1.textLabel.backgroundColor = [UIColor clearColor];
    cell1.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell2.textLabel.backgroundColor = [UIColor clearColor];
    cell2.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell3.textLabel.backgroundColor = [UIColor clearColor];
    cell3.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell4.textLabel.backgroundColor = [UIColor clearColor];
    cell4.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell5.textLabel.backgroundColor = [UIColor clearColor];
    cell5.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell6.textLabel.backgroundColor = [UIColor clearColor];
    cell6.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell7.textLabel.backgroundColor = [UIColor clearColor];
    cell7.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell8.textLabel.backgroundColor = [UIColor clearColor];
    cell8.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell9.textLabel.backgroundColor = [UIColor clearColor];
    cell9.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell10.textLabel.backgroundColor = [UIColor clearColor];
    cell10.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    cell11.textLabel.backgroundColor = [UIColor clearColor];
    cell11.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    // Accessory view icon
    UIImage* accessory = [UIImage imageNamed:@"icon-arrow-blue.png"];
    UIImageView* accessoryView1 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView2 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView3 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView4 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView5 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView6 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView7 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView8 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView9 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView10 = [[UIImageView alloc] initWithImage:accessory];
    UIImageView* accessoryView11 = [[UIImageView alloc] initWithImage:accessory];
    
    cell1.accessoryView = accessoryView1;
    cell2.accessoryView = accessoryView2;
    cell3.accessoryView = accessoryView3;
    cell4.accessoryView = accessoryView4;
    cell5.accessoryView = accessoryView5;
    cell6.accessoryView = accessoryView6;
    cell7.accessoryView = accessoryView7;
    cell8.accessoryView = accessoryView8;
    cell9.accessoryView = accessoryView9;
    cell10.accessoryView = accessoryView10;
    cell11.accessoryView = accessoryView11;
}
@end
