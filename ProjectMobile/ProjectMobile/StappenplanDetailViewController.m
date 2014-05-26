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
@property UIColor * firstColor;
@property UIColor * secondColor;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.titleLabel resignFirstResponder];
}

- (IBAction)TitelButtonOutside:(id)sender {
    [sender resignFirstResponder];
}



- (IBAction)TitelButtonLeave:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)addStap:(id)sender {
    Stap* step = [NSEntityDescription insertNewObjectForEntityForName:@"Stap" inManagedObjectContext:self.context];
    step.comment = @"stap";
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Stap"];
    
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"stepNr" ascending:NO]];
    
    NSError *error = nil;
    
    Stap *lastStep = [self.context executeFetchRequest:fetchRequest error:&error].lastObject;
    
    step.stepNr = [NSNumber numberWithInt:[lastStep.stepNr intValue] + 1];
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
    self.firstColor = [UIColor colorWithRed:183/255.0f green:80/255.0f blue:23/255.0f alpha:1.0f];
    self.secondColor = [UIColor colorWithRed:179/255.0f green:98/255.0f blue:0/255.0f alpha:1.0f];
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
        editcell.commentField.text = step.comment;
        editcell.titleLabel.text = [NSString stringWithFormat:@"Stap %ld", (indexPath.row + 1)];
        editcell.image.image = [[UIImage alloc] initWithData:step.foto];
        cell = editcell;
        if (indexPath.row % 2) {
            editcell.commentField.backgroundColor = self.firstColor;
            //editcell.image.backgroundColor = self.secondColor;
            
        }else {
            editcell.commentField.backgroundColor = self.secondColor;
            //editcell.image.backgroundColor = self.firstColor;
        }
    }
    
    if (indexPath.row % 2) {
        cell.backgroundColor = self.firstColor;
        
    }else {
        cell.backgroundColor = self.secondColor;
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
