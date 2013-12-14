//
//  EFDisplayEditRoomViewController.m
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import "EFDisplayEditRoomViewController.h"
#import "AppDelegate.h"


@interface EFDisplayEditRoomViewController ()

@end

@implementation EFDisplayEditRoomViewController
@synthesize titleField;
@synthesize authorField;
@synthesize dateField;
@synthesize doneButton;
@synthesize editButton;

@synthesize instrChairLabel;
@synthesize instrTableLabel;
@synthesize studChairLabel;
@synthesize studTableLabel;
@synthesize commentsTF;
@synthesize segmentedControll;

- (IBAction)stepperInstTablePressed:(id)sender {
    
    UIStepper *stepper=(UIStepper *)sender;
    
    int stepperNum=(int)stepper.value;
    NSString *numTables=[[NSString alloc]initWithFormat:@"%d",stepperNum];
    self.instrTableLabel.text=numTables;
}
- (IBAction)removeKeyboardExit:(id)sender {
    [self resignFirstResponder];
}
- (IBAction)backgroundPresed:(id)sender {
    [self.commentsTF resignFirstResponder];
}
- (IBAction)stepperInstrChairPressed:(id)sender {
    UIStepper *stepper=(UIStepper *)sender;
    
    int stepperNum=(int)stepper.value;
    NSString *numChairs=[[NSString alloc]initWithFormat:@"%d",stepperNum];
    self.instrChairLabel.text=numChairs;
}
- (IBAction)stepperStudTablePressed:(id)sender {
    UIStepper *stepper=(UIStepper *)sender;
    
    int stepperNum=(int)stepper.value;
    NSString *numTables=[[NSString alloc]initWithFormat:@"%d",stepperNum];
    self.studTableLabel.text=numTables;
}
- (IBAction)stepperStudChairPressed:(id)sender {
    UIStepper *stepper=(UIStepper *)sender;
    
    int stepperNum=(int)stepper.value;
    NSString *numChairs=[[NSString alloc]initWithFormat:@"%d",stepperNum];
    self.studChairLabel.text=numChairs;
}


- (IBAction)sendButtonPressed:(id)sender {
    
    
    NSLog(@"message has been sent");
    NSString *url =[NSString stringWithFormat:@"mailto:ed.foux@gmail.com?cc=bar@example.com&subject=Report&body=[%@],",self.model.report];
    
    NSLog(@"%@",url);
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}





-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissModalViewControllerAnimated:nil];
}


- (IBAction)addReportButonPressed:(id)sender {
    
    
    NSLog(@"the username is %@",self.model.userName);
    NSString * report = [NSString stringWithFormat:@"'UserName':'%@','DayNight':'%@','Building':'%@','RoomNumber':'%@','InstructorTable':'%@','InstructorChair':'%@','studentTable':'%@','studentChair':'%@','comments':'%@'",self.model.returnName,[self.segmentedControll titleForSegmentAtIndex:segmentedControll.selectedSegmentIndex],self.titleField.text,self.authorField.text,self.instrTableLabel.text,self.instrChairLabel.text,self.studTableLabel.text,self.studChairLabel.text,self.commentsTF.text];
    
    NSString  * message=[[NSString alloc] initWithFormat:
                         @"You successfully reported for %@ %@",self.authorField.text,self.titleField.text];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirmation"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"%@",report);
    [self.model concatenateReport:report];

}
- (IBAction)segmentControllerPressed:(id)sender {
    if (self.segmentedControll.selectedSegmentIndex==0){
        
    } else if (self.segmentedControll.selectedSegmentIndex==1){
        
       
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
    
    self.model=[EFGlobalData shareModel];
    
    
	// Do any additional setup after loading the view.
    titleField.text = [self.currentRoom title];
    authorField.text = [self.currentRoom author];
    self.instrTableLabel.text=[self.currentRoom instrTable];
    self.stepInstTableValue.value=[self.currentRoom.instrTable doubleValue];
    self.instrChairLabel.text=[self.currentRoom instrChair];
    self.stepInstChairValue.value=[self.currentRoom.instrChair doubleValue];
    self.studTableLabel.text=[self.currentRoom strudentsTable];
    self.stepStudTableValue.value=[self.currentRoom.strudentsTable doubleValue];
    self.studChairLabel.text=[self.currentRoom strudentsChair];
    self.stepStudChairValue.value=[self.currentRoom.strudentsChair doubleValue];
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    dateField.text = [df stringFromDate:[self.currentRoom releaseDate]];
}

- (void)viewDidUnload
{
    [self setTitleField:nil];
    [self setAuthorField:nil];
    [self setDateField:nil];
    [self setEditButton:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)startEditing:(id)sender {
    titleField.enabled = YES;
    authorField.enabled = YES;
    dateField.enabled = YES;
    
    titleField.borderStyle = UITextBorderStyleRoundedRect;
    authorField.borderStyle = UITextBorderStyleRoundedRect;
    dateField.borderStyle = UITextBorderStyleRoundedRect;
    
    editButton.hidden = YES;
    doneButton.hidden = NO;
}
- (IBAction)doneEditing:(id)sender {
    titleField.enabled = NO;
    authorField.enabled = NO;
    dateField.enabled = NO;
    
    titleField.borderStyle = UITextBorderStyleNone;
    authorField.borderStyle = UITextBorderStyleNone;
    dateField.borderStyle = UITextBorderStyleNone;
    
    editButton.hidden = NO;
    doneButton.hidden = YES;
    
    _currentRoom.title = titleField.text;
    _currentRoom.author = authorField.text;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    _currentRoom.releaseDate = [df dateFromString:dateField.text];
    
    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    [myApp saveContext];
    
}
@end
