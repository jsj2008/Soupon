//
//  Ajax.m
//  live
//
//  Created by xjj xjj on 11-7-28.
//  Copyright 2011 新境界. All rights reserved.
//

#import "Ajax.h"
#import "UIProgressBar.h"

@implementation Ajax
@synthesize target,didFinish;
@synthesize buf;
@synthesize connection;
@synthesize isAllValues,valueForKey;
@synthesize isText;
@synthesize urlStr;
@synthesize progressBar;
@synthesize contentLength;
@synthesize showProgressBar;

-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish showProgressBar:(BOOL)_showProgressBar{
	if(self){
		self.showProgressBar = _showProgressBar;
		self.urlStr = _urlStr;
		self.isText = YES;
		self.target = _target;
		self.didFinish = _didFinish;
		[self start];
	}
	return self;
}
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish{
	/*self = [super init];
	if(self){
		self.showProgressBar = YES;
		self.urlStr = _urlStr;
		self.isText = YES;
		self.target = _target;
		self.didFinish = _didFinish;
		[self start];
	}
	return self;*/
	return [self Ajax:_urlStr target:_target didFinish:_didFinish showProgressBar:YES];
}

-(id) Ajax:(NSString *)_urlStr target:(id)_target didFinish:(SEL)_didFinish isAllValues:(BOOL)_isAllValues valueForKey:(NSString *)_valueForKey showProgressBar:(BOOL)_showProgressBar{
	self = [super init];
	if(self){
		self.showProgressBar = _showProgressBar;
		self.urlStr = _urlStr;
		self.isAllValues = _isAllValues;
		self.valueForKey = _valueForKey;
		self.target = _target;
		self.didFinish = _didFinish;
		[self start];
	}
	return self;
}

-(id) Ajax:(NSString *)_urlStr target:(id)_target didFinish:(SEL)_didFinish isAllValues:(BOOL)_isAllValues valueForKey:(NSString *)_valueForKey{
	return [self Ajax:_urlStr target:_target didFinish:_didFinish isAllValues:_isAllValues valueForKey:_valueForKey showProgressBar:YES];
}

-(void)start{
	if(connection==nil){
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		buf = [[NSMutableData alloc] initWithLength:0];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
		[request setURL:[NSURL URLWithString:urlStr]];
		[request setHTTPMethod:@"GET"];
		connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
		
		if([target isKindOfClass:[UIViewController class]]==YES&&showProgressBar==YES){
			UIViewController *viewController = (UIViewController*)target;
			progressBar = [[UIProgressBar alloc] initWithFrame:CGRectMake(0, viewController.view.frame.size.height - 10,viewController.view.frame.size.width, 10)];
			progressBar.minValue = 0;
			
			[progressBar setLineColor:[UIColor blackColor]];
			[progressBar setProgressColor:[UIColor redColor]];	
			//[progressBar setProgressColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"3.png"]]];	
			[progressBar setProgressRemainingColor:[UIColor greenColor]];
			[viewController.view addSubview:progressBar];	
		}
		[request release];
	}
}
//收到响应时
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	if(progressBar!=nil)
		progressBar.maxValue = response.expectedContentLength;
}
//接收数据
-(void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data{
	[buf appendData:data];
	if(progressBar!=nil)
		progressBar.currentValue += [data length];
}
//加载失败
-(void)connection:(NSURLConnection*)aConn didFailWithError:(NSError*)error{
	NSLog(@"didFailWithError:%@",error);
	[self hiddenProgreesBar];
}
//接收完毕
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	if(didFinish!=nil){
		if(isText)
			[target performSelector:didFinish withObject:buf];
//		else{
//			NSArray *data = [JSONParser parseJSON:buf isAllValues:isAllValues valueForKey:valueForKey];
//			[target performSelector:didFinish withObject:data];
//		}
	}
	[self hiddenProgreesBar];
}
-(void) hiddenProgreesBar{
	if(progressBar!=nil){
	//淡淡消失效果
		[UIView animateWithDuration:2
					 animations:^{
						 progressBar.alpha = 0;
					 }];
		[progressBar performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)dealloc{
	[connection release];
	[buf release];
	[progressBar release];
	[super dealloc];
}
@end
