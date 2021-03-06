//
//  WorkoutListRecoveryTVC.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/13/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "WorkoutListRecoveryTVC.h"
#import "DWT1IAPHelper.h"

@interface WorkoutListRecoveryTVC ()

@end

@implementation WorkoutListRecoveryTVC

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
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            
            // iPhone
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"4bed96fcb70a4371b972bf19d149e433"
                                                        size:MOPUB_BANNER_SIZE];
            self.bannerSize = MOPUB_BANNER_SIZE;
            
        } else {
            
            // iPad
            self.adView = [[MPAdView alloc] initWithAdUnitId:@"7c80f30698634a22b77778b084e3087e"
                                                        size:MOPUB_LEADERBOARD_SIZE];
            self.bannerSize = MOPUB_LEADERBOARD_SIZE;
            
        }
        
        self.adView.delegate = self;
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
        
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
    
    // Label Text
    self.cell5.textLabel.text = ((DataNavController *)self.parentViewController).lightCell5;
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
        self.adView.frame = CGRectMake((self.view.bounds.size.width - self.bannerSize.width) / 2,
                                       self.bannerSize.height - self.bannerSize.height,
                                       self.bannerSize.width, self.bannerSize.height);
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
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
        
    NSString *selectedRoutine = ((DataNavController *)self.parentViewController).routine;
    NSString *week = ((DataNavController *)self.parentViewController).week;
        
    NSArray *workoutArrayNormal2ADays = @[@"Yoga",
                                            @"Core Fitness",
                                            @"Judo Chop",
                                            @"Stretch or Rest",
                                            @"Core Fitness",
                                            @"Yoga",
                                            @"Stretch or Rest"];
    NSArray *workoutArrayLean = @[@"Yoga",
                                    @"Core Fitness",
                                    @"Judo Chop",
                                    @"Stretch or Rest",
                                    @"Full on Cardio",
                                    @"Yoga",
                                    @"Stretch or Rest"];
    
    // Normal or 2-A-Days routine
    if ([selectedRoutine isEqualToString:@"Normal"] || [selectedRoutine isEqualToString:@"2-A-Days"]) {
        
        // Week 4
        if ([week isEqualToString:@"Week 4"]) {
            
            if (indexPath.row == 0) {
                
                // Yoga 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 1) {
                
                // Core Fitness 1
                ((DataNavController *)self.parentViewController).index = @1;
            }
            
            else if (indexPath.row == 2) {
                
                // Judo Chop 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 3) {
                
                // Stretch 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 4) {
                
                // Core Fitness 2
                ((DataNavController *)self.parentViewController).index = @2;
                [self performSegueWithIdentifier:self.cell5.textLabel.text sender:self];
            }
            
            else if (indexPath.row == 5) {
                
                // Yoga 5
                ((DataNavController *)self.parentViewController).index = @5;
            }
            
            else if (indexPath.row == 6) {
                
                // Stretch 5
                ((DataNavController *)self.parentViewController).index = @5;
            }
        }
        
        // Week 8
        else if ([week isEqualToString:@"Week 8"]) {
            
            if (indexPath.row == 0) {
                
                // Yoga 9
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (indexPath.row == 1) {
                
                // Core Fitness 3
                ((DataNavController *)self.parentViewController).index = @3;
            }
            
            else if (indexPath.row == 2) {
                
                // Judo Chop 8
                ((DataNavController *)self.parentViewController).index = @8;
            }
            
            else if (indexPath.row == 3) {
                
                // Stretch 9
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (indexPath.row == 4) {
                
                // Core Fitness 4
                ((DataNavController *)self.parentViewController).index = @4;
                [self performSegueWithIdentifier:self.cell5.textLabel.text sender:self];
            }
            
            else if (indexPath.row == 5) {
                
                // Yoga 10
                ((DataNavController *)self.parentViewController).index = @10;
            }
            
            else if (indexPath.row == 6) {
                
                // Stretch 10
                ((DataNavController *)self.parentViewController).index = @10;
            }
            
        }
        
        // Week 13
        else if ([week isEqualToString:@"Week 13"]) {
            
            if (indexPath.row == 0) {
                
                // Yoga 15
                ((DataNavController *)self.parentViewController).index = @15;
            }
            
            else if (indexPath.row == 1) {
                
                // Core Fitness 5
                ((DataNavController *)self.parentViewController).index = @5;
            }
            
            else if (indexPath.row == 2) {
                
                // Judo Chop 13
                ((DataNavController *)self.parentViewController).index = @13;
            }
            
            else if (indexPath.row == 3) {
                
                // Stretch 15
                ((DataNavController *)self.parentViewController).index = @15;
            }
            
            else if (indexPath.row == 4) {
                
                // Core Fitness 6
                ((DataNavController *)self.parentViewController).index = @6;
                [self performSegueWithIdentifier:self.cell5.textLabel.text sender:self];
            }
            
            else if (indexPath.row == 5) {
                
                // Yoga 16
                ((DataNavController *)self.parentViewController).index = @16;
            }
            
            else if (indexPath.row == 6) {
                
                // Stretch 16
                ((DataNavController *)self.parentViewController).index = @16;
            }
        }
        
        ((DataNavController *)self.parentViewController).workout = workoutArrayNormal2ADays[indexPath.row];
    }
    
    // Lean Routine
    else {
        
        // Week 4
        if ([week isEqualToString:@"Week 4"]) {
            
            if (indexPath.row == 0) {
                
                // Yoga 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 1) {
                
                // Core Fitness 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 2) {
                
                // Judo Chop 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 3) {
                
                // Stretch 4
                ((DataNavController *)self.parentViewController).index = @4;
            }
            
            else if (indexPath.row == 4) {
                
                // Core Fitness 5
                ((DataNavController *)self.parentViewController).index = @5;
                [self performSegueWithIdentifier:self.cell5.textLabel.text sender:self];
            }
            
            else if (indexPath.row == 5) {
                
                // Yoga 5
                ((DataNavController *)self.parentViewController).index = @5;
            }
            
            else if (indexPath.row == 6) {
                
                // Stretch 5
                ((DataNavController *)self.parentViewController).index = @5;
            }
            
            ((DataNavController *)self.parentViewController).workout = workoutArrayNormal2ADays[indexPath.row];
        }
        
        // Week 8
        else if ([week isEqualToString:@"Week 8"]) {
            
            if (indexPath.row == 0) {
                
                // Yoga 9
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (indexPath.row == 1) {
                
                // Core Fitness 9
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (indexPath.row == 2) {
                
                // Judo Chop 8
                ((DataNavController *)self.parentViewController).index = @8;
            }
            
            else if (indexPath.row == 3) {
                
                // Stretch 9
                ((DataNavController *)self.parentViewController).index = @9;
            }
            
            else if (indexPath.row == 4) {
                
                // Full on Cardio 7
                ((DataNavController *)self.parentViewController).index = @7; // Different
                [self performSegueWithIdentifier:self.cell5.textLabel.text sender:self];
            }
            
            else if (indexPath.row == 5) {
                
                // Yoga 10
                ((DataNavController *)self.parentViewController).index = @10;
            }
            
            else if (indexPath.row == 6) {
                
                // Stretch 10
                ((DataNavController *)self.parentViewController).index = @10;
            }
            
            ((DataNavController *)self.parentViewController).workout = workoutArrayLean[indexPath.row];
        }
        
        // Week 13
        else if ([week isEqualToString:@"Week 13"]) {
            
            if (indexPath.row == 0) {
                
                // Yoga 15
                ((DataNavController *)self.parentViewController).index = @15;
            }
            
            else if (indexPath.row == 1) {
                
                // Core Fitness 14
                ((DataNavController *)self.parentViewController).index = @14;
            }
            
            else if (indexPath.row == 2) {
                
                // Judo Chop 13
                ((DataNavController *)self.parentViewController).index = @13;
            }
            
            else if (indexPath.row == 3) {
                
                // Stretch 15
                ((DataNavController *)self.parentViewController).index = @15;
            }
            
            else if (indexPath.row == 4) {
                
                // Full on Cardio 12
                ((DataNavController *)self.parentViewController).index = @12;  // Different
                [self performSegueWithIdentifier:self.cell5.textLabel.text sender:self];
            }
            
            else if (indexPath.row == 5) {
                
                // Yoga 16
                ((DataNavController *)self.parentViewController).index = @16;
            }
            
            else if (indexPath.row == 6) {
                
                // Stretch 16
                ((DataNavController *)self.parentViewController).index = @16;
            }
            
            ((DataNavController *)self.parentViewController).workout = workoutArrayLean[indexPath.row];
        }
    }
    //NSLog(@"Index = %d", [((DataNavController *)self.parentViewController).index integerValue]);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *routineWeek;
    
    if (section ==0) {
        
        if ([((DataNavController *)self.parentViewController).week isEqualToString:@"Week 4"] ||
            [((DataNavController *)self.parentViewController).week isEqualToString:@"Week 8"] ||
            [((DataNavController *)self.parentViewController).week isEqualToString:@"Week 13"]) {
            
            routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@ - Light", ((DataNavController *)self.parentViewController).week];
            return routineWeek;
        }
        
        else {
            
            NSString *routineWeek = [((DataNavController *)self.parentViewController).routine stringByAppendingFormat:@" - %@", ((DataNavController *)self.parentViewController).week];
            return routineWeek;
        }
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
    CGFloat bottomAlignedY = self.bannerSize.height - size.height;
    view.frame = CGRectMake(centeredX, bottomAlignedY, size.width, size.height);
    
    if (self.headerView.frame.size.height == 0) {
        
        // No ads shown yet.  Animate showing the ad.
        CGRect headerViewFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.bannerSize.height);
        
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
