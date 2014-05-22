//
//  StappenPlanViewController.m
//  ProjectMobile
//
//  Created by johan on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "StappenPlanViewController.h"
#import "Stappenplan.h"
#import "StapTableViewCell.h"
#import "StappenplanDetailViewController.h"

@interface StappenPlanViewController ()

@property NSMutableArray* stepstones;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation StappenPlanViewController

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

- (void)viewDidAppear:(BOOL)animated {
    [self.context rollback];
    [self getStepstones];
}

- (void)getStepstones
{
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Stappenplan"];
    NSError* error;
    self.stepstones = [[self.context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stepstones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StapTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:@"stappenplanCell" forIndexPath:indexPath];
    
    Stappenplan *steppingstone = [self.stepstones objectAtIndex:indexPath.row];
    
    cell.label.text = steppingstone.titel;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"updateStepstones"])
    {
        UITableViewCell *cell = (UITableViewCell *)((UIButton *)sender).superview.superview.superview;
        NSIndexPath *index = [self.table indexPathForCell:cell];
        StappenplanDetailViewController *dest = segue.destinationViewController;
        dest.context = self.context;
        dest.stepstone = [self.stepstones objectAtIndex:index.row];
    }
    else if([segue.identifier isEqualToString:@"addStepstones"])
    {
        StappenplanDetailViewController *dest = segue.destinationViewController;
        dest.context = self.context;
        dest.stepstone = [NSEntityDescription insertNewObjectForEntityForName:@"Stappenplan" inManagedObjectContext:self.context];
    }
    else if([segue.identifier isEqualToString:@"showStepstones"])
    {
        
    }
}

@end
