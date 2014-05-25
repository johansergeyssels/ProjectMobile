//
//  EventViewController.m
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "EventViewController.h"
#import "EventTableViewCell.h"
#import "Event.h"
#import "EventDetailViewController.h"

@interface EventViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSArray *events;
@property UIColor * firstColor;
@property UIColor * secondColor;
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
}

- (NSArray *) getData
{
    Event *event = [[Event alloc] initWithTitle:@"Fistje op school" location:@"Nijverheidslaan 175" beginDate:[NSDate date] endDate:[NSDate date]];
    NSArray *data = [NSArray arrayWithObjects:event, nil] ;
    return data;
}

- (void) viewDidAppear:(BOOL)animated {
    self.events = [self getData];
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    Event *event = [self.events objectAtIndex:indexPath.row];
    cell.titleLabel.text = event.title;
    cell.locationLabel.text = event.location;
    cell.beginLabel.text = [event.beginDate description];
    cell.endLabel.text = [event.endDate description];
    
    if (indexPath.row % 2) {
        cell.backgroundColor = self.firstColor;
    }else {
        cell.backgroundColor = self.secondColor;
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EventDetailViewController *dest = segue.destinationViewController;
    Event *event = [self.events objectAtIndex:[self.table indexPathForSelectedRow].row];
    dest.event = event;
}
@end
