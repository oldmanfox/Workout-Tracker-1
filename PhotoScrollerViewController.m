//
//  PhotoScrollerViewController.m
//  90 DWT 1
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "PhotoScrollerViewController.h"

@interface PhotoScrollerViewController ()
@property (nonatomic, strong) NSMutableArray *pageImages;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
@end

@implementation PhotoScrollerViewController
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first checking if you've already loaded it
    UIView *pageView = (self.pageViews)[page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.scrollView.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        frame = CGRectInset(frame, 10.0f, 0.0f);
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:(self.pageImages)[page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        (self.pageViews)[page] = newPageView;
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = (self.pageViews)[page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        (self.pageViews)[page] = [NSNull null];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.spinner startAnimating];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.spinner startAnimating];
    
    // ***Previously part of ViewDidLoad.
    PhotoNavController *photoNC = [[PhotoNavController alloc] init];
    NSString *currentPhase = ((PhotoNavController *)self.parentViewController).month;
    self.pageImages = [[NSMutableArray alloc] init];
    
    NSArray *photoAngle = @[@" Front",
    @" Side",
    @" Back"];
    
    for (int i = 0; i < photoAngle.count; i++) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath: [photoNC fileLocation:[currentPhase stringByAppendingString:photoAngle[i] ]]]) {
            
            [self.pageImages addObject:[photoNC loadImage:[currentPhase stringByAppendingString:photoAngle[i] ]]];
        }
    }
     
    NSInteger pageCount = [self.pageImages count];
    
    // Set up the page control
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    // Set up the array to hold the views for each page
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    // ***End Previously part of ViewDidLoad.
    
    // Only for iPad because it's storyboard doesn't use autolayout.  For iPhone, this step is done in ViewDidAppear.
    if (self.view.frame.size.width > 640) {
        
        // Set up the content size of the scroll view
        CGSize pagesScrollViewSize = self.scrollView.frame.size;
        self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
        
        // Load the initial set of pages that are on screen
        [self loadVisiblePages];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Only for iPhone because it's storyboard uses autolayout and this needs to be done in ViewDidAppear.  For iPad, this step can be done in ViewWillAppear.
    if (self.view.frame.size.width <= 640) {
        
        // Set up the content size of the scroll view
        CGSize pagesScrollViewSize = self.scrollView.frame.size;
        self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
        
        // Load the initial set of pages that are on screen
        [self loadVisiblePages];
    }
    
    [self.spinner stopAnimating];
}

-(void)viewDidDisappear:(BOOL)animated {
    
    for (NSInteger i = 0; i <= self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setPageImages:nil];
    [self setPageViews:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PhotoScrollerDetailViewController *psvc = (PhotoScrollerDetailViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"Camera"])
    {
        // Detect precence of a camera.
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
            
            // Photo Library
            psvc.navigationItem.title = @"Photo Library";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Not Detected"
                                                            message:@"Choose from your Photo Library."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            // Camera
            psvc.navigationItem.title = segue.identifier;
        }
    }
    else {
        // Photo Library
        psvc.navigationItem.title = segue.identifier;
    }
    
    // Save the title of the phase in the PhotoNavControler
    ((PhotoNavController *)self.parentViewController).month = self.navigationItem.title;
    //NSLog(@"Phase = %@", ((PhotoNavController *)self.parentViewController).phase);
}

- (IBAction)emailPhotos:(id)sender
{
    // Create MailComposerViewController object.
    MFMailComposeViewController *mailComposer;
    mailComposer = [[MFMailComposeViewController alloc] init];
    mailComposer.mailComposeDelegate = self;
    
    // Check to see if the device has at least 1 email account configured.
    if ([MFMailComposeViewController canSendMail]) {
        
        // Send email
        PhotoNavController *photoNC = [[PhotoNavController alloc] init];
        
        // Get path to documents directory to get default email address and images.
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *imageFile = nil;
        
        // Create MailComposerViewController object.
        MFMailComposeViewController *mailComposer;
        mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        
        // Array to store the default email address.
        NSArray *emailAddresses;
        
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
        
        // START PHASE 1 PHOTOS
        if ([self.navigationItem.title isEqualToString:@"Start Month 1"]) {
            [mailComposer setSubject:@"90 DWT 1 Start Month 1 Photos"];
            
            // PHASE 1
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 1 Front.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 1 Front"] mimeType:@"image/jpg" fileName:@"Start Month 1 Front.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 1 Side.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 1 Side"] mimeType:@"image/jpg" fileName:@"Start Month 1 Side.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 1 Back.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 1 Back"] mimeType:@"image/jpg" fileName:@"Start Month 1 Back.jpg"];
            }
        }
        // START PHASE 2 PHOTOS
        else if ([self.navigationItem.title isEqualToString:@"Start Month 2"]) {
            [mailComposer setSubject:@"90 DWT 1 Start Month 2 Photos"];
            
            // PHASE 2
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 2 Front.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 2 Front"] mimeType:@"image/jpg" fileName:@"Start Month 2 Front.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 2 Side.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 2 Side"] mimeType:@"image/jpg" fileName:@"Start Month 2 Side.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 2 Back.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 2 Back"] mimeType:@"image/jpg" fileName:@"Start Month 2 Back.jpg"];
            }
        }
        // START PHASE 3 PHOTOS
        else if ([self.navigationItem.title isEqualToString:@"Start Month 3"]) {
            [mailComposer setSubject:@"90 DWT 1 Start Month 3 Photos"];
            
            // PHASE 3
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 3 Front.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 3 Front"] mimeType:@"image/jpg" fileName:@"Start Month 3 Front.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 3 Side.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 3 Side"] mimeType:@"image/jpg" fileName:@"Start Month 3 Side.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Start Month 3 Back.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Start Month 3 Back"] mimeType:@"image/jpg" fileName:@"Start Month 3 Back.jpg"];
            }
        }
        // FINAL PHOTOS
        else if ([self.navigationItem.title isEqualToString:@"Final"]) {
            [mailComposer setSubject:@"90 DWT 1 Final Photos"];
            
            // FINAL
            imageFile = [docDir stringByAppendingPathComponent:@"Final Front.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Final Front"] mimeType:@"image/jpg" fileName:@"Final Front.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Final Side.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Final Side"] mimeType:@"image/jpg" fileName:@"Final Side.jpg"];
            }
            
            imageFile = [docDir stringByAppendingPathComponent:@"Final Back.JPG"];
            if ([[NSFileManager defaultManager] fileExistsAtPath:imageFile]) {
                [mailComposer addAttachmentData:[photoNC emailImage:@"Final Back"] mimeType:@"image/jpg" fileName:@"Final Back.jpg"];
            }
        }
        
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
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
