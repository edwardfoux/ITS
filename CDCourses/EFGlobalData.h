//
//  EFGlobalData.h
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFGlobalData : NSObject

+(instancetype)shareModel;
-(void) concatenateReport:(NSString*)newReport;
-(NSString *)returnReport;
-(NSString *)returnName;
-(void) setName:(NSString *)userName;


@property(strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong,nonatomic) NSString * report;
@property (strong,nonatomic) NSString * userName;

@end
