//
//  Stap.h
//  ProjectMobile
//
//  Created by johan on 22/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stappenplan;

@interface Stap : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSData * foto;
@property (nonatomic, retain) NSNumber * stepNr;
@property (nonatomic, retain) Stappenplan *stappenplan;

@end
