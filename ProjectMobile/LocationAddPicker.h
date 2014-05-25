//
//  LocationAddPicker.h
//  ProjectMobile
//
//  Created by David Bueds on 24/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationAddPicker <NSObject>
@end

@interface LocationAddPicker : UITableViewController

@property (nonatomic, strong) NSMutableArray *locationArray;

@end
