//
//  EditStapViewController.m
//  ProjectMobile
//
//  Created by johan on 22/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "EditStapViewController.h"

@interface EditStapViewController ()

@end

@implementation EditStapViewController
- (IBAction)done:(id)sender
{
    self.step.comment = self.stepText.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)takePicture:(id)sender {
    [self.picker setSourceType: UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (IBAction)takeExistingPicture:(id)sender {
    [self.picker setSourceType: UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self.imageView setImage:[info objectForKeyedSubscript:UIImagePickerControllerOriginalImage]];
    self.step.foto = UIImageJPEGRepresentation([info objectForKeyedSubscript:UIImagePickerControllerOriginalImage], 1.0);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.stepText.text = self.step.comment;
    self.imageView.image = [[UIImage alloc]initWithData: self.step.foto];
}

@end
