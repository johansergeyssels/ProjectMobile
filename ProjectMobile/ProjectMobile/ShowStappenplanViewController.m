//
//  ShowStappenplanViewController.m
//  ProjectMobile
//
//  Created by johan on 23/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "ShowStappenplanViewController.h"
#import "ShowStapTableViewCell.h"
#import "Stap.h"

@interface ShowStappenplanViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShowStappenplanViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stepstone.stap.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowStapTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"showStapCell" forIndexPath:indexPath];
    
    Stap *step = [[self.stepstone.stap allObjects] objectAtIndex:indexPath.row];
    
    cell.image.image = [[UIImage alloc]initWithData: step.foto];
    cell.commentField.text = step.comment;
    
    return cell;
}

@end
