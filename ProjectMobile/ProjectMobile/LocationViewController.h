//
//  LocationViewController.h
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface LocationViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSString *naamToiletISomschrijving;
@property (strong, nonatomic) NSString *straatISstraat;
@property (strong, nonatomic) NSString *huisnummerIShuisnummer;
@property (strong, nonatomic) NSString *postcodeISpostcode;
@property (strong, nonatomic) NSString *latitudeISlat;
@property (strong, nonatomic) NSString *longtitudeISlong;

@end

