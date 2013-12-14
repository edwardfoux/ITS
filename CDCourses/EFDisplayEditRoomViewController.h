//
//  EFDisplayEditRoomViewController.m
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "EFGlobalData.h"
#import <MessageUI/MessageUI.h>


@interface EFDisplayEditRoomViewController : UIViewController<MFMailComposeViewControllerDelegate>


@property (nonatomic, strong) Room *currentRoom;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (nonatomic,strong) EFGlobalData *model;

@property (weak, nonatomic) IBOutlet UILabel *stepperLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControll;
@property (weak, nonatomic) IBOutlet UILabel *instrTableLabel;
@property (weak, nonatomic) IBOutlet UILabel *instrChairLabel;
@property (weak, nonatomic) IBOutlet UILabel *studTableLabel;
@property (weak, nonatomic) IBOutlet UILabel *studChairLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepInstTableValue;
@property (weak, nonatomic) IBOutlet UIStepper *stepInstChairValue;
@property (weak, nonatomic) IBOutlet UIStepper *stepStudTableValue;
@property (weak, nonatomic) IBOutlet UIStepper *stepStudChairValue;
@property (weak, nonatomic) IBOutlet UITextField *commentsTF;



- (IBAction)startEditing:(id)sender;
- (IBAction)doneEditing:(id)sender;

@end
