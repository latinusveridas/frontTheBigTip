class tipVideo {
/* Represent a video object */

    // Static data
    var previewId: String
    var tipVideoId: String
    var authorName: String
    var authorId: String
    
    // Variable data
    var tipNb: Int
    let maxTip: Int
    let priceTip: Int
    
    init(previewId: String, tipVideoId: String, tipNb: Int, authorName: String, authorId: String) {
        self.previewId = previewId
        self.tipVideoId = tipVideoId
        self.tipNb = tipNb
        self.authorName = authorName
        self.authorId = authorId
    }
    
    func createTipVideo() {
        self.previewId = previewId
        self.tipVideoId = generateId()
        self.tipNb = 0
        self.authorName = authorName
        self.authorId = authorId
    }
    
    func updateTipNb() {
        
    }
    
    private func generateId() {
        
    }
}