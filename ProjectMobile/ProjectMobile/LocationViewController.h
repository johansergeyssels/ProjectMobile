//
//  LocationViewController.h
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "IManagedContextObjectContainer.h"
#import "Locatie.h"
#import "LocationToevoegenViewControllerDelegate.h"

@interface LocationViewController : UIViewController <MKMapViewDelegate, IManagedContextObjectContainer, UIGestureRecognizerDelegate, UIPopoverControllerDelegate, LocationToevoegenViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *locatieToevoegenButton;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSManagedObjectContext* context;
@property Locatie *locatie;

-(BOOL) jsonBinnenhalen;

@end

