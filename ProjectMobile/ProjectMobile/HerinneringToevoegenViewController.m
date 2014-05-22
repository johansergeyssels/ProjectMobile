//
//  HerinneringToevoegenViewController.m
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HerinneringToevoegenViewController.h"

@interface HerinneringToevoegenViewController ()

@end

@implementation HerinneringToevoegenViewController

//Hide keyboard
- (IBAction)LabelText:(id)sender {
    [sender resignFirstResponder];
}


//foto nemen
- (IBAction)FotoNemen_btn:(id)sender {
    _imageView.image = nil;
    [self startCameraControllerFromViewController: self
     usingDelegate: self];
}

//gallerij

- (IBAction)Gallerij_btn:(id)sender {
    
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePicker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image;
    NSURL *mediaURL;
    mediaURL = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
    image = (UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//CAMERA CODE (Apple Dev site)
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller

                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   
                                                   UINavigationControllerDelegate>) delegate {
    
    
    
    if (([UIImagePickerController isSourceTypeAvailable:
          
          UIImagePickerControllerSourceTypeCamera] == NO)
        
        || (delegate == nil)
        
        || (controller == nil))
        
        return NO;
    
    
    
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    
    // Displays a control that allows the user to choose picture or
    
    // movie capture, if both are available:
    
    cameraUI.mediaTypes =
    
    [UIImagePickerController availableMediaTypesForSourceType:
     
     UIImagePickerControllerSourceTypeCamera];
    
    
    
    // Hides the controls for moving & scaling pictures, or for
    
    // trimming movies. To instead show the controls, use YES.
    
    cameraUI.allowsEditing = NO;
    
    
    
    cameraUI.delegate = delegate;
    
    
    
    [controller presentModalViewController: cameraUI animated: YES];
    
    return YES;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    imagePicker = [[UIImagePickerController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
