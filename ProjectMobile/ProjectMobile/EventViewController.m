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
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
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
    self.firstColor = [UIColor colorWithRed:183/255.0f green:80/255.0f blue:23/255.0f alpha:1.0f];
    self.secondColor = [UIColor colorWithRed:179/255.0f green:98/255.0f blue:0/255.0f alpha:1.0f];
    
    UITextField *tf;
    for (UIView *view in self.searchBar.subviews){
        if ([view isKindOfClass: [UITextField class]]) {
            tf = (UITextField *)view;
            break;
        }
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UITextField class]]) {
                tf = (UITextField *)subview;
                break;
            }
        }
    }
    tf.enablesReturnKeyAutomatically = NO;
    tf.delegate = self;
    tf.returnKeyType = UIReturnKeySearch;
}

- (NSArray *) getData
{
    Event *event0 = [[Event alloc] initWithTitle:@"samenkomst op school" location:@"Nijverheidslaan 175, 1000 Anderlecht" beginDate:[NSDate date] endDate:[NSDate date]];
    Event *event1 = [[Event alloc] initWithTitle:@"project op school" location:@"Nijverheidslaan 175, 1000 Anderlecht" beginDate:[NSDate date] endDate:[NSDate date]];
    NSArray *data = [NSArray arrayWithObjects:event0, event1, nil] ;
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    EventTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    Event *event = [self.events objectAtIndex:indexPath.row];
    cell.titleLabel.text = event.title;
    cell.beginLabel.text = [dateFormatter stringFromDate:event.beginDate];
    
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{

}

@end
