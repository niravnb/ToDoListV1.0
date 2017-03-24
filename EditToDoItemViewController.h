//
//  EditToDoItemViewController.h
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 21/11/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem+CoreDataProperties.h"

@interface EditToDoItemViewController : UIViewController <UITextFieldDelegate>

@property NSString *name;
@property NSDate *date;

@end
