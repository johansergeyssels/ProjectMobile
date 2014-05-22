//
//  HulpViewController.m
//  ProjectMobile
//
//  Created by Daan Theys on 20-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HulpViewController.h"
#import "AidTableViewCell.h"

@interface HulpViewController ()

@property UIColor * firstColor;
@property UIColor * secondColor;
@property NSMutableArray *Personen;
@property NSMutableArray *Info;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HulpViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.Personen count];
}

-(void)viewDidAppear:(BOOL)animated{

}

- (IBAction)pickPerson:(id)sender {
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)peoplePickerNavigationControllerDidCancel: (ABPeoplePickerNavigationController *)peoplePicker {
    
    [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    // Create a new person
    NSManagedObject *newPersoon = [NSEntityDescription insertNewObjectForEntityForName:@"Personen" inManagedObjectContext:self.context];
    NSNumber *id = [NSNumber numberWithInt:ABRecordGetRecordID(person)];
    NSNumber *one = [NSNumber numberWithInt:1];
    NSLog(@"%d",ABRecordGetRecordID(person));
    NSLog(@"%d", [id integerValue]);
    [newPersoon setValue: id forKey:@"persoonId"];
    [newPersoon setValue: one forKey:@"importance"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![self.context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    
    
    
        [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    
    return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"hulpCell";
    
    AidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AidTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // check if row is odd or even and set color accordingly
    if (indexPath.row % 2) {
        cell.backgroundColor = self.firstColor;
    }else {
        cell.backgroundColor = self.secondColor;
    }
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstColor = [UIColor colorWithRed:183/255.0f green:80/255.0f blue:23/255.0f alpha:1.0f];
    self.secondColor = [UIColor colorWithRed:179/255.0f green:98/255.0f blue:0/255.0f alpha:1.0f];
    
    
    
    // Fetch the devices from persistent data store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Personen"];
    self.Personen = [[self.context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
    CFErrorRef error = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions (NULL, &error);
    
    
   
    if (addressBookRef != nil) {
        
        //Loop door de array
        for (int i = 0; i < self.Personen.count; i++){
        NSManagedObject *persoon;
        persoon = [self.Personen objectAtIndex:i];
        
        //Het id toevoegen
        ABRecordID recordID = [[persoon valueForKey:@"persoonId"] integerValue]; // Assign here your ID
        NSLog(@"%d", recordID);
        ABRecordRef nxtABRecordRef = ABAddressBookGetPersonWithRecordID (addressBookRef, recordID);
            //show name and lastname
            NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(nxtABRecordRef, kABPersonFirstNameProperty);
            NSLog(@"%@", name);
            [self.Info addObject:(__bridge id) nxtABRecordRef];
            
        }
        
        for (int i = 0; i < self.Info.count; i++)
        {
            ABRecordRef contactRecord =(__bridge ABRecordRef)([self.Info objectAtIndex:i]);
             NSLog(@"%@", contactRecord);
            
            
        }
        
        
        /*if (addressesRef != nil) {
            for (int index = 0; index < ABMultiValueGetCount(addressesRef); index++) {
                NSDictionary *addressDictionary = (__bridge_transfer NSDictionary*) ABMultiValueCopyValueAtIndex(addressesRef,index);
                
            } // for all addresses
            
            CFRelease(addressesRef);
        }*/
        
        CFRelease(addressBookRef);
}
    else {
        NSLog(@"Could not open address book");
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
