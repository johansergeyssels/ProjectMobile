//
//  Fotolijst.h
//  ProjectMobile
//
//  Created by Michael on 23/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fotolijst : NSManagedObject

@property (nonatomic, retain) NSNumber * importance;
@property (nonatomic, retain) NSNumber * persoonId;

@end
