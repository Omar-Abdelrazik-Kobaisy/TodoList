//
//  Edit_protocol.h
//  TodoList
//
//  Created by Omar on 18/01/2023.
//

#import <Foundation/Foundation.h>
#import "Todoitem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol Edit_protocol <NSObject>

-(void)edit:(Todoitem*) item;

@end

NS_ASSUME_NONNULL_END
