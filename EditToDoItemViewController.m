//
//  EditToDoItemViewController.m
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 21/11/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import "EditToDoItemViewController.h"
#import "ToDoListTableViewController.h"
#import "AppDelegate.h"

@interface EditToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Save;
@property (weak, nonatomic) IBOutlet UITextField *EditTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation EditToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.EditTextField.text = self.name;
    [self.datePicker setDate:self.date];
    [self.EditTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self performSegueWithIdentifier:@"Editunwindd" sender:self];
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if (sender == self.cancel) return;
    
    if ([segue.identifier isEqualToString:@"Editunwindd"]) {
        
    
        
        NSArray *scheduledNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
        
        for (UILocalNotification *notification in scheduledNotifications)
        {
            //Get the ID you set when creating the notification
            NSDictionary *userInfo = notification.userInfo;
            NSString *nameofkey = [userInfo valueForKey:@"key"];
            
            
            
            if ([nameofkey isEqualToString:self.name])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] - 1];
                //Re-create the localnotification with n data and the someValueYouGaveWhenCreatingCouldBeAnIdentifierOfAnObject
                NSLog(@"notification deleted");
                break; 
                
            }
            
            
           
        }
        

    
    AppDelegate *appdel = [[UIApplication sharedApplication] delegate];
    
    
    NSManagedObjectContext *context = [appdel managedObjectContext];
    //    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    //
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"ToDoItem" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemName == %@",self.name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    ToDoItem *edit = [results objectAtIndex:0];
    
   // ToDoItem *edit = [context executeFetchRequest:fetchRequest error:&error];
    [edit setValue:self.EditTextField.text forKey:@"itemName"];
    [edit setValue:[self.datePicker date] forKey:@"creationDate"];
    
    NSError *error1 = nil;
    if ([context save:&error1] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
    }
        
        
        }
    
    NSDate *date = [self.datePicker date];
    
    UIApplication *app =[UIApplication sharedApplication];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    if (noti) {
        noti.fireDate = date;
        //  noti.timeZone = [NSTimeZone defaultTimeZone];
        noti.repeatInterval = 0;
        noti.category = @"ACTIONABLE";
        noti.alertBody = self.EditTextField.text;
        noti.soundName = UILocalNotificationDefaultSoundName;
       // noti.alertAction = @"View List";
       // noti.hasAction = YES;
        noti.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.EditTextField.text,@"key", nil];
       // noti.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber ]+ 1;
      //  NSInteger iconn = [[UIApplication sharedApplication] applicationIconBadgeNumber];
        //iconn = iconn + 1;
        
       //[noti setApplicationIconBadgeNumber:[noti applicationIconBadgeNumber] + 1]; //Set the Application Icon Badge Number of
       // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1];
        [app scheduleLocalNotification:noti];
//        UIApplication *app =[UIApplication sharedApplication];
//        UILocalNotification *noti = [[UILocalNotification alloc] init];
//        if (noti) {
//            noti.fireDate = date;
//            noti.timeZone = [NSTimeZone defaultTimeZone];
//            noti.repeatInterval = 0;
//            noti.alertBody = self.textField.text;
//            [app scheduleLocalNotification:noti];
//        }
        
        
    }
//
//    //ToDoListTableViewController *source = [segue sourceViewController];
//    self.editItem = [[ToDoItem alloc] init];
//    //self.editItem = source.item;
//    NSLog(@"Hi nirav %@",self.editItem.itemName);
//    
//    [self.EditTextField setText:self.editItem.itemName];
//    //self.EditTextField.text =
    
    
//    if (self.EditTextField.text.length > 0) {
//        self.toDoItem = [[ToDoItem alloc] init];
//        
//        self.toDoItem.completed = NO;
//    }
}

@end
