class TipVideo {
/* Represent a video object */

    // Static data
    var previewId: String
    var tipVideoId: String
    var authorName: String
    var authorId: String
    
    // Variable data
    var tipNb: Int
    var maxTip: Int
    var priceTip: Int
    
    init(previewId: String, tipVideoId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int) {
        self.previewId = previewId
        self.tipVideoId = tipVideoId
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = tipNb
        self.maxTip = maxTip
        self.priceTip = priceTip
    }
    
    func createTipVideo(previewId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int) {
        self.previewId = previewId
        self.tipVideoId = generateId()
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = 0
        self.maxTip = maxTip
        self.priceTip = priceTip
    }
    
    func updateTipNb() {
        
    }
    
    private func generateId() -> String {
        return "test"
    }
}
