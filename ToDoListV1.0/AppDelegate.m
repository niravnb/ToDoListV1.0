//
//  AppDelegate.m
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import "AppDelegate.h"
#import "ToDoItem.h"

@interface AppDelegate ()
@property NSString *name;
@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setDataController:[[MyDataController alloc] init]];
    
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    NSString * const NotificationCategoryIdent  = @"ACTIONABLE";
   // NSString * const NotificationActionOneIdent = @"ACTION_ONE";
    //NSString * const NotificationActionTwoIdent = @"ACTION_TWO";
    
    UIMutableUserNotificationAction *action1;
    action1 = [[UIMutableUserNotificationAction alloc] init];
    [action1 setActivationMode:UIUserNotificationActivationModeBackground];
    [action1 setTitle:@"Delete"];
    [action1 setIdentifier:@"Delete"];
    [action1 setDestructive:YES];
    [action1 setAuthenticationRequired:YES];
    
    UIMutableUserNotificationAction *action2;
    action2 = [[UIMutableUserNotificationAction alloc] init];
    [action2 setActivationMode:UIUserNotificationActivationModeBackground];
    [action2 setTitle:@"Mark as Complete"];
    [action2 setIdentifier:@"Mark as Complete"];
    [action2 setDestructive:NO];
    [action2 setAuthenticationRequired:NO];
    
    UIMutableUserNotificationCategory *actionCategory;
    actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    [actionCategory setIdentifier:NotificationCategoryIdent];
    [actionCategory setActions:@[action1, action2]
                    forContext:UIUserNotificationActionContextMinimal];
    
    NSSet *categories = [NSSet setWithObject:actionCategory];
    UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                    UIUserNotificationTypeSound|
                                    UIUserNotificationTypeBadge);
    
    UIUserNotificationSettings *settings;
    settings = [UIUserNotificationSettings settingsForTypes:types
                                                 categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
//    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];

    
    //NSManagedObjectContext *context = [self managedObjectContext];
    
    
    //ToDoItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoItem" inManagedObjectContext:context];
//    [item setValue:@"Buy Milk" forKey:@"itemName"];
//    [item setValue:@"NO" forKey:@"completed"];
//    [item setValue:@"1/1/2011" forKey:@"creationDate"];
    
    
//    NSError *error1 = nil;
//    if ([context save:&error1] == NO) {
//        NSAssert(NO, @"Error saving context: %@\n%@", [error1 localizedDescription], [error1 userInfo]);
//    }

//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
//    
//    NSError *error = nil;
//    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
//    if (!results) {
//        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
//
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //[viewController alertNotification] setHidden:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  //  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
   // [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];

    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
               /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler  {
    
   // UILocalNotification *notification;
    //NSString *NotificationValue = [notification.userInfo objectForKey:@"key"];
//    for (UILocalNotification *not in userInfo) {
//        self.name = [not.userInfo objectForKey:@"key"];
//    }
    
    
    if ([identifier isEqualToString:@"Delete"]) {
        
//        NSInteger icon = [[UIApplication sharedApplication] applicationIconBadgeNumber];
//        icon = icon - 1;
//       
//        [notification setApplicationIconBadgeNumber: [notification applicationIconBadgeNumber] - 1];
      // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] - 1];
       // application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber - 1;
        
        
          // notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber ] - 1;
        NSString *titles = [notification.userInfo objectForKey:@"key"];
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:titles,@"key", nil];

        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"del" object:nil userInfo:dic];
        NSLog(@"You chose Delete");
    }
    else if ([identifier isEqualToString:@"Mark as Complete"]) {
        
//        NSInteger icon = [[UIApplication sharedApplication] applicationIconBadgeNumber];
//        icon = icon - 1;
//        
//         [notification setApplicationIconBadgeNumber: [notification applicationIconBadgeNumber] - 1];
       // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
         //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] - 1];
        
      //  application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber - 1;
        
        
        
     //   notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber ] - 1;
        
        NSString *titless = [notification.userInfo objectForKey:@"key"];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:titless,@"key", nil];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"com" object:nil userInfo:dict];
        NSLog(@"You chose Mark as complete");
    }
    if (completionHandler) {
        
        completionHandler();
    }
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    
//    //----- GET THE LOCAL NOTIFICATION INFORMATION IF WE HAVE BEEN RUN FROM THE USER PRESSING THE ACTION BUTTON OF ONE OF OUR NOTIFICATIONS -----
//    self.name = [notification.userInfo objectForKey:@"key"];        //objectForKey:TheKeyNameYouUsed
//    
//    NSLog(@"LOCAL NOTIFICATION RECEVIED, value: %@", self.name);
//    
//    if (self.name)
//    {
//        //----- VIEW NOTIFICATION -----
//        UIApplicationState state = [application applicationState];
//        if (state == UIApplicationStateInactive)
//        {
//            //----- APPLICATION WAS IN BACKGROUND - USER HAS SEEN NOTIFICATION AND PRESSED THE ACTION BUTTON -----
//            NSLog(@"Local noticiation - App was in background and user pressed action button");
//            
//        }
//        else
//        {
//            //----- APPLICATION IS IN FOREGROUND - USER HAS NOT BEEN PRESENTED WITH THE NOTIFICATION -----
//            NSLog(@"Local noticiation - App was in foreground");
//            
//        }
//    }
//}

@end
