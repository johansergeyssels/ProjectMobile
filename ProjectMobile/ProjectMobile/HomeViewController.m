//
//  HomeViewController.m
//  ProjectMobile
//
//  Created by johan on 19/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HomeViewController.h"
#import "ButtonClickListener.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
- (IBAction)memoryClicked:(id)sender {
    [self.listener didClickButton:1];
}

- (IBAction)calendarClicked:(id)sender {
    [self.listener didClickButton:2];
}

- (IBAction)locationsClicked:(id)sender {
    [self.listener didClickButton:3];
}

- (IBAction)aidClicked:(id)sender {
    [self.listener didClickButton:4];
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
    self.listener = (id<ButtonClickListener>)self.tabBarController;
    [self.listener didClickButton:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
