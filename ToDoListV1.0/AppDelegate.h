//
//  AppDelegate.h
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "MyDataController.h"
#import "ToDoItem.h"
#import "ToDoItem+CoreDataProperties.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) MyDataController *dataController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

