//
//  StappenPlanViewController.h
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IManagedContextObjectContainer.h"

@interface StappenPlanViewController : UIViewController<IManagedContextObjectContainer>
@property NSManagedObjectContext* context;
@end
