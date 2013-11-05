//
//  PhotoScrollerDetailViewController.m
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import "PhotoScrollerDetailViewController.h"

@interface PhotoScrollerDetailViewController ()

@end

@implementation PhotoScrollerDetailViewController
@synthesize displayImageView;
@synthesize picAngle;
@synthesize picTitle;
@synthesize popoverController;

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
    
    picAngle = @"Front";
    picTitle = [((PhotoNavController *)self.parentViewController).phase stringByAppendingFormat:@" %@", picAngle];
    
    // Load image from application documents directory.
    PhotoNavController *photoNC = [[PhotoNavController alloc] init];
    self.displayImageView.image = [photoNC loadImage:picTitle];
}

- (void)viewDidUnload
{
    [self setDisplayImageView:nil];
    [self setPicAngle:nil];
    [self setPicTitle:nil];
    [self setPopoverController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)cameraOrPhotoLibrary:(id)sender {
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if ([self.navigationItem.title isEqualToString:@"Camera"]) {
        
        // Use Camera
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        
        // Use Photo Library
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    // Check to see what device you are using iPad or iPhone.
    NSString *deviceModel = [UIDevice currentDevice].model;
    
    // If your device is iPad then show the imagePicker in a popover.
    // If not iPad then show the imagePicker modally.
    if (([deviceModel isEqualToString:@"iPad"] && imagePicker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
        || ([deviceModel isEqualToString:@"iPad Simulator"] && imagePicker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)) {
        popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        popoverController.delegate = self;
        [popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self presentModalViewController:imagePicker animated:YES];
    }
}

- (IBAction)frontImage:(id)sender {
    picAngle = @"Front";
    picTitle = [((PhotoNavController *)self.parentViewController).phase stringByAppendingFormat:@" %@", picAngle];
    [popoverController dismissPopoverAnimated:NO];
    [self cameraOrPhotoLibrary:sender];
}

- (IBAction)sideImage:(id)sender {
    picAngle = @"Side";
    picTitle = [((PhotoNavController *)self.parentViewController).phase stringByAppendingFormat:@" %@", picAngle];
    [popoverController dismissPopoverAnimated:NO];
    [self cameraOrPhotoLibrary:sender];
}

- (IBAction)backImage:(id)sender {
    picAngle = @"Back";
    picTitle = [((PhotoNavController *)self.parentViewController).phase stringByAppendingFormat:@" %@", picAngle];
    [popoverController dismissPopoverAnimated:NO];
    [self cameraOrPhotoLibrary:sender];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissModalViewControllerAnimated:YES];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *scaledImage = nil;
    
    if (image.size.height > image.size.width) {
        
        // Image was taken in Portriat mode.
        scaledImage = [image resizedImageWithSize:CGSizeMake(1536,2048)];
        
    } else {
        
        // Image was taken in Landscape mode.
        scaledImage = [image resizedImageWithSize:CGSizeMake(2048,1536)];
    }
    
    // Only save image to photo library if it is a new pic taken with the camera.
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    PhotoNavController *photoNC = [[PhotoNavController alloc] init];
    
    // Save image to application documents directory.
    [photoNC saveImage:scaledImage :picTitle];
    
    // Display newly scaled image.
    self.displayImageView.image = scaledImage;
    
    picker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertView *alert;
    
    // Unable to save the image
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Library."
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil, nil];
    } else { // All is well
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"Image saved to Photo Library."
                                          delegate:self
                                 cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil, nil];
    }
    [alert show];
}
@end
