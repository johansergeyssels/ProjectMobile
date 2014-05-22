//
//  Personen.h
//  ProjectMobile
//
//  Created by Daan Theys on 21-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Personen : NSManagedObject

@property (nonatomic, retain) NSNumber * persoonId;
@property (nonatomic, retain) NSNumber * importance;

@end
