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

@interface StappenplanDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation StappenplanDetailViewController
- (IBAction)addStap:(id)sender {
    Stap* step = [NSEntityDescription insertNewObjectForEntityForName:@"Stap" inManagedObjectContext:self.context];
    [self.stepstone addStapObject:step];
    [self.table reloadData];
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

-(void)viewDidDisappear:(BOOL)animated {
    [self.context rollback];
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
    [self.table reloadData];
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
        cell = [self.table dequeueReusableCellWithIdentifier:@"stapCell" forIndexPath:indexPath];
    }
    return cell;
}

@end
