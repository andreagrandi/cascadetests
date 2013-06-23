import bb.cascades 1.0
import bb.data 1.0

Page {
    content: ListView {
        id: myListView
        
        // Associate the list view with the data model that's defined in the
        // attachedObjects list
        dataModel: dataModel
        
        listItemComponents: [
            ListItemComponent {
                type: "item"
                
                // Use a standard list item to display the data in the data
                // model
                StandardListItem {
                    // reserveImageSpace: false
                    title: ListItemData.title
                    description: ListItemData.pubDate
                }
            }
        ]
    }
    
    attachedObjects: [
        GroupDataModel { 
            id: dataModel
            
            // Sort the data in the data model by the "pubDate" field, in
            // descending order, without any automatic grouping
            sortingKeys: ["pubDate"]
            sortedAscending: false
            grouping: ItemGrouping.None 
        },
        DataSource 
        {
            id: dataSource
            
            // Load the XML data from a remote data source, specifying that the
            // "item" data items should be loaded
            source: "http://news.google.com/news?topic=h&output=rss"
            query: "/rss/channel/item"
            type: DataSourceType.Xml
            
            onDataLoaded: 
            {
                // After the data is loaded, clear any existing items in the data
                // model and populate it with the new data
                dataModel.clear();
                dataModel.insertList(data)
            }
        }]

	onCreationCompleted: 
	{
	// When the top-level Page is created, direct the data source to start
	// loading data
	dataSource.load();
	}
}
