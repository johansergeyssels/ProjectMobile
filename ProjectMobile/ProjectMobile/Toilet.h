//
//  Toilet.h
//  ProjectMobile
//
//  Created by David Bueds on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "JSONModel.h"

@interface Toilet : JSONModel

@property (strong, nonatomic) NSString *district;
@property (strong, nonatomic) NSString *omschrijving;
@property (strong, nonatomic) NSString *straat;
@property (strong, nonatomic) NSString *huisnummer;
@property (strong, nonatomic) NSString *postcode;
@property (strong, nonatomic) NSString *point_lng;
@property (strong, nonatomic) NSString *point_lat;

@end

@protocol Toilet;