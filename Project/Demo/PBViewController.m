//
//  PBViewController.m
//  Demo
//
//  Created by Piotr Bernad on 11.12.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import "PBViewController.h"
#import <PBACTextField.h>

@interface PBViewController ()
@property (strong, nonatomic) IBOutlet PBACTextField *storyboardTextField;

@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_storyboardTextField setAutoCompleteValues:[[self exampleAutocompleteStrings] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    [_storyboardTextField setAutoCompleteEnabled:YES];
}

- (NSArray *)exampleAutocompleteStrings {
    return @[@"Poland",@"Germany", @"Turkey", @"Afganistan", @"Peru", @"Boliwia", @"Moldawia", @"Mongolia", @"France", @"Italy"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
