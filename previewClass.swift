class preview {
/* Represent a thumbnailLink object */

    // Static data
    var previewId: String
    var authorId: String
    var authorName: String
    var thumbnailLink: String
    var tipVideoId: String
    
    // Variable data
    var tipNb: Int
    
    init(previewId: String, authorId: String, authorName: String, thumbnailLink: String, tipVideoId: String, tipNb: Int) {
        self.previewId = previewId
        self.authorId = authorId
        self.authorName = authorName
        self.thumbnailLink = thumbnailLink
        self.tipVideoId = tipVideoId
        self.tipNb = tipNb
    }
    
    func createPreview() {
        self.previewId = generateId()
        self.authorId = authorId
        self.authorName = authorName
        self.thumbnailLink = thumbnailLink
        self.tipVideoId = tipVideoId
        self.tipNb = 0        
    }
    
    func updatethumbnailLink() {
        
    }
    
    func updateTipNb() {
        
    }
    
    private func generateId() {
        
    }
}