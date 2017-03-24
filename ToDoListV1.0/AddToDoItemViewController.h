//
//  AddToDoItemViewController.h
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem+CoreDataProperties.h"

@interface AddToDoItemViewController : UIViewController <UITextFieldDelegate>

@property ToDoItem *toDoItemadd;

@end
