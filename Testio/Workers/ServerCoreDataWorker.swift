import Foundation
import CoreData

extension ManagedServer {
    
    convenience init(context: NSManagedObjectContext, server: Server) {
        self.init(context: context)
        self.name = server.name
        self.distance = Int64(server.distance ?? 0)
    }
    
    func toServer() -> Server {
        return Server(name: name, distance: Int(distance))
    }
}

class ServerCoreDataWorker {
    
    static let shared = ServerCoreDataWorker()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestioModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent container: \(error)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetch() -> [Server] {
        do {
            let result = try viewContext.fetch(ManagedServer.fetchRequest())
            return result.map({ $0.toServer() })
        } catch {
            return []
        }
    }
    
    func save(servers: [Server]) {
        do {
            let _ = servers.map({ ManagedServer(context: viewContext, server: $0) })
            try viewContext.save()
        } catch {
            fatalError("Failed to save: \(error)")
        }
    }
    
    func deleteAll() {
        do {
            let result = try viewContext.fetch(ManagedServer.fetchRequest())
            result.forEach({ viewContext.delete($0) })
            try viewContext.save()
        } catch {
            fatalError("Failed to delete all: \(error)")
        }
    }
}
