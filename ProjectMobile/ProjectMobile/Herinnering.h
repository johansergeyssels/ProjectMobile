//
//  Herinnering.h
//  ProjectMobile
//
//  Created by KOEKOEKX Annelies (s) on 22/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Herinnering : NSManagedObject

@property (nonatomic, retain) NSString * fotourl;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSString * label;

@end
