//
//  ACViewController.m
//  BlockBasedAlertView
//
//  Created by Alessandro Calzavara on 22/11/12.
//  Copyright (c) 2012 Alessandro Calzavara. All rights reserved.
//

#import "ACViewController.h"
#import "BBAlertView.h"

@interface ACViewController ()

@end

@implementation ACViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User actions

- (IBAction)demoAlertView:(id)sender
{
    // create a new alert view
    BBAlertView * alerView = [BBAlertView alertWithTitle:@"Title goes here" message:@"and message here"];
    
    // setup cancel button
    [alerView setCancelButtonWithTitle:@"Cancel" onTapDo:^{
        
        NSLog(@"Cancel button was tapped");
        
    }];
    
    // setup other buttons
    [alerView addButtonWithTitle:@"Button 1" onTapDo:^{
        
        NSLog(@"Button 1 was tapped");
        
    }];

    [alerView addButtonWithTitle:@"Button 2" onTapDo:^{
        
        NSLog(@"Button 2 was tapped");
        
    }];

    // show it
    [alerView show];
}


@end
