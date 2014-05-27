//
//  LocationViewController.m
//  ProjectMobile
//
//  Created by David Bueds on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "LocationViewController.h"
#import "Toilet.h"
#import "ToiletLocaties.h"
#import "LocationToevoegenViewController.h"
#import "CustomMKPointAnnotation.h"
#import "Locatie.h"

@interface LocationViewController()
@property (nonatomic, strong) UIPopoverController *_popover;
@property NSMutableArray *locations;
@end

@implementation LocationViewController

//als de view geladen is
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jsonBinnenhalen];
    [self setLocations];
    
    /*//https://developer.apple.com/library/ios/documentation/uikit/reference/UILongPressGestureRecognizer_Class/Reference/Reference.html
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 2.0;
    [self.locatieToevoegenButton addGestureRecognizer:longPress];*/
    
}

/*
-(void) handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    if (self.locatieToevoegenButton.state == UIGestureRecognizerStateBegan){
        NSLog(@"Begin duwen");
        
        //als de popover is aangemaakt
        if(self._popover) {
            //
            [self._popover dismissPopoverAnimated:YES];
            self._popover = nil;
            return;
        }
        UIViewController *testVC = [self.storyboard instantiateViewControllerWithIdentifier:@"testVC"];
        testVC.preferredContentSize = CGSizeMake(200, 100);
        self._popover = [[UIPopoverController alloc] initWithContentViewController:testVC];
        self._popover.delegate = self;
        [self._popover presentPopoverFromBarButtonItem:(UIBarButtonItem *)recognizer permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self._popover = nil;
}
 */

//als de gebruiker zijn locatie veranderd, update de mapview
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //het scherm aanpassen als de gebruiker wandelt.
    //NSLog(@"beweegt");
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 800, 800);
    [self.mapView setRegion:region animated:YES];
}

- (BOOL) jsonBinnenhalen {
    //url naar toilet api van de stad antwerpen
    //http://www.raywenderlich.com/51127/nsurlsession-tutorial
    NSString *openbaarToiletUrl = @"http://datasets.antwerpen.be/v1/infrastructuur/openbaartoilet.json";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:openbaarToiletUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                ToiletLocaties *toiletlocatie = [[ToiletLocaties alloc] initWithString:json error:&error];
            
                if(!error) {
                    NSMutableArray *lijstWCAnnotations = [[NSMutableArray alloc] init];
                    for(Toilet *Toilet in toiletlocatie.openbaartoilet) {
                        
                        NSString *gemeentePostcodeStraatNummer = [NSString stringWithFormat:@"%@ %@ %@ %@", Toilet.district, Toilet.postcode, Toilet.straat, Toilet.huisnummer];
                        
                        // Toevoegen van een annotatie
                        CustomMKPointAnnotation *pin = [[CustomMKPointAnnotation alloc] init];
                        pin.type = @"WC";
                        
                        //maken van een een coordinaat met longtitude en latitude
                        CLLocationCoordinate2D pinCoordinate;
                        //specifieren van de latitude en longtitude
                        double latitude = Toilet.point_lat.doubleValue;
                        double longtitude = Toilet.point_lng.doubleValue;
                        
                        pinCoordinate.latitude = latitude;
                        pinCoordinate.longitude = longtitude;
                        //toewijzen van de pincoordinaten aan de pin zelf
                        pin.coordinate = pinCoordinate;
                        
                        //pin.coordinate = userLocation.coordinate;
                        pin.title = Toilet.omschrijving;
                        pin.subtitle = gemeentePostcodeStraatNummer;
                        
                        //[self.mapView addAnnotation:pin];
                        [lijstWCAnnotations addObject:pin];
                    }
                    [self performSelectorOnMainThread:@selector(updateWCLijstOnMapWithList:) withObject:lijstWCAnnotations waitUntilDone:YES];
                }
            }] resume];
    
    return YES;
}

- (void) updateWCLijstOnMapWithList:(NSMutableArray *) list
{
    [self.mapView addAnnotations:list];
}

//overschrijven standaard pin design
//elke pin die getekend moet worden wordt deze functie uitgevoerd
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    CustomMKPointAnnotation *customanno = (CustomMKPointAnnotation *)annotation;
    //checkt de locatie waar je nu bent
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    //Deze functie gaat elke custom (wc) annotatie gaan behandelen
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            if([customanno.type  isEqual: @"WC"])
            {
                pinView.image = [UIImage imageNamed:@"wc.png"];
            }
            else if([customanno.type  isEqual: @"Other"])
            {
                pinView.image = [UIImage imageNamed:@"1groen.png"];
            }
            pinView.calloutOffset = CGPointMake(0, 0);
        }
        else
        {
            pinView.annotation = annotation;
        }
        
        // Add an image to the left callout.
        UIImageView *iconView;
        if([customanno.type  isEqual: @"WC"])
        {
            iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wc.png"]];
        }
        else if([customanno.type  isEqual: @"Other"])
        {
            iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1groen.png"]];
        }
        pinView.leftCalloutAccessoryView = iconView;
        
        return pinView;
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.context rollback];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LocationToevoegenViewController *dest = segue.destinationViewController;
    dest.context = self.context;
    dest.locatie = [NSEntityDescription insertNewObjectForEntityForName:@"Locatie" inManagedObjectContext:self.context];
    dest.locationDelegate = self;
}

- (void)addLocationOnMap:(Locatie *)location
{
    CustomMKPointAnnotation *pin = [[CustomMKPointAnnotation alloc] init];
    pin.type = @"Other";
    
    //maken van een een coordinaat met longtitude en latitude
    CLLocationCoordinate2D pinCoordinate;
    //specifieren van de latitude en longtitude
    double latitude = [location.latitude doubleValue];
    double longtitude = [location.longitude doubleValue];
    
    pinCoordinate.latitude = latitude;
    pinCoordinate.longitude = longtitude;
    //toewijzen van de pincoordinaten aan de pin zelf
    pin.coordinate = pinCoordinate;
    
    //pin.coordinate = userLocation.coordinate;
    if(location.infoOver != nil && ![location.infoOver  isEqual: @""])
    {
        pin.title = location.infoOver;
    }
    else
    {
        pin.title = @"toegevoegde locatie";
    }
    NSString *locationString = @"";
    if(location.straatnaam != nil) {
        locationString = [NSString stringWithFormat:@"%@ ", location.straatnaam, nil];
    }
    
    if(location.huisnummer != nil) {
        locationString = [NSString stringWithFormat:@"%@%@", locationString, location.huisnummer, nil];
    }
    
    if(location.bus != nil) {
        locationString = [NSString stringWithFormat:@"%@%@ ", locationString, location.bus, nil];
    }
    
    if(location.gemeente != nil) {
        locationString = [NSString stringWithFormat:@"%@ %@", locationString, location.gemeente, nil];
    }
    pin.subtitle = locationString;
    
    //[self.mapView addAnnotation:pin];
    [self.mapView addAnnotation:pin];
}

- (void) setLocations
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Locatie"];
    NSError* error;
    self.locations = [[self.context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    for (Locatie *location in self.locations) {
        [self addLocationOnMap:location];
    }
}

-(void)addAnotationOnMapWithLocation:(Locatie *)location
{
    [self addLocationOnMap:location];
}
@end


