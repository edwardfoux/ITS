//
//  EFRoomsTableViewController.m
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import "EFRoomsTableViewController.h"
#import "Room.h"
#import "EFDisplayEditRoomViewController.h"


@interface EFRoomsTableViewController ()

@end

@implementation EFRoomsTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

-(void) addCourseViewControllerDidCancel:(Room *)courseToDelete {
    NSManagedObjectContext *context = self.managedObjectContext;
    [context deleteObject:courseToDelete];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void) addCourseViewControllerDidSave {
    
    NSError *error = nil;
    NSManagedObjectContext *context = self.managedObjectContext;
    if (![context save:&error]) {
        NSLog(@"Error! %@", error);
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"addCourse"]) {
        //
        EFAddRoomViewController *acvc = (EFAddRoomViewController *)[segue destinationViewController];
        acvc.delegate =self;
        
        Room *newRoom = (Room *) [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:[self managedObjectContext]];
        
        acvc.currentRoom = newRoom;
    }
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        EFDisplayEditRoomViewController *dvc = (EFDisplayEditRoomViewController *) [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Room *selectedCourse = (Room *) [self.fetchedResultsController objectAtIndexPath:indexPath];
        dvc.currentRoom = selectedCourse;
    }
}



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model=[EFGlobalData shareModel];
    self.managedObjectContext=self.model.managedObjectContext;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
    

    
    NSManagedObjectContext *context = self.model.managedObjectContext;
    // Custom code here...
    // Save the managed object context
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error while saving %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        exit(1);
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room"
                                              inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    NSError* err = nil;
    int count=[self.model.managedObjectContext countForFetchRequest:fetchRequest error:&err];
    NSLog(@"%d",count);
    if (count>0){
        NSLog(@"There are all the records in the core data");
    }
    else
    {
        NSLog(@"we need to preload the data");
    
    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"rooms" ofType:@"xml"];
    NSArray* Rooms = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                     options:kNilOptions
                                                       error:&err];
    NSLog(@"Imported Rooms: %@", Rooms);
    
   
    
   
    
        [Rooms enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Room *roomData = [NSEntityDescription
                                          insertNewObjectForEntityForName:@"Room"
                                          inManagedObjectContext:context];
        roomData.author = [obj objectForKey:@"Building"];
        roomData.title = [obj objectForKey:@"RoomNumber"];
        roomData.instrTable=[obj objectForKey:@"InstructorTable"];
        roomData.instrChair=[obj objectForKey:@"InstructorChair"];
        roomData.strudentsChair=[obj objectForKey:@"studentChair"];
        roomData.strudentsTable=[obj objectForKey:@"studentTable"];
        roomData.comments=[obj objectForKey:@"coments"];

        
        
        NSError *error;
        if (![context save:&error]) {
          //  NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }];
    
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Room *info in fetchedObjects) {
       // NSLog(@"author: %@", info.author);
       
    }
    
    }
    
    
  
   

    
    NSError *error2 = nil;
    if (![[self fetchedResultsController] performFetch:&error2]) {
        NSLog(@"Error! %@",error2);
        abort();
    }
    
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [[self.fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> secInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [secInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Room *room = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = room.title;
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
        Room *courseToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:courseToDelete];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error! %@",error);
        }
    }
    
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
#pragma mark -
#pragma mark Fetched Results Controller section
-(NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Room"
                                              inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"author"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"author" cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate: {
            Room *changedCourse = [self.fetchedResultsController objectAtIndexPath:indexPath];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.text = changedCourse.title;
        }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}

-(void) controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
