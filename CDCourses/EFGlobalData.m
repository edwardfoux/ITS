//
//  EFGlobalData.m
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import "EFGlobalData.h"

@implementation EFGlobalData

+(instancetype)shareModel{

    
    
    static EFGlobalData *_sharedModel=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel=[[self alloc]init];
    });
    return _sharedModel;
}

-(void)concatenateReport:(NSString *)newReport{
    
    if (self.report==nil){
          NSLog(@"Initialized the report the very first time");
        self.report = [NSString stringWithFormat:@""];
    }
    
    self.report = [NSString stringWithFormat:@"%@%@", self.report, newReport];
    
}

-(NSString *)returnReport{
    return _report;
}

-(NSString *)returnName{
    NSLog(@"%@",self.userName);
    return self.userName;
}
-(void) setName:(NSString *)enteredName{
    self.userName=[NSString stringWithFormat:@"%@",enteredName];
    
}

@end
