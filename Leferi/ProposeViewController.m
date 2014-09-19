//
//  ProposeViewController.m
//  Leferi
//
//  Created by Cheon Park on 2014. 8. 4..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import "ProposeViewController.h"

@interface ProposeViewController ()

@end

@implementation ProposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NavigationBar setting
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"proposeTitleBar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem customBackButtonWithImage:[UIImage imageNamed:@"backButton.png"] Target:self action:@selector(back:)]];
  
  
    //Contents Setting
    [self.imageView setImage:[UIImage imageNamed:@"proposeStory.png"]];
    [self.imageConstraintHeight setConstant:1648.5];   //Propose content - have to get height of image

    
    //NavigationBar Fade out
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    } [self.navigationController.navigationBar setTranslucent:NO];
    [self followScrollView:self.scrollView withDelay:65];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//

#pragma mark - NavigationBar Fade out - sub Function
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavBarAnimated:NO];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    /* Deleting */
    
    //[self performSegueWithIdentifier:@"enterMenu" sender:nil];
//        self.parentViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [[self parentViewController]dismissViewControllerAnimated:YES completion:^{}];

    
//    self.parentViewController.modalTransitionStyle = UIModalPresentationCustom;
//    
//    
//    [UIView animateWithDuration:0.7 animations:^{
//        [self.view setAlpha:0.0];
//        [self.navigationController.navigationBar setAlpha:0.0];
//            
//    } completion:^(BOOL finished){
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    [UIView animateWithDuration:0.7 animations:^{
//        [self.view setAlpha:1.0];
//        [self.navigationController.navigationBar setAlpha:1.0];
//        
//    } completion:nil];
//

//    self.parentViewController.view.alpha = 0.0;
//    
//    [UIView animateWithDuration:0.42
//                     animations:^{self.parentViewController.view.alpha  = 1.0;}];
    
//    [UIView animateWithDuration:1.4
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         NSLog(@"topAni");
//                         [self.navigationController.navigationBar setAlpha:0.0];
//                         //[destinationViewController.view setAlpha:1.0];
//                     }
//                     completion:^(BOOL finished){
//                         //[destinationViewController.view removeFromSuperview]; // remove from temp super view
//                         //[sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
//                     }];
//    
//    
//    [UIView animateWithDuration:1.4
//                          delay:0.42
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         NSLog(@"viewAni");
//                         //[sourceViewController.navigationController.navigationBar setAlpha:0.0];
//                         [destinationViewController.view setAlpha:1.0];
//                     }
//                     completion:^(BOOL finished){
//                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
//                         [self presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
//                     }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
