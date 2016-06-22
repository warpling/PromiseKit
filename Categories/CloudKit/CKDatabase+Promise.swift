import CloudKit.CKDatabase
#if !COCOAPODS
import PromiseKit
#endif

/**
 To import the `CKDatabase` category:

    use_frameworks!
    pod "PromiseKit/CloudKit"
 
 And then in your sources:

    #import <PromiseKit/PromiseKit.h>
*/
extension CKDatabase {
    public func fetchRecordWithID(recordID: CKRecordID) -> Promise<CKRecord> {
        return Promise { fetch(withRecordID: recordID, completionHandler: $0.resolve) }
    }

    public func fetchRecordZoneWithID(recordZoneID: CKRecordZoneID) -> Promise<CKRecordZone> {
        return Promise { fetch(withRecordZoneID: recordZoneID, completionHandler: $0.resolve) }
    }

    public func fetchSubscriptionWithID(subscriptionID: String) -> Promise<CKSubscription> {
        return Promise { fetch(withSubscriptionID: subscriptionID, completionHandler: $0.resolve) }
    }

    public func fetchAllRecordZones() -> Promise<[CKRecordZone]> {
        return Promise { fetchAll(completionHandler: $0.resolve) }
    }

    public func fetchAllSubscriptions() -> Promise<[CKSubscription]> {
        return Promise { fetchAll(completionHandler: $0.resolve) }
    }

    public func save(record: CKRecord) -> Promise<CKRecord> {
        return Promise { saveRecord(record, completionHandler: $0.resolve) }
    }

    public func save(recordZone: CKRecordZone) -> Promise<CKRecordZone> {
        return Promise { saveRecordZone(recordZone, completionHandler: $0.resolve) }
    }

    public func save(subscription: CKSubscription) -> Promise<CKSubscription> {
        return Promise { saveSubscription(subscription, completionHandler: $0.resolve) }
    }

    public func deleteRecordWithID(recordID: CKRecordID) -> Promise<CKRecordID> {
        return Promise { delete(withRecordID: recordID, completionHandler: $0.resolve) }
    }

    public func deleteRecordZoneWithID(zoneID: CKRecordZoneID) -> Promise<CKRecordZoneID> {
        return Promise { delete(withRecordZoneID: zoneID, completionHandler: $0.resolve) }
    }

    public func deleteSubscriptionWithID(subscriptionID: String) -> Promise<String> {
        return Promise { delete(withSubscriptionID: subscriptionID, completionHandler: $0.resolve) }
    }

    public func performQuery(query: CKQuery, inZoneWithID zoneID: CKRecordZoneID? = nil) -> Promise<[CKRecord]> {
        return Promise { performQuery(query, inZoneWithID: zoneID, completionHandler: $0.resolve) }
    }

    public func performQuery(query: CKQuery, inZoneWithID zoneID: CKRecordZoneID? = nil) -> Promise<CKRecord?> {
        return Promise { sealant in
            performQuery(query, inZoneWithID: zoneID) { records, error in
                sealant.resolve(records?.first, error)
            }
        }
    }

    public func fetchUserRecord(container: CKContainer = CKContainer.defaultContainer()) -> Promise<CKRecord> {
        return container.fetchUserRecordID().then(on: zalgo) { uid -> Promise<CKRecord> in
            return self.fetchRecordWithID(uid)
        }
    }
}
