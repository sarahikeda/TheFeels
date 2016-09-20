class SentimentAnalyzerService
  def initialize
    @analyzer = Sentimental.new
    @analyzer.load_defaults
  end

  def get_sentiment(email)
    email.sentiment = @analyzer.sentiment email.text
    email.save
  end

  def get_sentiment_score(email)
    email.score = @analyzer.score email.text
    email.save
  end
end