//
//  StappenplanDetailViewController.m
//  ProjectMobile
//
//  Created by johan on 21/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "StappenplanDetailViewController.h"

@interface StappenplanDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;

@end

@implementation StappenplanDetailViewController
- (IBAction)save:(id)sender {
    
    if(!self.stepstone) {
        self.stepstone = [NSEntityDescription insertNewObjectForEntityForName:@"Stappenplan" inManagedObjectContext:self.context];
    }
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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if(self.stepstone)
    {
        self.titleLabel.text = self.stepstone.titel;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
