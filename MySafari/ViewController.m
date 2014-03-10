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
    
    __weak IBOutlet UIActivityIndicatorView *spinner;
}

@property (nonatomic) float lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    myWebView.scrollView.delegate = self;
    
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
- (IBAction)onTeaserButtonPressed:(id)sender {
    
    UIAlertView *teaser = [[UIAlertView alloc] initWithTitle:@"Coming soon" message:nil delegate:nil cancelButtonTitle:@"That sucks" otherButtonTitles:@"Fine", nil];
    [teaser show];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"x =%f and y = %f", scrollView.contentOffset.x, scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y > self.lastContentOffset){
        // move down
        myURLTextField.alpha = 0;
    } else {
        // move up
        myURLTextField.alpha = 1;
    }
    
    
    self.lastContentOffset = scrollView.contentOffset.y;
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSURL *url = [myWebView.request URL];
    myURLTextField.text =   [url absoluteString];
    [spinner startAnimating];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = theTitle;
    [spinner stopAnimating];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSRange currentRange = [textField.text rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
    
    id url = currentRange.location == NSNotFound ? [@"http://" stringByAppendingString:textField.text]:textField.text;
    
   id rq = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [myWebView loadRequest:rq];
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
