//
//  Ajax.h
//  live
//
//  Created by xjj xjj on 11-7-28.
//  Copyright 2011 �¾���. All rights reserved.
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
@discussion �첽����ĳ���ڵ����ݣ�JSON��ʽ��
@param _urlStr ��������URL
@param _target ������
@param _didFinish ���ݼ�����Ϻ�֪ͨ����
@param _isAllValues �Ƿ񷵻��������� NO or YES
@param _valueForKey ����ĳ���ڵ�����
@result ��ʼ��Ajaxʵ�������첽ִ��
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish isAllValues:(BOOL)_isAllValues valueForKey:(NSString *)_valueForKey;

/*!
@method Ajax:target:didFinish:
@discussion �첽�����ݣ��ļ�����ʽ�������ı�����
@param _urlStr ��������URL
@param _target ������
@param _didFinish ���ݼ�����Ϻ�֪ͨ����
@result ��ʼ��Ajaxʵ�������첽ִ��
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish;

/*!
@method Ajax:target:didFinish:isAllValues:valueForKey:showProgressBar:
@discussion �첽����ĳ���ڵ����ݣ�JSON��ʽ��
@param _urlStr ��������URL
@param _target ������
@param _didFinish ���ݼ�����Ϻ�֪ͨ����
@param _isAllValues �Ƿ񷵻��������� NO or YES
@param _valueForKey ����ĳ���ڵ�����
@param _showProgressBar �Ƿ���ʾ������ NO or YES
@result ��ʼ��Ajaxʵ�������첽ִ��
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish isAllValues:(BOOL)_isAllValues valueForKey:(NSString *)_valueForKey showProgressBar:(BOOL)_showProgressBar;

/*!
@method Ajax:target:didFinish:showProgressBar
@discussion �첽�����ݣ��ļ�����ʽ�������ı�����
@param _urlStr ��������URL
@param _target ������
@param _didFinish ���ݼ�����Ϻ�֪ͨ����
@param _showProgressBar �Ƿ���ʾ������ NO or YES
@result ��ʼ��Ajaxʵ�������첽ִ��
*/
-(id) Ajax:(NSString*)_urlStr target:(id)_target didFinish:(SEL)_didFinish showProgressBar:(BOOL)_showProgressBar;

@end

