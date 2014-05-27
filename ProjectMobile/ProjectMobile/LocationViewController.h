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

@interface LocationViewController : UIViewController <MKMapViewDelegate, MKAnnotation, IManagedContextObjectContainer, UIGestureRecognizerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSManagedObjectContext* context;
//knop voor toe te voegen (long pressure detectie)
@property (weak, nonatomic) IBOutlet UIButton *locatieToevoegenKnop;

-(BOOL) jsonBinnenhalen;

@end

