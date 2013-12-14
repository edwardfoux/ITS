//
//  EFAddRoomViewController.h
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@protocol AddCourseViewControllerDelegate;

@interface EFAddRoomViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;

@property (nonatomic, weak) id <AddCourseViewControllerDelegate> delegate;

@property (nonatomic, strong) Room *currentRoom;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

@protocol AddCourseViewControllerDelegate
-(void)addCourseViewControllerDidSave;
-(void)addCourseViewControllerDidCancel:(Room *)courseToDelete;
@end
