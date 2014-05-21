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
    [self jsonBinnenhalen];
    
    
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

- (BOOL) jsonBinnenhalen {
    NSString *openbaarToiletUrl = @"http://datasets.antwerpen.be/v1/infrastructuur/openbaartoilet.json";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:openbaarToiletUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSLog(@"gelukt");
                NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
                id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
                //NSLog(json);
                NSLog(@"%@", jsonObject);

            }] resume];
    
    return YES;
}

@end


