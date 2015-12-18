//
//  ViewController.m
//  DocumentViewer
//
//  Created by Rene Pirringer on 17.12.15.
//  Copyright © 2015 Rene Pirringer. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuickLook/QuickLook.h>

@interface ViewController ()

@property(nonatomic, strong) NSURL *url;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (NSString *)universalTypeIdentifierForFileExtension:(NSString *)extension
{
	return (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef)extension , NULL);
}

- (IBAction)openPressed:(id)sender {
	NSArray *utis = @[
										[self universalTypeIdentifierForFileExtension:@"doc"],
										[self universalTypeIdentifierForFileExtension:@"docx"],
										[self universalTypeIdentifierForFileExtension:@"txt"],
										[self universalTypeIdentifierForFileExtension:@"xls"],
										[self universalTypeIdentifierForFileExtension:@"xlsx"],
										];
	
	UIDocumentMenuViewController *importMenu = [[UIDocumentMenuViewController alloc] initWithDocumentTypes:utis inMode:UIDocumentPickerModeImport];
	
	importMenu.delegate = self;
	
	[self presentViewController:importMenu animated:YES completion:nil];
}

- (void)documentMenu:(UIDocumentMenuViewController *)documentMenu didPickDocumentPicker:(UIDocumentPickerViewController *)documentPicker {
	documentPicker.delegate = self;
	[self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentMenuWasCancelled:(UIDocumentMenuViewController *)documentMenu {

}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
	self.url = url;
	QLPreviewController *qlPreviewController = [[QLPreviewController alloc] init];
	qlPreviewController.currentPreviewItemIndex = 0;
	qlPreviewController.dataSource = self;
	//qlPreviewController.delegate = self;

	[self presentViewController:qlPreviewController animated:YES completion:nil];

}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController {
	return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
	return self.url;

}


@end
