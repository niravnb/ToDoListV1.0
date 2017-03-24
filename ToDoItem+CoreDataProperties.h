//
//  ToDoItem+CoreDataProperties.h
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 21/11/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *itemName;
@property (nullable, nonatomic) NSString *completed;
@property (nullable, nonatomic, retain) NSDate *creationDate;

@end

NS_ASSUME_NONNULL_END
