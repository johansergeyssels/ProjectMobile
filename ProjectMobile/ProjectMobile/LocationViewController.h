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

@interface LocationViewController : UIViewController <MKMapViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


-(BOOL) jsonBinnenhalen;

@end

