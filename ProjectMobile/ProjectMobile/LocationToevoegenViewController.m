//
//  LocationToevoegenControllerViewController.m
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "LocationToevoegenViewController.h"
#import "Locatie.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationToevoegenViewController ()

@end

@implementation LocationToevoegenViewController

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

-(void)viewDidAppear:(BOOL)animated
{
    self.GemeenteTextField.text = self.locatie.gemeente;
    self.StraatnaamTextField.text = self.locatie.straatnaam;
    self.HuisnummerTextField.text = self.locatie.huisnummer;
    self.InfoTextField.text = self.locatie.infoOver;
}

- (void)SaveLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString *location = @"";
    if(self.locatie.straatnaam != nil) {
        location = [NSString stringWithFormat:@"%@ ", self.locatie.straatnaam, nil];
    }
    
    if(self.locatie.huisnummer != nil) {
        location = [NSString stringWithFormat:@"%@%@", location, self.locatie.straatnaam, nil];
    }
    
    if(self.locatie.bus != nil) {
        location = [NSString stringWithFormat:@"%@%@ ", location, self.locatie.bus, nil];
    }
    
    if(self.locatie.gemeente != nil) {
        location = [NSString stringWithFormat:@"%@ %@", location, self.locatie.gemeente, nil];
    }
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error)
     {
        if (!error && placemarks && placemarks.count > 0) {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
             
            self.locatie.latitude =  [NSNumber numberWithDouble:topResult.location.coordinate.latitude];
            self.locatie.longitude = [NSNumber numberWithDouble:topResult.location.coordinate.longitude];
             
            NSError* errorSave;
            if([self.context save:&errorSave]) {
                [self performSelectorOnMainThread:@selector(locationSaved) withObject:nil waitUntilDone:YES];
            }
            else
            {
                //error tonen
                [self performSelectorOnMainThread:@selector(showAlertWithMessage:) withObject:@"Bewaren mislukt" waitUntilDone:YES];
            }
        }
         else
         {
             //error tonen
             [self performSelectorOnMainThread:@selector(showAlertWithMessage:) withObject:@"Locatie niet gevonden" waitUntilDone:YES];
         }
     }];
}

-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fout" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)locationSaved
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.locationDelegate addAnotationOnMapWithLocation:self.locatie];
}

- (IBAction)OpslaanButton:(id)sender
{
    self.locatie.gemeente = self.GemeenteTextField.text;
    self.locatie.straatnaam = self.StraatnaamTextField.text;
    self.locatie.huisnummer = self.HuisnummerTextField.text;
    self.locatie.infoOver = self.InfoTextField.text;
    
    [self SaveLocation];
}
@end
