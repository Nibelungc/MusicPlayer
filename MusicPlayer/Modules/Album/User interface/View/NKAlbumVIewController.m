//
//  NKAlbumVIewController.m
//  MusicPlayer
//
//  Created by Denis Baluev on 07/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NKAlbumVIewController.h"
#import "NKAudioTrack.h"
#import "NKAudioTrackCell.h"

@interface NKAlbumVIewController ()

@property (weak, nonatomic) UITableView* tableView;

@end

@implementation NKAlbumVIewController

@dynamic eventHandler;

#pragma mark - Lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Configuration

- (void) configureView {
    [super configureView];
    
    self.view.backgroundColor = [UIColor magentaColor];
    CGRect tableViewFrame = self.view.bounds;
    UITableView* tableView = [[UITableView alloc] initWithFrame: tableViewFrame
                                                          style: UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    self.tableView = tableView;
}

#pragma mark - NKAlbumView

- (void) setModuleTitle: (NSString*) title {
    self.navigationItem.title = title.uppercaseString;
}

- (void) showEmptyListOfAudioTracks {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void) updateListOfAudioTracks: (NSArray <NKAudioTrack *>*) audioTracks {
    self.audioTracks = audioTracks;
    [self reloadData];
    [self.eventHandler albumWasLoaded];
}

- (void) reloadData {
    [self.tableView reloadData];
}

#pragma mark - Private

- (NKAudioTrack*) audioTrackForIndexPath: (NSIndexPath*) indexPath {
    if (indexPath.row >= 0 &&
        indexPath.row < self.audioTracks.count) {
        return self.audioTracks[indexPath.row];
    }
    return nil;
}

@end

#pragma mark - UITableViewDataSource

@implementation NKAlbumVIewController (TableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.audioTracks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NKAudioTrackCell* cell = [tableView dequeueReusableCellWithIdentifier: [NKAudioTrackCell reuseIdentifier]];
    if (!cell) {
        cell = [NKAudioTrackCell createCell];
    }
    NKAudioTrack* track = [self audioTrackForIndexPath: indexPath];
    [cell configureCellWithTrack: track];
    return cell;
}

@end

#pragma mark - UITableViewDelegate

@implementation NKAlbumVIewController (TableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NKAudioTrack* selectedTrack = [self audioTrackForIndexPath: indexPath];
    [self.eventHandler selectAudioTrackWithID: selectedTrack.identifier];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NKAudioTrack* selectedTrack = [self audioTrackForIndexPath: indexPath];
    [self.eventHandler deselectAudioTrackWithID: selectedTrack.identifier];
}

@end