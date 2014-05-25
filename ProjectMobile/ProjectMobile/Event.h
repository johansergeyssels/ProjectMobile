//
//  Event.h
//  ProjectMobile
//
//  Created by johan on 25/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
@property NSString *title;
@property NSString *location;
@property NSDate *beginDate;
@property NSDate *endDate;

- (id)initWithTitle:(NSString*)title location:(NSString*)location beginDate:(NSDate*)begin endDate:(NSDate*)end;
@end
