//
//  MainTableViewController.m
//  ImageViewerTableView
//
//  Created by 白彬涵 on 2017/4/21.
//  Copyright © 2017年 China Moble IOT. All rights reserved.
//

#import "MainTableViewController.h"
#import "TZImagePickerController.h"

@interface MainTableViewController ()<TZImagePickerControllerDelegate>
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int count;
@property (nonatomic, assign) BOOL isAnimation;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _images = [NSMutableArray new];
    _count = 0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addImages:(id)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:12 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [_images addObjectsFromArray:photos];
        [self.tableView reloadData];
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}
- (IBAction)playButtonClicked:(id)sender {
    if (_isAnimation) {
        [_timer invalidate];
        _timer = nil;
    }
    else {
        _timer = [NSTimer timerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [UIView animateWithDuration:3.0 animations:^{
                CGFloat y = self.tableView.contentOffset.y;
                if ((y+200)<=(self.tableView.contentSize.height-UIScreen.mainScreen.bounds.size.height)) {
                    self.tableView.contentOffset = CGPointMake(0, y+200);
                }
            }];
        }];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    _isAnimation = !_isAnimation;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _images.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:1024];
    imageView.image = _images[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIImage *image = _images[indexPath.row];
    CGFloat tem = image.size.width/image.size.height;
    return width/tem;
}

@end
