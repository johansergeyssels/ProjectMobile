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
#import "LocationToevoegenViewControllerDelegate.h"
#import "Event.h"

@interface LocationViewController : UIViewController <MKMapViewDelegate, IManagedContextObjectContainer, UIGestureRecognizerDelegate, UIPopoverControllerDelegate, LocationToevoegenViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSManagedObjectContext* context;
@property BOOL noEdit;
@property Event *event;

-(BOOL) jsonBinnenhalen;

@end

