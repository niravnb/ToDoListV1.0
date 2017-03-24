//
//  MyDataController.h
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 21/11/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MyDataController : NSObject

@property (strong) NSManagedObjectContext *managedObjectContext;

- (void)initializeCoreData;

@end

