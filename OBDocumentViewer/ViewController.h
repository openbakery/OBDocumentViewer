//
//  ViewController.h
//  DocumentViewer
//
//  Created by Rene Pirringer on 17.12.15.
//  Copyright © 2015 Rene Pirringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

@interface ViewController : UIViewController <UIDocumentMenuDelegate, UIDocumentPickerDelegate, QLPreviewControllerDataSource>


@end

