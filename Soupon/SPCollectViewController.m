//
//  SPCollectViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPCollectViewController.h"
#import "Collect.h"
#import <CoreData/CoreData.h>

@interface SPCollectViewController ()

@end

@implementation SPCollectViewController
@synthesize tabel ,dataSource = dataSource_,managedObjectContext = managedObjectContext_,managedObjectModel = managedObjectModel_,persistentStoreCoordinator = persistentStoreCoordinator_;
//#ifdef _FOR_DEBUG_  
//-(BOOL) respondsToSelector:(SEL)aSelector {  
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
//    return [super respondsToSelector:aSelector];  
//}  
//#endif
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *modelPath  = [[NSBundle mainBundle]pathForResource:@"collectModel" ofType:@"momd"];
	NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
	managedObjectModel_ = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
	
    NSURL *storeURL = nil;
	NSError *error = nil;
	tabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStylePlain];
	tabel.delegate = self;
	tabel.dataSource  =self;
	[self.view addSubview:tabel];
	persistentStoreCoordinator_  =[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel_];
	storeURL  =[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
	storeURL = [storeURL URLByAppendingPathComponent:@"collectModel.sqlite"];
	[persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
	managedObjectContext_  = [[NSManagedObjectContext alloc]init];
	NSManagedObjectContext *unused __attribute__((unused)) = managedObjectContext_;
	[managedObjectContext_ setPersistentStoreCoordinator:persistentStoreCoordinator_];
	[managedObjectContext_ setMergePolicy:NSOverwriteMergePolicy];
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
	self.dataSource = array;
	[self searchData];
}

//- (void)addData:(NSString*)captions discreption:(NSString *)dis indate:(NSString *)indate{
//	NSEntityDescription *description = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:managedObjectContext_];
//	Collect *obj = [[[Collect alloc]initWithEntity:description insertIntoManagedObjectContext:nil]autorelease];
//	obj.caption  = captions;
//	obj.discreption = dis;
//	obj.indate = indate;
//	
//	[managedObjectContext_ insertObject:obj];
//	
//	if ([managedObjectContext_ save:nil]) {
//		NSLog(@"sssss");
//	}
//}

- (void)searchData{
	[dataSource_ removeAllObjects];
	NSError *error =nil;
//	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
//	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Collect" inManagedObjectContext:managedObjectContext_]];
//	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(caption == %@)",@"扶阳堂养生连锁",@"(caption == %@)",@"小肥羊美味优惠"];
//	[fetchRequest setPredicate:predicate];
//	
//	NSArray *array = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
//	coun = [array count];
//	aaa = array;
	
	
	NSFetchRequest *request=[[NSFetchRequest alloc] init]; 
	NSEntityDescription *entity=[NSEntityDescription entityForName:@"Collect" inManagedObjectContext:managedObjectContext_]; 
	[request setEntity:entity];
	NSArray *array=[[[self managedObjectContext] executeFetchRequest:request error:&error] copy];
	[dataSource_ addObjectsFromArray:array];
	[self.tabel reloadData];
}

- (void)deleteCollect:(id)sender{
	NSError *error = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Collect" inManagedObjectContext:managedObjectContext_]];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(dicreption ==%@)",@"RealTool"];
	[fetchRequest setPredicate:predicate];
	NSArray *array  = [managedObjectContext_ executeFetchRequest:fetchRequest error:&error];
	for (Collect *collect in array) {
		[managedObjectContext_ delete:collect];
	}
	[managedObjectContext_ save:nil];
	[self.tabel reloadData];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (dataSource_!=nil) {
		return [dataSource_ count];
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger r = [indexPath row];
	Collect *collect = (Collect*)[dataSource_ objectAtIndex:r];
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Collect"];
	if (cell == nil) {
		cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Collect"];
	}
	cell.textLabel.text = collect.caption;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSInteger r = [indexPath row];
	Collect *collect = (Collect*)[dataSource_ objectAtIndex:r];
	SPShowInfoViewController *viewCon = [[SPShowInfoViewController alloc]init];
	[viewCon setCollect:collect];
	[self.navigationController pushViewController:viewCon animated:YES];
	[viewCon release];
}
@end
