//
//  EFAddRoomViewController.m
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import "EFAddRoomViewController.h"

@interface EFAddRoomViewController ()

@end

@implementation EFAddRoomViewController
@synthesize titleField;
@synthesize authorField;
@synthesize dateField;

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
    titleField.text = [self.currentRoom title];
    authorField.text = [self.currentRoom author];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    dateField.text =[dateFormat stringFromDate:[self.currentRoom releaseDate]];
     
}

- (void)viewDidUnload
{
    [self setTitleField:nil];
    [self setAuthorField:nil];
    [self setDateField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    // dismiss and remove the object
    [self.delegate addCourseViewControllerDidCancel:[self currentRoom]];
}

- (IBAction)save:(id)sender {
    // dismiss and save the context
    [self.currentRoom setTitle:titleField.text];
    [self.currentRoom setAuthor:authorField.text];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [self.currentRoom setReleaseDate:[dateFormat dateFromString:dateField.text]];
    
    [self.delegate addCourseViewControllerDidSave];
    
    
}
@end
