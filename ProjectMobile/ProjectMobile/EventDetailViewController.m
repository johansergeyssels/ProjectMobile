//
//  EventDetailViewController.m
//  ProjectMobile
//
//  Created by johan on 25/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "EventDetailViewController.h"
#import <EventKit/EventKit.h>
#import "LocationViewController.h"
#import "Locatie.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *agendaButton;
@property EKEventStore *store;
@end

@implementation EventDetailViewController
- (IBAction)addEventToAgenda:(id)sender {
    EKEvent *event = [EKEvent eventWithEventStore:self.store];
    [event setTitle:self.event.title];
    [event setStartDate:self.event.beginDate];
    [event setEndDate:self.event.endDate];
    EKCalendar *calendar = [[self.store calendarsForEntityType:EKEntityTypeEvent] objectAtIndex:0];
    [event setCalendar:calendar];
    NSError *errorSave;
    [self.store saveEvent:event span:EKSpanThisEvent commit:YES error:&errorSave];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opgeslagen" message:@"Het event is toegevoegd aan uw agenda" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
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
    self.store = [[EKEventStore alloc] init];
    
    [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if(granted)
         {
             [self.agendaButton setEnabled:YES];
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm dd/MM/yyyy"];
    self.titleLabel.text = self.event.title;
    self.locationLabel.text = self.event.location;
    self.beginLabel.text = [NSString stringWithFormat:@"Begint om %@",[dateFormatter stringFromDate:self.event.beginDate]];
    self.eindLabel.text = [NSString stringWithFormat:@"Eindigt om %@",[dateFormatter stringFromDate:self.event.beginDate]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LocationViewController *dest = segue.destinationViewController;
    dest.context = self.context;
    dest.noEdit = YES;
    dest.event = self.event;
}

@end
