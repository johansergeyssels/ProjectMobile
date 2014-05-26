//
//  Event.m
//  ProjectMobile
//
//  Created by johan on 25/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)initWithTitle:(NSString*)title location:(NSString*)location beginDate:(NSDate*)begin endDate:(NSDate*)end
{
    self = [super init];
    if(self)
    {
        self.title = title;
        self.location = location;
        self.beginDate = begin;
        self.endDate = end;
    }
    return self;
}

@end
