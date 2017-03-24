//
//  ViewController.m
//  ToDoListV1.0
//
//  Created by Nirav Bhavsar on 11/10/15.
//  Copyright © 2015 Nirav Bhavsar. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self useTouchId];
     
                          

}
- (IBAction)login:(id)sender {
    [self useTouchId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)signoff:(UIStoryboardSegue *)segue{
    
}


-(void)useTouchId {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // Authenticate User
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Use your Touch ID to Login or Press Cancel to Enter Password"
                          reply:^(BOOL success, NSError *error) {
                              
                              
                              
                              if (error.code == LAErrorUserCancel || error.code == LAErrorUserFallback ) {
                                  
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login" message:@"Enter your Password" preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  
                                  UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                      UITextField *text = alert.textFields.firstObject;
                                      
                                      if ([text.text isEqualToString:@"nirav"]) {
                                          [self performSegueWithIdentifier:@"open" sender:self];
                                          
                                      }
                                      else {
                                          UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Password does not match." preferredStyle:UIAlertControllerStyleAlert];
                                          
                                          UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                          
                                          [alert addAction:cancelAction];
                                          [self presentViewController:alert animated:YES completion:nil];

                                      }
                                      
                                  }];
                                  
                                  [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                                      textField.secureTextEntry = YES;
                                  }];
                                  
                                  
                                  [alert addAction:saveAction];
                                  [self presentViewController:alert animated:YES completion:nil];
                              }
                              else if (error) {
                                  
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Your Touch ID is not recognised." preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                  
                                  [alert addAction:cancelAction];
                                  [self presentViewController:alert animated:YES completion:nil];
                                  
                                  return;
                              }
                              
                              
                              if (success) {
                                  
                                  [self performSegueWithIdentifier:@"open" sender:self];
                                  
                                  //                                      UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"You are the device owner!" preferredStyle:UIAlertControllerStyleAlert];
                                  //
                                  //                                      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                  //
                                  //                                      [alert addAction:cancelAction];
                                  //                                      [self presentViewController:alert animated:YES completion:nil];
                                  
                                  
                                  
                              } else {
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"You are not the device owner!" preferredStyle:UIAlertControllerStyleAlert];
                                  
                                  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
                                  
                                  [alert addAction:cancelAction];
                                  [self presentViewController:alert animated:YES completion:nil];                                  }
                              
                          }];
        
        
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Your device cannot authenticate using TouchID." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    // self.view.hidden = NO;
    //[self fetchdata];
    
}






@end
