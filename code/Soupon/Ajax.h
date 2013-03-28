//
//  Ajax.h
//  live
//
//  Created by xjj xjj on 11-7-28.
//  Copyright 2011 新境界. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIProgressBar.h"

@interface Ajax : NSObject {

}
@property(nonatomic,assign) id target;
@property(nonatomic)SEL didFinish;
@property(nonatomic,retain) NSMutableData *buf;
@property(nonatomic,retain) NSURLConnection *connection;
@property(nonatomic,assign) BOOL isAllValues;
@property(nonatomic,assign) NSString* valueForKey;
@property(nonatomic,assign) BOOL isText;
@property(nonatomic,assign) NSString *urlStr;
@property(nonatomic,retain) UIProgressBar *progressBar;
@property(nonatomic,assign) long contentLength;
@property(nonatomic,assign) BOOL showProgressBar;

-(void)start;
-(void)hiddenProgreesBar;

/*!
@method Ajax:target:didFinish:isAllValues:valueForKey:
@discussion 异步加载某个节点数据（JSON格式）
@param _urlStr 网络数据URL
@param _target 调用者
@param _didFinish 数据加载完毕后通知动作
@param _isAllValues 是否返回所有数据 NO or YES
@param _valueForKey 加载某个节点数据
@result 初始化Ajax实例，并异步执行
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish isAllValues:(BOOL)_isAllValues valueForKey:(NSString *)_valueForKey;

/*!
@method Ajax:target:didFinish:
@discussion 异步加数据（文件本格式）所有文本数据
@param _urlStr 网络数据URL
@param _target 调用者
@param _didFinish 数据加载完毕后通知动作
@result 初始化Ajax实例，并异步执行
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish;

/*!
@method Ajax:target:didFinish:isAllValues:valueForKey:showProgressBar:
@discussion 异步加载某个节点数据（JSON格式）
@param _urlStr 网络数据URL
@param _target 调用者
@param _didFinish 数据加载完毕后通知动作
@param _isAllValues 是否返回所有数据 NO or YES
@param _valueForKey 加载某个节点数据
@param _showProgressBar 是否显示进度条 NO or YES
@result 初始化Ajax实例，并异步执行
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish isAllValues:(BOOL)_isAllValues valueForKey:(NSString *)_valueForKey showProgressBar:(BOOL)_showProgressBar;

/*!
@method Ajax:target:didFinish:showProgressBar
@discussion 异步加数据（文件本格式）所有文本数据
@param _urlStr 网络数据URL
@param _target 调用者
@param _didFinish 数据加载完毕后通知动作
@param _showProgressBar 是否显示进度条 NO or YES
@result 初始化Ajax实例，并异步执行
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish showProgressBar:(BOOL)_showProgressBar;

@end

