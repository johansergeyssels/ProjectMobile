//
//  HulpViewController.m
//  ProjectMobile
//
//  Created by Daan Theys on 20-05-14.
//  Copyright (c) 2014 johan. All rights reserved.
//

#import "HulpViewController.h"
#import "AidTableViewCell.h"
#import "Personen.h"

@interface HulpViewController ()

@property UIColor * eersteKleur;
@property UIColor * tweedeKleur;
@property NSMutableArray *Personen;
@property NSMutableArray *Numbers;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString * tele;

@end

@implementation HulpViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.Personen count];
}


//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AidTableViewCell *geselecteerdeCell = (AidTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    self.tele = geselecteerdeCell.telefoon;
    NSLog(@"%@", self.tele);
    
    UIAlertView *telefoonMelding;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.tele]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        NSLog(@"%@ nummer", self.tele);
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        telefoonMelding = [[UIAlertView alloc]initWithTitle:@"Kan Contact niet opbellen" message:@"Service om contact te bellen is niet beschikbaar" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [telefoonMelding show];
    }

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // ophalen van de gegevens
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Personen"];
    self.Personen = [[self.context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
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
    
    NSPredicate *idPredicate = [NSPredicate predicateWithFormat:@"self.persoonId == %d",ABRecordGetRecordID(person)];
    
    if ([[self.Personen filteredArrayUsingPredicate:idPredicate] count]!=0) {
        UIAlertView *melding = [[UIAlertView alloc] initWithTitle:@"Contact reeds toegevoegd" message:@"U kan een contact maar 1 keer toevoegen in de hulplijst" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [melding show];
        
        [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    
    else  {
        // aanmaken van een nieuwe persoon
        NSManagedObject *newPersoon = [NSEntityDescription insertNewObjectForEntityForName:@"Personen" inManagedObjectContext:self.context];
        NSNumber *id = [NSNumber numberWithInt:ABRecordGetRecordID(person)];
        NSNumber *one = [NSNumber numberWithInt:1];
        [newPersoon setValue: id forKey:@"persoonId"];
        [newPersoon setValue: one forKey:@"importance"];
        
        
        NSError *error = nil;
        // Opslagen
        if (![self.context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        [[peoplePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
        
    }
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
   
    CFErrorRef error = nil;
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions (NULL, &error);
    
    if (addressBookRef != nil) {
        Personen *persoon = [self.Personen objectAtIndex:indexPath.row];
        
        //Het id toevoegen
        ABRecordID recordID =  (int)[[persoon valueForKey:@"persoonId"] integerValue];
        NSLog(@"%d", recordID);
        ABRecordRef nxtABRecordRef = ABAddressBookGetPersonWithRecordID (addressBookRef, recordID);
            
            
        //ophalen van de gegevens
            //naam
        NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(nxtABRecordRef, kABPersonFirstNameProperty);
            //Voornaam
        NSString*lastname = (__bridge_transfer NSString*)ABRecordCopyValue(nxtABRecordRef, kABPersonLastNameProperty);
            //Profielfoto
        NSData  *imgData = (__bridge NSData *)ABPersonCopyImageData(nxtABRecordRef);
        UIImage  *img = [UIImage imageWithData:imgData];
            //Telefoonnummers
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(nxtABRecordRef, kABPersonPhoneProperty);
        NSString* telefoonnummer = nil;
        if (ABMultiValueGetCount(phoneNumbers) > 0) {
           telefoonnummer = (__bridge_transfer NSString*) ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
        } else {
            telefoonnummer = @"[None]";
        }
        NSString *tel = telefoonnummer;
        NSLog(@"%@", telefoonnummer);
        cell.telefoon = tel;
        [cell.naamLabel setText: name];
        [cell.FamilienaamLabel setText:lastname];
        [cell.image setImage:img];
        NSLog(@"%@", name);
        NSLog(@"%@", lastname);
        
        CFRelease(addressBookRef);
    }
    else {
        NSLog(@"Contacten kunnen niet worden geopend.");
    }
    
    // nakijken of het rijnummer even of oneven is. aan de hand van dit de kleur veranderen van de cell.
    if (indexPath.row % 2) {
        cell.backgroundColor = self.eersteKleur;
    }else {
        cell.backgroundColor = self.tweedeKleur;
    }
    
    return cell;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.eersteKleur = [UIColor colorWithRed:183/255.0f green:80/255.0f blue:23/255.0f alpha:1.0f];
    self.tweedeKleur = [UIColor colorWithRed:179/255.0f green:98/255.0f blue:0/255.0f alpha:1.0f];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
