//
//  LocationViewController.m
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "LocationViewController.h"

@implementation LocationViewController

@synthesize mapView;

//als de view geladen is
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
}

//als de gebruiker zijn locatie veranderd, update de mapview
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

@end