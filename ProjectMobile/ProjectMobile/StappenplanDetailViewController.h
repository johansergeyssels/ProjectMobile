//
//  StappenplanDetailViewController.h
//  ProjectMobile
//
//  Created by johan on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stappenplan.h"
#import "IManagedContextObjectContainer.h"

@interface StappenplanDetailViewController : UIViewController<IManagedContextObjectContainer>
@property Stappenplan *stepstone;
@property NSManagedObjectContext* context;

@end
