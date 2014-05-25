//
//  EventViewController.m
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "EventViewController.h"
#import <EventKit/EventKit.h>

@interface EventViewController ()
@property EKEventStore *store;
@end

@implementation EventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.store = [[EKEventStore alloc] init];
    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        // handle access here
        EKEvent *event = [EKEvent eventWithEventStore:self.store];
        [event setTitle:@"TestEVent"];
        [event setStartDate:[NSDate date]];
        [event setEndDate:[NSDate date]];
        //NSCalendar *calendar = [NSCalendar currentCalendar];
        EKCalendar *calendar = [[self.store calendarsForEntityType:EKEntityTypeEvent] objectAtIndex:0];
        
        [event setCalendar:calendar];
        NSError *errorSave;
        [self.store saveEvent:event span:EKSpanThisEvent commit:YES error:&errorSave];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
