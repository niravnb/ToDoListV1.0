//
//  ToDoListTableViewController.m
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "AddToDoItemViewController.h"
#import "EditToDoItemViewController.h"
#import "MyDataController.h"
#import "AppDelegate.h"





@interface ToDoListTableViewController ()

@property NSMutableArray *toDoItems;
//@property (readonly, strong, nonatomic) NSManagedObjectContext *moc;
@property ToDoItem *items;

@end

@implementation ToDoListTableViewController

//- (void)initializeFetchedResultsController
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
//    
//    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
//    
//    [request setSortDescriptors:@[lastNameSort]];
//    
//    NSManagedObjectContext *moc = …; //Retrieve the main queue NSManagedObjectContext
//    
//    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
//    [[self fetchedResultsController] setDelegate:self];
//    
//    NSError *error = nil;
//    if (![[self fetchedResultsController] performFetch:&error]) {
//        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
//}
//
//-(void)loadInitialData {
//    ToDoItem *item1 = [[ToDoItem alloc]init];
//    item1.itemName = @"Buy Milk";
//    [self.toDoItems addObject:item1];
//    
//    ToDoItem *item2 = [[ToDoItem alloc]init];
//    item2.itemName = @"Buy Laptop";
//    [self.toDoItems addObject:item2];
//    
//    ToDoItem *item3 = [[ToDoItem alloc]init];
//    item3.itemName = @"Buy iPhone";
//    [self.toDoItems addObject:item3];
//}


-(void)fetchdata {
    AppDelegate *appdel = [[UIApplication sharedApplication] delegate];
    
    
    NSManagedObjectContext *context = [appdel managedObjectContext];
    //    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    //
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ToDoItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.toDoItems = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:fetchRequest error:&error]];
    

}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleterow:) name:@"del" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(markascomplete:) name:@"com" object:nil];
    
    // [self useTouchId];
    [self fetchdata];
    [self.tableView reloadData];
    //self.view.hidden = YES;

    
    //NSError *error = nil;
    //self.toDoItems = [context executeFetchRequest:request error:&error];
//    if (!results) {
//        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
//
//    
//    self.item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:[self managedObjectContext]];
//    [self.item setValue:@"Buy Milk" forKey:@"itemName"];
//    [self.item setValue:NO forKey:@"completed"];
//    [self.item setValue:@"1/1/2011" forKey:@"creationDate"];
//
//    
//    NSError *error1 = nil;
//    if ([[self managedObjectContext] save:&error1] == NO) {
//        NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
//    }
    
    
    //NSLog(@"view did load");
    //self.toDoItems = [[NSMutableArray alloc] init];
    //[self loadInitialData];
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    self.toDoItems = [NSMutableArray arrayWithArray:[defaults objectForKey:@"todo"]];
//
//    
//    for (ToDoItem *obb in self.toDoItems) {
//        NSLog(@" todo %@  nnnnsnd",obb.itemName);
//    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



//-(void)viewWillDisappear:(BOOL)animated{
//    
//    NSLog(@"view will diapppear");
//    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    
//    NSArray *arr = [[NSArray alloc] initWithArray:self.toDoItems];
//    [arr mutableCopy];
//    
//    [def setObject:arr forKey:@"todo"];
//    [def synchronize];
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    //tappedItem.completed = !tappedItem.completed;
    
    AppDelegate *appdel = [[UIApplication sharedApplication] delegate];
    
    
    NSManagedObjectContext *context = [appdel managedObjectContext];
    //    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    //
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ToDoItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName == %@",tappedItem.itemName];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    ToDoItem *edit = [results objectAtIndex:0];

    
    if ([tappedItem.completed isEqualToString:@"NO"]) {
            [edit setValue:@"YES" forKey:@"completed"];
    }
    else if ([tappedItem.completed isEqualToString:@"YES"]){
        [edit setValue:@"NO" forKey:@"completed"];
    }
    
    // ToDoItem *edit = [context executeFetchRequest:fetchRequest error:&error];
    
    
    NSError *error1 = nil;
    if ([context save:&error1] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
    }

    // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] - 1];
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.toDoItems count];
}

-(IBAction)unwindToList:(UIStoryboardSegue *)segue {
    [self fetchdata];
    [self.tableView reloadData];
//    AddToDoItemViewController *source = [segue sourceViewController];
//    ToDoItem *item1 = source.toDoItemadd;
//    if (item1 != nil) {
//        
//                
//        [self.toDoItems addObject:item1];
//        
//        [self.tableView reloadData];
//    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"Edit"]) {
        UINavigationController *controller = segue.destinationViewController;
        EditToDoItemViewController *destination = [controller viewControllers][0];
        
        
        SWTableViewCell *cell = (SWTableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        //UITableView *table = (UITableView *)sender;
       // NSInteger selectedIndex = [[self.tableView ind]] row];
        
        ToDoItem *item = [self.toDoItems objectAtIndex:indexPath.row];
        
        
        destination.name = item.itemName;
        destination.date = item.creationDate;
        NSLog(@"item name = %@ and index is %ld",item.itemName,(long)indexPath.row);
       // NSLog(@"item name %@",self.item.itemName);
        //destination.editItem = self.item;
        //[destination setToDoItem:self.item];
      //  [destination setEditItem:item];
        
//        destination.toDoItem = [[ToDoItem alloc] init];
//        destination.toDoItem.itemName = [self.toDoItems objectAtIndex:indexPath.row];
//        destination.toDoItem.completed = NO;
        
    }
    
}

-(IBAction)editToList:(UIStoryboardSegue * )segue {
    NSLog(@"welocme to main");
    [self fetchdata];
    [self.tableView reloadData];
   // EditToDoItemViewController *source = [segue sourceViewController];
    //ToDoItem *item = source.toDoItem;
//    if (item != nil) {
//        
//        [self.toDoItems replaceObjectAtIndex: withObject::item];
//        
//        [self.tableView reloadData];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"ListPrototypeCell";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Add utility buttons
    //NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
//    [leftUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
//                                                icon:[UIImage imageNamed:@"like.png"]];
//    [leftUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
//                                                icon:[UIImage imageNamed:@"message.png"]];
//    [leftUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
//                                                icon:[UIImage imageNamed:@"facebook.png"]];
//    [leftUtilityButtons sw_addUtilityButtonWithColor:
//     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:0.7]
//                                                icon:[UIImage imageNamed:@"twitter.png"]];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"Edit"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
    //cell.leftUtilityButtons = leftUtilityButtons;
    cell.rightUtilityButtons = rightUtilityButtons;
    cell.delegate = self;
    
    
    
//    // Configure the cell...
//    cell.patternLabel.text = [patterns objectAtIndex:indexPath.row];
//    cell.patternImageView.image = [UIImage imageNamed:[patternImages objectAtIndex:indexPath.row]];
//    
//    return cell;
    
    
 //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    ToDoItem *toDoItemss = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItemss.itemName;
    
    if ([toDoItemss.completed isEqualToString:@"YES"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if ([toDoItemss.completed isEqualToString:@"NO"]){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}



//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return NO;
//}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self tableView:tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
//}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        
//        
////        NSLog(@"edit clicked");
////        
////        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry!" message:@"Edit functionality is not implemented yet." preferredStyle:UIAlertControllerStyleAlert];
//        
//        
////        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
////                                                              handler:^(UIAlertAction * action) { }];
////        
////        [alert addAction:defaultAction];
////        [self presentViewController:alert animated:YES completion:nil];
//        
//        
//    }];
//    editAction.backgroundColor = [UIColor blueColor];
//    
//    
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        
//        [self.toDoItems removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
//        
//    }];
//    deleteAction.backgroundColor = [UIColor redColor];
//    
//    return @[deleteAction,editAction];
//}

// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.toDoItems removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
//        // Delete the row from the data source
//        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    
//    switch (index) {
//        case 0:
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bookmark" message:@"Save to favorites successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
//            break;
//        }
//        case 1:
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email sent" message:@"Just sent the image to your INBOX" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
//            break;
//        }
//        case 2:
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Sharing" message:@"Just shared the pattern image on Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
//            break;
//        }
//        case 3:
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter Sharing" message:@"Just shared the pattern image on Twitter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alertView show];
//        }
//        default:
//            break;
//    }
//}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
       case 0:
        {
             //NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            NSLog(@"edit clicked");
            [self performSegueWithIdentifier:@"Edit" sender:cell];
//            // More button is pressed
//            UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share on Facebook", @"Share on Twitter", nil];
//            [shareActionSheet showInView:self.view];
//            
            [cell hideUtilityButtonsAnimated:YES];
            break;
       }
        case 1:
        {
            NSLog(@"delete clicked");
            // Delete button is pressed
            
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            ToDoItem *per = [self.toDoItems objectAtIndex:cellIndexPath.row];
            NSString *nam = per.itemName;
            
            AppDelegate *appdel = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = [appdel managedObjectContext];
            
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            fetchRequest.entity = [NSEntityDescription
                                   entityForName:@"ToDoItem" inManagedObjectContext:context];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"itemName == %@",nam];
            
            NSArray *delete = [context executeFetchRequest:fetchRequest error:nil];
            
            for (NSManagedObject *moc in delete) {
                [context deleteObject:moc];
            }
            
            NSError *error = nil;
            if (![context save:&error])
            {
                NSLog(@"Error deleting movie, %@", [error userInfo]);
            }
            
            
            NSArray *scheduledNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
            
            for (UILocalNotification *notification in scheduledNotifications)
            {
                //Get the ID you set when creating the notification
                NSDictionary *userInfo = notification.userInfo;
                NSString *nameofkey = [userInfo valueForKey:@"key"];
                
                
                
                if ([nameofkey isEqualToString:nam])
                {
                    [[UIApplication sharedApplication] cancelLocalNotification:notification];
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] - 1];
                    //Re-create the localnotification with new data and the someValueYouGaveWhenCreatingCouldBeAnIdentifierOfAnObject
                    NSLog(@"notification deleted");
                    
                  
                    
                    break;
                }
            }

            
//            [patterns removeObjectAtIndex:cellIndexPath.row];
//            [patternImages removeObjectAtIndex:cellIndexPath.row];
            [self.toDoItems removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView reloadData];
            //        // Delete the row from the data source
            //        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
        }
        default:
            break;
    }
}
//
//-(NSNotification *)demo {
//    NSLog(@"action clicked");
//}

-(void)markascomplete:(UILocalNotification *)notification {
    
    NSLog(@"in log compledr");
   // NSNotification *notification;

  //  NSDictionary *information =  notification.userInfo;
   // [noti.userInfo valueForKey:@"key"];
    //ToDoItem *tappedItem = [info objectForKey:@"key"];
    //tappedItem.completed = !tappedItem.completed;
    
    NSString *tapped = [notification.userInfo objectForKey:@"key"];

    //[information objectForKey:@"key"];
    //[info objectForKey:@"key"];
    
    AppDelegate *appdel = [[UIApplication sharedApplication] delegate];
    
    
    NSManagedObjectContext *context = [appdel managedObjectContext];
    //    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    //
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ToDoItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName = %@",tapped];
    [fetchRequest setPredicate:predicate];
    
   // NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:nil];
    
    ToDoItem *edit = [results objectAtIndex:0];
    
    
    if ([edit.completed isEqualToString:@"NO"]) {
        [edit setValue:@"YES" forKey:@"completed"];
    }
    else if ([edit.completed isEqualToString:@"YES"]){
        [edit setValue:@"NO" forKey:@"completed"];
    }

    
    NSError *error1 = nil;
    if ([context save:&error1] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
    }
    
   
    [self.tableView reloadData];
    
   // [self viewDidLoad];

    

    

}


-(void)deleterow:(UILocalNotification *)notification {
    
    
    NSString *nam = [notification.userInfo objectForKey:@"key"];
    
    AppDelegate *appdel = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdel managedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription
                           entityForName:@"ToDoItem" inManagedObjectContext:context];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"itemName = %@",nam];
    
    NSArray *delete = [context executeFetchRequest:fetchRequest error:nil];
    
    for (NSManagedObject *moc in delete) {
        [context deleteObject:moc];
    }
    
    NSError *error1 = nil;
    if ([context save:&error1] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
    }
    
    NSArray *scheduledNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notification in scheduledNotifications)
    {
        //Get the ID you set when creating the notification
        NSDictionary *userInfo = notification.userInfo;
        NSString *nameofkey = [userInfo valueForKey:@"key"];
        
        
        
        if ([nameofkey isEqualToString:nam])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
          //  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] - 1];
            //Re-create the localnotification with new data and the someValueYouGaveWhenCreatingCouldBeAnIdentifierOfAnObject
            NSLog(@"notification deleted");
            
            
            
            break;
        }
    }
    
    
    //            [patterns removeObjectAtIndex:cellIndexPath.row];
    //            [patternImages removeObjectAtIndex:cellIndexPath.row];
    [self viewDidLoad];
   
    
    //[self.toDoItems removeObject:delete];
    
   //  NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:index];
    // [self.tableView deleteRowsAtIndexPaths:cellIndexPath withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView reloadData];
    //        // Delete the row from the data source
    //        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    

    
}
@end
