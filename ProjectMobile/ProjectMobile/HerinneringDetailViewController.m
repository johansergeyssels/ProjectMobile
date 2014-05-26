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



//Hide keyboard

- (IBAction)LabelText:(id)sender {
   [sender resignFirstResponder];
}

- (IBAction)CommentText:(id)sender {
    [sender resignFirstResponder];
}

//foto nemen
- (IBAction)FotoNemen_btn:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        [self updateHerinnering];
        _imageView.image = nil;
        [self startCameraControllerFromViewController: self usingDelegate: self];
    }
    
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera" message:@"Er is geen camera beschikbaar." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//gallerij

- (IBAction)Gallerij_btn:(id)sender {
    [self updateHerinnering];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// voor gallerij en foto nemen
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    _imageView.image = image;
    self.herinnering.foto = UIImageJPEGRepresentation(image, 1.0);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    //[controller presentModalViewController:cameraUI animated: YES];
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // imagePicker
    imagePicker = [[UIImagePickerController alloc] init];
}

-(void)viewDidAppear:(BOOL)animated {
    self.LabelText.text = self.herinnering.label;
    self.CommentText.text = self.herinnering.comment;
    self.imageView.image = [[UIImage alloc]initWithData:self.herinnering.foto];
}

- (void) updateHerinnering
{
    self.herinnering.label = self.LabelText.text;
    self.herinnering.comment = self.CommentText.text;
}

//Herinnering Saven
- (IBAction)save:(id)sender {
    [self updateHerinnering];
    
    NSError *error;
    if ([self.context save:&error]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //error tonen
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
