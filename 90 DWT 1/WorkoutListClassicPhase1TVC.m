//
//  WorkoutListClassicPhase1TVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/13/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListClassicPhase1TVC.h"
#import "DWT1IAPHelper.h"

@interface WorkoutListClassicPhase1TVC ()

@end

@implementation WorkoutListClassicPhase1TVC

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
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // User purchased the Remove Ads in-app purchase so don't show any ads.
        //self.canDisplayBannerAds = NO;
        
    } else {
        
        // Show the Banner Ad
        //self.canDisplayBannerAds = YES;
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
        
        self.adView = [[MPAdView alloc] initWithAdUnitId:@"4bed96fcb70a4371b972bf19d149e433"
                                                    size:MOPUB_BANNER_SIZE];
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                       MOPUB_BANNER_SIZE.height - MOPUB_BANNER_SIZE.height,
                                       MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
        
        [self.headerView addSubview:self.adView];
        
        [self.adView loadAd];
    }

    // Configure tableview.
    NSArray *tableCell = @[self.cell1,
                            self.cell2,
                            self.cell3,
                            self.cell4,
                            self.cell5,
                            self.cell6,
                            self.cell7];
    NSArray *accessoryIcon = @[@YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES,
                                @YES];
    [self configureTableView:tableCell :accessoryIcon];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Show or Hide Ads
    if ([[DWT1IAPHelper sharedInstance] productPurchased:@"com.grantsoftware.90DWT1.removeads1"]) {
        
        // Don't show ads.
        self.tableView.tableHeaderView = nil;
        self.adView.delegate = nil;
        self.adView = nil;
        
    } else {
        
        // Show ads
        self.adView.frame = CGRectMake((self.view.bounds.size.width - MOPUB_BANNER_SIZE.width) / 2,
                                       MOPUB_BANNER_SIZE.height - MOPUB_BANNER_SIZE.height,
                                       MOPUB_BANNER_SIZE.width, MOPUB_BANNER_SIZE.height);
        self.adView.hidden = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    NSString *week = ((DataNavController *)self.parentViewController).week;
    NSArray *workoutArray;
    
    workoutArray = @[@"Chest + Back & Ab Workout", 
                    @"Plyometrics", 
                    @"Shoulders + Arms & Ab Workout", 
                    @"Yoga", 
                    @"Legs + Back & Ab Workout", 
                    @"Judo Chop",
                    @"Stretch or Rest"];
    ((DataNavController *)self.parentViewController).workout = workoutArray[indexPath.row];
   
    // Week 1
    if ([week isEqualToString:@"Week 1"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Back 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 1) {
            
            // Plyometrics 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 1
            ((DataNavController *)self.parentViewController).index = @1;            
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 1
            ((DataNavController *)self.parentViewController).index = @1;
        }
    }
    
    // Week 2
    else if ([week isEqualToString:@"Week 2"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Back 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 1) {
            
            // Plyometrics 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 2
            ((DataNavController *)self.parentViewController).index = @2;
        }
    }
    
    // Week 3
    else if ([week isEqualToString:@"Week 3"]) {
        
        if (indexPath.row == 0) {
            
            // Chest + Back 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 1) {
            
            // Plyometrics 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 2) {
            
            // Shoulders + Arms 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 3) {
            
            // Yoga 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 4) {
            
            // Legs + Back 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 5) {
            
            // Judo Chop 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
        
        else if (indexPath.row == 6) {
            
            // Stretch 3
            ((DataNavController *)self.parentViewController).index = @3;
        }
    }
    
    //NSLog(@"%@ index = %@", ((DataNavController *)self.parentViewController).workout, ((DataNavController *)self.parentViewController).index);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        
        NSString *routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@", ((DataNavController *)self.parentViewController).week];
        return routineWeek;
    }
    
    else {
        
        return @"";
    }
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = MOPUB_BANNER_SIZE.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    if (self.headerView.frame.size.height == 0) {
        
        // No ads shown yet.  Animate showing the ad.
        CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, MOPUB_BANNER_SIZE.height);
        
        [UIView animateWithDuration:0.25 animations:^{ self.headerView.frame = headerViewFrame;
            self.tableView.tableHeaderView = self.headerView;
            self.adView.hidden = YES;}
         
                         completion:^(BOOL finished) {self.adView.hidden = NO;
                         }];
        
    } else {
        
        // Ad is already showing.
        self.tableView.tableHeaderView = self.headerView;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    self.adView.hidden = YES;
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    CGSize size = [self.adView adContentViewSize];
    CGFloat centeredX = (self.view.bounds.size.width - size.width) / 2;
    CGFloat bottomAlignedY = self.headerView.bounds.size.height - size.height;
    self.adView.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    self.adView.hidden = NO;
}
@end
