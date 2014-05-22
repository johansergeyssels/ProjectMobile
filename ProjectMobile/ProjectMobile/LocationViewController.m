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
                // handle response
                //NSLog(@"gelukt");
                NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
                id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
                //NSLog(json);
                //NSLog(@"%@", jsonObject);
                
                ToiletLocaties *toiletlocatie = [[ToiletLocaties alloc] initWithString:json error:&error];
            
                if(!error) {
                    for(Toilet *Toilet in toiletlocatie.openbaartoilet) {
                        NSLog(@"%@", Toilet.district);
                        NSLog(@"%@", Toilet.omschrijving);
                        NSLog(@"%@", Toilet.straat);
                        NSLog(@"%@", Toilet.huisnummer);
                        NSLog(@"%@", Toilet.postcode);
                        NSLog(@"%@", Toilet.point_lat);
                        NSLog(@"%@", Toilet.point_lng);
                        
                        NSString *gemeentePostcodeStraatNummer = [NSString stringWithFormat:@"%@ %@ %@ %@", Toilet.district, Toilet.postcode, Toilet.straat, Toilet.huisnummer];
                        
                        // Toevoegen van een annotatie
                        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
                        
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
                        
                        [self.mapView addAnnotation:pin];

                    }
                }
                

            }] resume];
    
    return YES;
}

//overschrijven standaard pin design
//elke pin die getekend moet worden wordt deze functie uitgevoerd
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
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
            pinView.image = [UIImage imageNamed:@"wc.png"];
            pinView.calloutOffset = CGPointMake(0, 0);
            
        } else {
            pinView.annotation = annotation;
        }
        
        // Add an image to the left callout.
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wc.png"]];
        pinView.leftCalloutAccessoryView = iconView;
        
        return pinView;
    }
    return nil;
    
    



}

@end


