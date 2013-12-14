//
//  EFRoomsTableViewController.h
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFAddRoomViewController.h"
#import "EFGlobalData.h"

@interface EFRoomsTableViewController : UITableViewController
<AddCourseViewControllerDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic,strong) EFGlobalData *model;

@end
