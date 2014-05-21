//
//  Stap.h
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stappenplan;

@interface Stap : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * fotoUrl;
@property (nonatomic, retain) NSNumber * stepNr;
@property (nonatomic, retain) Stappenplan *stappenplan;

@end
