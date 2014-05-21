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
    
    /*
     // Toevoegen van een annotatie
     MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
     //double latitude = [Toilet.point_lat doubleValue];
     //double longtitude = [Toilet.point_lng doubleValue];
     _coordinate.latitude = 4.4094030000000544;
     _coordinate.longitude = 51.225956140000051;
     NSLog(@"%f", _coordinate.latitude);
     NSLog(@"%f", _coordinate.longitude);
     //pin.coordinate = userLocation.coordinate;
     //NSLog(@"@%", _coordinate.latitude);
     //NSLog(_coordinate.longitude);
     
     //pin.coordinate = userLocation.coordinate;
     pin.title = @"Ik ben hier!!!";
     
     [self.mapView addAnnotation:pin];
     */
    
}

//als de gebruiker zijn locatie veranderd, update de mapview
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //het scherm aanpassen als de gebruiker wandelt.
    NSLog(@"beweegt");
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
                NSLog(@"gelukt");
                NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
                id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error:&error];
                //NSLog(json);
                NSLog(@"%@", jsonObject);
                
                ToiletLocaties *toiletlocatie = [[ToiletLocaties alloc] initWithString:json error:&error];
            
                if(!error) {
                    for(Toilet *Toilet in toiletlocatie.openbaartoilet) {
                        NSLog(@"%@", Toilet.omschrijving);
                        NSLog(@"%@", Toilet.straat);
                        NSLog(@"%@", Toilet.huisnummer);
                        NSLog(@"%@", Toilet.postcode);
                        NSLog(@"%@", Toilet.point_lat);
                        NSLog(@"%@", Toilet.point_lng);
                        
                    }
                }
                

            }] resume];
    
    return YES;
}


//////
- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.name = name;
        } else {
            self.name = @"naam is onbekend";
        }
        self.address = address;
        self.theCoordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}



@end


