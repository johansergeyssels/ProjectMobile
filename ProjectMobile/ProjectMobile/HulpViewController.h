//
//  HulpViewController.h
//  ProjectMobile
//
//  Created by Daan Theys on 20-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IManagedContextObjectContainer.h"

@interface HulpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, IManagedContextObjectContainer>
@property NSManagedObjectContext* context;

@end
