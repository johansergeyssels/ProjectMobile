//
//  HerinneringToevoegenViewController.m
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HerinneringDetailViewController.h"

@interface HerinneringDetailViewController ()

@end

@implementation HerinneringDetailViewController

//Herinnering Saven
- (IBAction)save:(id)sender {
    self.herinnering.label = self.LabelText.text;
    
    NSError *error;
    if ([self.context save:&error]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //error tonen
    }
}

//Hide keyboard
- (IBAction)LabelText:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)TextVeld:(id)sender {
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

// voor gallerij en foto nemen
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
- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate,
                                                  UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO) || (delegate == nil) || (controller == nil))
        
        return NO;
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    

    // Displays a control that allows the user to choose picture or movie capture, if both are available:
    
    cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for trimming movies. To instead show the controls, use YES.
    
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    
   [controller presentModalViewController: cameraUI animated: YES];
    
    return YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // imagePicker
    imagePicker = [[UIImagePickerController alloc] init];
    // Databank
    self.LabelText.text = self.herinnering.label;
    //self.LabelText.text = self.herinnering.label; VOOR TEXTFIELD!!!!!!!
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.context rollback];
}


@end
