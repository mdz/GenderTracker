module Metrics
  class Default

    DECOMPOSITIONS = [ ]

    class << self
      def get_name
        "default"
      end
    end

    def initialize
      # make sure to define which decomposition your metric needs
      # it should be a class name.
      @decompositions = []
    end

    def process(article)

      if !article.is_a?(String) && !article.is_a?(Article)
        raise ArgumentError
      end

      if article.is_a?(String)
        @article = Article.new(article)
      else
        @article = article
      end

      # check if the article has required decompositions. If not
      # decompose it.
      @decompositions.each do |d_class|
        if !@article.has_decomposition?(d_class.get_name)
          d_instance = d_class.new
          d_instance.process(@article)
        end
      end

      # process your article to extract valid metrics.
    end

  end
end