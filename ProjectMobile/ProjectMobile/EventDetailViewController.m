//
//  EventDetailViewController.m
//  ProjectMobile
//
//  Created by johan on 25/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "EventDetailViewController.h"
#import <EventKit/EventKit.h>

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController
- (IBAction)addEventToAgenda:(id)sender {
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
    {
        if(granted)
        {
            EKEvent *event = [EKEvent eventWithEventStore:store];
            [event setTitle:self.event.title];
            [event setStartDate:self.event.beginDate];
            [event setEndDate:self.event.endDate];
            EKCalendar *calendar = [[store calendarsForEntityType:EKEntityTypeEvent] objectAtIndex:0];
            [event setCalendar:calendar];
            NSError *errorSave;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&errorSave];
        }
    }];
}

- (IBAction)addEventLocation:(id)sender {
    
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    self.titleLabel.text = self.event.title;
    self.locationLabel.text = self.event.location;
    self.beginLabel.text = [self.event.beginDate description];
    self.eindLabel.text = [self.event.endDate description];
}

@end
