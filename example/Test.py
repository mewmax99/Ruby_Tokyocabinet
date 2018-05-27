from pyravendb.store import document_store

with document_store.DocumentStore(
    urls=["http://localhost:8080"],  # URL to the Server
                                            # or list of URLs
                                            # to all Cluster Servers (Nodes)

    database="Northwind") as store:         # Default database that DocumentStore will interact with
    
    conventions = store.conventions         # DocumentStore customizations
    
    store.initialize()                      # Each DocumentStore needs to be initialized before use.
                                            # This process establishes the connection with the Server
                                            # and downloads various configurations
                                            # e.g. cluster topology or client configuration
