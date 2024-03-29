//
//  AppDelegate.h
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFRoomsTableViewController.h"
#import "EFHomeScreenController.h"
#import "EFGlobalData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) EFGlobalData *model;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
