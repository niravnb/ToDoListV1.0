//
//  AddToDoItemViewController.m
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import "AddToDoItemViewController.h"
#import "AppDelegate.h"

@interface AddToDoItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.textField becomeFirstResponder];
    
 
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
    [self performSegueWithIdentifier:@"Addunwindl" sender:self.saveButton];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender == self.cancelButton) return;
    
    if ([segue.identifier isEqualToString:@"Addunwindl"]) {
        
    
    if (self.textField.text.length > 0) {
        
        NSDate *date = [self.datePicker date];
       
        UIApplication *app =[UIApplication sharedApplication];
        UILocalNotification *noti = [[UILocalNotification alloc] init];
        if (noti) {
            noti.fireDate = date;
          //  noti.timeZone = [NSTimeZone systemTimeZone];
            noti.repeatInterval = 0;
            noti.category = @"ACTIONABLE";
            noti.alertBody = self.textField.text;
            noti.soundName = UILocalNotificationDefaultSoundName;
           // noti.alertAction = @"View List";
           // noti.hasAction = YES;
            noti.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.textField.text,@"key", nil];
          //  noti.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber ] + 1;
         //   NSInteger icon = [[UIApplication sharedApplication] applicationIconBadgeNumber];
          //  icon = icon + 1;
         //  [noti setApplicationIconBadgeNumber:[noti applicationIconBadgeNumber] + 1]; //Set the Application Icon Badge Number of the application's icon to the current Application Icon Badge Number plus 1
         //   [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1];
            [app scheduleLocalNotification:noti];
        }
        
        AppDelegate *appdell = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *contextt = [appdell managedObjectContext];
        ToDoItem *personn;
        personn = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:contextt];
        [personn setValue:self.textField.text forKey:@"itemName"];
        [personn setValue:@"NO"forKey:@"completed"];
        [personn setValue:date forKey:@"creationDate"];
        
        NSError *error1 = nil;
        if ([contextt save:&error1] == NO) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
        }
        
    }
        
      //  self.toDoItemadd = [[ToDoItem alloc] init];
        //self.toDoItemadd.itemName = self.textField.text;
        //self.toDoItemadd.completed = @"NO";
        //self.toDoItemadd.creationDate = @"1/1/2015";
    }
}


@end
