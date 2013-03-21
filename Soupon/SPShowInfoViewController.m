//
//  SPShowInfoViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPShowInfoViewController.h"
#import "Status.h"
#import "SPCommon.h"
#import "SPAppDelegate.h"
#import <CoreData/CoreData.h>

@interface SPShowInfoViewController ()

@end

@implementation SPShowInfoViewController
@synthesize theImageView;
@synthesize lineDateLabel;
@synthesize cellectButton;
@synthesize captionLabel;
@synthesize contentTextView;

@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
	
		lineDateLabel.text = [dic objectForKey:@"indate"];
		contentTextView.text = [dic objectForKey:@"content"];
		captionLabel.text = [dic objectForKey:@"caption"];
	if (!dic ) {
	lineDateLabel.text = col.indate;
	contentTextView.text = col.discreption;
	captionLabel.text = col.caption;
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithRed:150.0f/255.0f green:200.0f/255.0f blue:100.0f/255.0f alpha:1.0]];
	
}

- (void)setAll:(NSString*)couponid{
	NSXMLParser *parser = [[NSXMLParser alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:couponid]]];
	[parser setDelegate:self];
	[parser parse];
}

- (void)setCollect:(Collect *)collect{
	col = collect;
	
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString*)qName attributes:(NSDictionary *)attributeDict{ 
	if (qName) { 
		elementName = qName; 
	} 
	if ([elementName isEqualToString:@"detail"]) { 
		dic = [[NSDictionary dictionaryWithDictionary:attributeDict]copy];
	}
} 

- (IBAction)shoucang:(id)sender{
	if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]isEqual:@""]) {
		
		NSString *modelPath  = [[NSBundle mainBundle]pathForResource:@"collectModel" ofType:@"momd"];
		NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
		managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
		
		NSURL *storeURL = nil;
		NSError *error = nil;

		persistentStoreCoordinator  =[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
		storeURL  =[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
		storeURL = [storeURL URLByAppendingPathComponent:@"collectModel.sqlite"];
		[persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
		managedObjectContext = [[NSManagedObjectContext alloc]init];
		NSManagedObjectContext *unused __attribute__((unused)) = managedObjectContext;
		[managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
		[managedObjectContext setMergePolicy:NSOverwriteMergePolicy];
		
		NSEntityDescription *description = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:managedObjectContext];
		Collect *obj = [[[Collect alloc]initWithEntity:description insertIntoManagedObjectContext:nil]autorelease];
		obj.caption  = [dic objectForKey:@"caption"];
		obj.discreption = [dic objectForKey:@"content"];
		obj.indate = [dic objectForKey:@"indate"];
		
		[managedObjectContext insertObject:obj];
		
		if ([managedObjectContext save:nil]) {
			NSLog(@"收藏成功！");
		}
		UIAlertView *a  = [[UIAlertView alloc]initWithTitle:@"收藏成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[a show];
		[a release];
	}
}

- (void)viewDidUnload
{
	[self setCaptionLabel:nil];
	[self setContentTextView:nil];
	[self setTheImageView:nil];
	[self setLineDateLabel:nil];
	[self setCellectButton:nil];
	[dic release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[captionLabel release];
	[contentTextView release];
	[theImageView release];
	[lineDateLabel release];
	[cellectButton release];
	[super dealloc];
}
@end
