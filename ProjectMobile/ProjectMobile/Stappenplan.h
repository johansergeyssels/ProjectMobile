//
//  Stappenplan.h
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Stap;

@interface Stappenplan : NSManagedObject

@property (nonatomic, retain) NSString * titel;
@property (nonatomic, retain) NSSet *stap;
@end

@interface Stappenplan (CoreDataGeneratedAccessors)

- (void)addStapObject:(Stap *)value;
- (void)removeStapObject:(Stap *)value;
- (void)addStap:(NSSet *)values;
- (void)removeStap:(NSSet *)values;

@end
