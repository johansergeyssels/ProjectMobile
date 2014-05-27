//
//  LocationToevoegenControllerViewController.m
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "LocationToevoegenControllerViewController.h"
#import "Locatie.h"

@interface LocationToevoegenControllerViewController ()

@end

@implementation LocationToevoegenControllerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GemeenteTextField:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)StraatnaamTextField:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)HuisnummerTextField:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)BusTextField:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)InfoTextField:(id)sender {
    [sender resignFirstResponder];
}


// Wegnemen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.GemeenteTextField resignFirstResponder];
    [self.StraatnaamTextField resignFirstResponder];
    [self.HuisnummerTextField resignFirstResponder];
    [self.BusTextField resignFirstResponder];
    [self.InfoTextField resignFirstResponder];
}


- (IBAction)OpslaanButton:(id)sender {
}
@end
