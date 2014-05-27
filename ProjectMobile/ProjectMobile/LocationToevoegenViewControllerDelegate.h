//
//  LocationToevoegenViewControllerDelegate.h
//  ProjectMobile
//
//  Created by johan on 27/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Locatie.h"

@protocol LocationToevoegenViewControllerDelegate <NSObject>
- (void) addAnotationOnMapWithLocation:(Locatie *)location;
@end
