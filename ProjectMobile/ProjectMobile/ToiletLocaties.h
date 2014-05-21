//
//  ToiletLocaties.h
//  ProjectMobile
//
//  Created by David Bueds on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "JSONModel.h"
#import "Toilet.h"

@interface ToiletLocaties : JSONModel
@property (strong, nonatomic) NSMutableArray<Toilet> *openbaartoilet;
@end
