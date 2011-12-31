//
//  DowloadViewController.m
//  Yanganese
//
//  Created by Michael Yang on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DownloadViewController.h"
#import "CustomQuizCell.h"
#import "Reachability.h"

@implementation DownloadViewController

@synthesize internetActive;
@synthesize hostActive;
@synthesize oldPath;
@synthesize queue;

- (void)loadData {
	
	// check if a pathway to a random host exists
	hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReachable startNotifier];
	
	NSURL *url = [NSURL URLWithString:@"http://cypressmao.com/science/downloads.plist"];
	NSDictionary *dl = [[NSDictionary alloc] initWithContentsOfURL:url];
	self.allQuizzes = dl;
	
	UIActivityIndicatorView *wheel = (UIActivityIndicatorView *) self.navigationItem.rightBarButtonItem.customView;
	[wheel stopAnimating];
	
	if(dl == nil) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Loading" message:@"There was an error in loading the quiz list." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
		[alert release];
	}
	
	[super resetSearch];
	[super.tableView reloadData];
	
	start++;
	
	[dl release];
}

- (void)checkNetworkStatus:(NSNotification *)notice {
	// called after network status changes
	
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	switch (internetStatus)
	
	{
		case NotReachable:
		{
			
			self.internetActive = NO;
			break;
			
			
		}
		case ReachableViaWiFi:
		{
			self.internetActive = YES;
			
			break;
			
		}
		case ReachableViaWWAN:
		{
			self.internetActive = YES;
			
			break;
			
		}
	}
	
	NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
	switch (hostStatus)
	
	{
		case NotReachable:
		{
			self.hostActive = NO;
			
			break;
			
		}
		case ReachableViaWiFi:
		{
			self.hostActive = YES;
			
			break;
			
		}
		case ReachableViaWWAN:
		{
			self.hostActive = YES;
			
			break;
			
		}
	}
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewWillAppear:(BOOL)animated {
	if (start != 0) {
		NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
		[queue addOperation:operation];
		[operation release];
		
		UIActivityIndicatorView *wheel = (UIActivityIndicatorView *) self.navigationItem.rightBarButtonItem.customView;
		[wheel startAnimating];
	}
	
	[super viewWillAppear:animated];
}

- (void)viewDidLoad {
	
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
	[self navigationItem].rightBarButtonItem = barButton;
    [activityIndicator startAnimating];
		
	// check for internet connection
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
	
	internetReachable = [[Reachability reachabilityForInternetConnection] retain];
	[internetReachable startNotifier];
	
	// check if a pathway to a random host exists
	hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReachable startNotifier];
	
	// now patiently wait for the notification
	
    NSOperationQueue *new = [NSOperationQueue new];
	self.queue = new;
	
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadData) object:nil];
	[queue addOperation:operation];
    [operation release];

	start = 0;
	
	[super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self];	
		
	[super viewWillDisappear:animated];
}

- (void)viewDidUnload {	
	self.oldPath = nil;
	self.queue = nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[oldPath release];
	[queue release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if(!self.internetActive) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Loading" message:@"There was an error in loading the quiz." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
		[alert release];
	
		return;
	}
	
	UIActivityIndicatorView *wheel = (UIActivityIndicatorView *) self.navigationItem.rightBarButtonItem.customView;
	[wheel startAnimating];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [paths objectAtIndex:0];
	NSString *filePathString = [path stringByAppendingPathComponent:@"questions.plist"];

	self.filePath = filePathString;
	
	NSString *url = [[NSString alloc] initWithFormat:@"http://mikkyang.com/yanganese/%@.plist", [quizTitleList objectAtIndex:[indexPath row]]];	
	NSDictionary *newQuiz = [[NSDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
	
	NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	if(data == nil) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"source" ofType:@"plist"];
		data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	}
	
	[data setObject:newQuiz forKey:[quizTitleList objectAtIndex:[indexPath row]]];
	
	[data writeToFile:filePath atomically:YES];
	
	[data release];
	[url release];
	[newQuiz release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[wheel performSelector:@selector(stopAnimating) withObject:nil afterDelay:0.5];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Download Finished" message:@"The quiz is now available in the selection menu." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
