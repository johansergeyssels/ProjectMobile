//
//  StappenplanDetailViewController.m
//  ProjectMobile
//
//  Created by johan on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "StappenplanDetailViewController.h"
#import "Stappenplan.h"
#import "Stap.h"
#import "EditStapViewController.h"
#import "EditStapTableViewCell.h"

@interface StappenplanDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSArray *stepsSorted;
@end

@implementation StappenplanDetailViewController
- (void) reload {
    [self.table reloadData];
    NSArray *array = [self.stepstone.stap allObjects];
    self.stepsSorted = [array sortedArrayUsingComparator: ^(Stap *obj1, Stap *obj2) {
        
        if (obj1.stepNr > obj2.stepNr) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (obj1.stepNr < obj2.stepNr) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
}

- (IBAction)addStap:(id)sender {
    Stap* step = [NSEntityDescription insertNewObjectForEntityForName:@"Stap" inManagedObjectContext:self.context];
    step.comment = @"stap";
    step.stepNr = [NSNumber numberWithLong:(self.stepstone.stap.count + 1)];
    [self.stepstone addStapObject:step];
    [self reload];
}

- (IBAction)save:(id)sender {
    self.stepstone.titel = self.titleLabel.text;
    
    NSError* error;
    if([self.context save:&error]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //error tonen
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    self.titleLabel.text = self.stepstone.titel;
    [self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stepstone.stap.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(indexPath.row == self.stepstone.stap.count)
    {
        cell = [self.table dequeueReusableCellWithIdentifier:@"newStapCell" forIndexPath:indexPath];
    }
    else
    {
        EditStapTableViewCell *editcell = [self.table dequeueReusableCellWithIdentifier:@"stapCell" forIndexPath:indexPath];
        Stap *step = [self.stepsSorted objectAtIndex:indexPath.row];
        editcell.commentLabel.text = step.comment;
        editcell.titleLabel.text = [NSString stringWithFormat:@"Stap %@", step.stepNr];
        cell = editcell;
    }
    return cell;
}

- (IBAction)removeStep:(id)sender {
    UITableViewCell *cell = (UITableViewCell *)((UIButton *)sender).superview.superview.superview;
    NSIndexPath *index = [self.table indexPathForCell:cell];
    Stap *step = [self.stepsSorted objectAtIndex:index.row];
    [self.stepstone removeStapObject:step];
    [self reload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"editStep"])
    {
        UITableViewCell *cell = (UITableViewCell *)((UIButton *)sender).superview.superview.superview;
        NSIndexPath *index = [self.table indexPathForCell:cell];
        EditStapViewController *dest = segue.destinationViewController;
        dest.step = [self.stepsSorted objectAtIndex:index.row];
        
    }
}

@end
