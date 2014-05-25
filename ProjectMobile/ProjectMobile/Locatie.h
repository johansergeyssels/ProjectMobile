//
//  Locatie.h
//  ProjectMobile
//
//  Created by David Bueds on 25/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Locatie : NSManagedObject

@property (nonatomic, retain) NSString * gemeente;
@property (nonatomic, retain) NSString * straatnaam;
@property (nonatomic, retain) NSNumber * huisnummer;
@property (nonatomic, retain) NSString * bus;
@property (nonatomic, retain) NSString * infoOver;

@end
