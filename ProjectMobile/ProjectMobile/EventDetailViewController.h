//
//  EventDetailViewController.h
//  ProjectMobile
//
//  Created by johan on 25/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "IManagedContextObjectContainer.h"

@interface EventDetailViewController : UIViewController<IManagedContextObjectContainer>
@property NSManagedObjectContext* context;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginLabel;
@property (weak, nonatomic) IBOutlet UILabel *eindLabel;
@property (weak, nonatomic) IBOutlet UITextView *locationLabel;
@property Event *event;
@end
