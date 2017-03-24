//
//  ToDoListTableViewController.h
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ToDoItem+CoreDataProperties.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ToDoListTableViewController : UITableViewController <SWTableViewCellDelegate, UITableViewDataSource, UITableViewDelegate>




-(IBAction)unwindToList:(UIStoryboardSegue *)segue;
-(IBAction)editToList:(UIStoryboardSegue * )segue;
@end
