//
//  PersonenViewController.m
//  ProjectMobile
//
//  Created by Michael on 20/05/14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "PersonenViewController.h"
#import "PersoonCell.h"
#import "PersoonDetailViewController.h"
#import "Fotolijst.h"


@interface PersonenViewController ()

@property NSMutableArray *PersoonImages;
@property (weak, nonatomic) IBOutlet UICollectionView *personenCollection;


@end

@implementation PersonenViewController

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


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.PersoonImages count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentiefier = @"Cell";
    PersoonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentiefier forIndexPath: indexPath];
    
    CFErrorRef error = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions (NULL, &error);
    
    if (addressBookRef != nil) {
        Fotolijst *fotolijst = [self.PersoonImages objectAtIndex:indexPath.item];
        
        ABRecordID recordID = (int)[[fotolijst valueForKey:@"persoonId"] integerValue]; // Assign here your ID
        NSLog(@"%d", recordID);
        ABRecordRef nxtABRecordRef = ABAddressBookGetPersonWithRecordID (addressBookRef, recordID);
        
        
//Image binnenhalen
        NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(nxtABRecordRef);
        UIImage  *img = [UIImage imageWithData:imgData];
        NSString* naam = (__bridge_transfer NSString*)ABRecordCopyValue(nxtABRecordRef, kABPersonFirstNameProperty);
        NSString* familienaam = (__bridge_transfer NSString*)ABRecordCopyValue(nxtABRecordRef, kABPersonLastNameProperty);

        [cell.persoonImage setImage:img];
        cell.name = naam;
        cell.familyName = familienaam;
        NSLog(@"%@", cell.name);
        NSLog(@"%@", cell.familyName);
            
        CFRelease(addressBookRef);
    }
    else {
        NSLog(@"Could not open address book");
    }

    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    
    NSPredicate *valuePredicate = [NSPredicate predicateWithFormat:@"self.persoonId == %d",ABRecordGetRecordID(person)];
    
    if ([[self.PersoonImages filteredArrayUsingPredicate:valuePredicate] count]!=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact reeds toegevoegd" message:@"U kan een contact maar 1 keer toevoegen in de fotolijst" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else {
        
// Persoon aanmaken
    NSManagedObject *newPersoon = [NSEntityDescription insertNewObjectForEntityForName:@"Fotolijst" inManagedObjectContext:self.context];
    NSNumber *id = [NSNumber numberWithInt:ABRecordGetRecordID(person)];
    NSNumber *one = [NSNumber numberWithInt:1];
    [newPersoon setValue: id forKey:@"persoonId"];
    [newPersoon setValue: one forKey:@"importance"];
    
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
    }
    
    
    
    [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    [self.personenCollection reloadData];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    
    return NO;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PersoonDetailViewController"]) {
        NSArray *array = [self.personenCollection indexPathsForSelectedItems];
        NSIndexPath *indexpath = [array objectAtIndex:0];
        
        NSLog(@"%ld", (long)indexpath.section);
        NSLog(@"%ld", (long)indexpath.item);
        
        PersoonCell *cell = (PersoonCell*)[self.personenCollection cellForItemAtIndexPath:indexpath];
        UIImage *image = cell.persoonImage.image;

        PersoonDetailViewController *dest = segue.destinationViewController;
        dest.image = image;
        dest.naam = cell.name;
        dest.fnaam = cell.familyName;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Gegevens databnk binnenhalen
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Fotolijst"];
    self.PersoonImages = [[self.context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.personenCollection reloadData];
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
