//
//  DataProviderProtocol.h
//  CodeChallenge
//
//  Created by alexey novikov on 31.03.2018.
//

#import <Foundation/Foundation.h>

@protocol DataConsumer;


// for each of two of our UIViewControllers there will be two different objects implementing this protocol.
// UIViewControllers will have strong references to those objects, and provide a callback reference to themselves via
// the `dataConsumer` property.
// Each object that will implement this method will have an NSFetchedResultsController instance inside of it,
// and will be the delegate for that NSFetchedResultsController. These implementation details are never exposed,
// thus providing abstraction for the data layer.
@protocol DataProviderProtocol <NSObject>
@optional
    - (void)refresh;
    - (id)cellModelAtRow:(NSUInteger)row;

    @property (nonatomic, readonly) NSUInteger numberOfRows;

    // our UIViewController. will be notified in two different cases:
    // 1. when the incorporated NSFetchedResultsController fires controllerDidChangeContent: or
    // 2. an image has been downloaded for a row.
    @property (weak, nonatomic) id<DataConsumer> dataConsumer;
@end


// UIViewControllers will implement this and decide whether or not to reload the data for the entire table,
// or for just one row, in case of the image download
@protocol DataConsumer <NSObject>
    - (void)dataProvider:(id<DataProviderProtocol>)dataProvider didChangeImageForRowAtIndex:(NSUInteger)index;
    - (void)dataProviderDidChangeData:(id<DataProviderProtocol>)dataProvider;
@end

