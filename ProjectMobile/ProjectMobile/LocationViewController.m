//
//  LocationViewController.m
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "LocationViewController.h"

@implementation LocationViewController

//als de view geladen is
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//als de gebruiker zijn locatie veranderd, update de mapview
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //het scherm aanpassen als de gebruiker wandelt.
    NSLog(@"beweegt");
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 800, 800);
    [self.mapView setRegion:region animated:YES];
    
    
    // Toevoegen van een annotatie
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = userLocation.coordinate;
    pin.title = @"Ik ben hier!!!";
    
    [self.mapView addAnnotation:pin];
    
}

@end


