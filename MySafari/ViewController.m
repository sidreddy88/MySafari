//
//  ViewController.m
//  MySafari
//
//  Created by Matthew Voracek on 1/9/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
    __weak IBOutlet UIWebView *myWebView;
    __weak IBOutlet UITextField *myURLTextField;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onBackButtonPressed:(id)sender {
    [myWebView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    [myWebView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [myWebView stopLoading];
    
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [myWebView reload];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    textField.text = myURLTextField.text;
    
    NSURLRequest *rq = [NSURLRequest requestWithURL:[NSURL URLWithString:textField.text]];
    [myWebView loadRequest:rq];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
