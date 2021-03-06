//
//  EditStapViewController.m
//  ProjectMobile
//
//  Created by johan on 22/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "EditStapViewController.h"

@interface EditStapViewController ()
@property (weak, nonatomic) IBOutlet UITextView *commentTextfield;

@end

@implementation EditStapViewController
- (IBAction)done:(id)sender
{
    self.step.comment = self.commentTextfield.text;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)takePicture:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        self.step.comment = self.commentTextfield.text;
        [self.picker setSourceType: UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:self.picker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"camera" message:@"Er is geen camera beschikbaar" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)takeExistingPicture:(id)sender {
    self.step.comment = self.commentTextfield.text;
    [self.picker setSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
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
    self.commentTextfield.text = self.step.comment;
    self.imageView.image = [[UIImage alloc]initWithData: self.step.foto];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.commentTextfield resignFirstResponder];
}

@end
