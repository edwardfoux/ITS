//
//  EFHomeScreenController.m
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import "EFHomeScreenController.h"

@interface EFHomeScreenController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@end

@implementation EFHomeScreenController
- (IBAction)textExit:(id)sender {
    [sender resignFirstResponder];
    
    if  ( ([self.userNameTF.text isEqualToString:@""])||(self.userNameTF.text==nil)){
        NSLog(@"enter your name");
    }
    else{
        [self.model setName:self.userNameTF.text];
        NSLog(@"entered name %@",self.userNameTF.text);
        [self performSegueWithIdentifier:@"homeSegueIdentifier" sender:sender];
    }

    
    
}

- (IBAction)enterButtonPressed:(id)sender {
    
    if  ( ([self.userNameTF.text isEqualToString:@""])||(self.userNameTF.text==nil)){
        NSLog(@"enter your name");
        
        NSString  * message=[[NSString alloc] initWithFormat:
                             @"Please enter your name!"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing name"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else{
        [self.model setName:self.userNameTF.text];
        NSLog(@"entered name %@",self.userNameTF.text);
        [self performSegueWithIdentifier:@"homeSegueIdentifier" sender:sender];
        
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
	// Do any additional setup after loading the view.
    
    self.model=[EFGlobalData shareModel];
    
    if ([[self.model returnName] length]!=0){
        self.userNameTF.text=self.model.returnName;
        NSLog(@"have name");
    }else{
        NSLog(@"no name");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
