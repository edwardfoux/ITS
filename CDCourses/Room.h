//
//  Room.h
//  Final Project
//
//  Created by ITP Student on 12/1/13.
//  Copyright (c) 2013 ITP Student Edward Fuks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * instrTable;
@property (nonatomic, retain) NSString * instrChair;
@property (nonatomic, retain) NSString * strudentsChair;
@property (nonatomic, retain) NSString * strudentsTable;
@property (nonatomic, retain) NSString * comments;

@end
