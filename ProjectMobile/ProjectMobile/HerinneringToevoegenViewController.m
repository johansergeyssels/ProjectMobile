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
