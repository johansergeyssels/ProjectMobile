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
    self.stepText.text = self.step.comment;
}

@end
