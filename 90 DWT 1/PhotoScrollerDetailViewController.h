//
//  PhotoScrollerDetailViewController.h
//  i90X
//
//  Created by Jared Grant on 7/14/12.
//  Copyright (c) 2012 g-rantsoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoNavController.h"
#import "UIImage+Resizing.h"
#import <CoreImage/CoreImage.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PhotoScrollerDetailViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, MPMediaPickerControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *displayImageView;
@property (strong, nonatomic) NSString *picAngle;  // Front, Side, or Back
@property (strong, nonatomic) NSString *picTitle;  // Created from phase and picAngle
@property (strong, nonatomic) UIPopoverController *popoverController;

- (IBAction)frontImage:(id)sender;
- (IBAction)sideImage:(id)sender;
- (IBAction)backImage:(id)sender;
@end
