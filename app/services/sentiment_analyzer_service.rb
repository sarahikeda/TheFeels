class SentimentAnalyzerService
  def initialize
    @analyzer = Sentimental.new
    @analyzer.load_defaults
  end

  def get_sentiment(emails)
    emails.each do |email|
      email.update(sentiment: @analyzer.sentiment(email.text) , score: @analyzer.score(email.text))
    end
  end

end
