module ContentProcessor
  extend ActiveSupport::Concern

  def self.process(text)
    RDiscount.new(text || "", :smart, :filter_html).to_html
  end

  module ClassMethods
    def process_content *fields
      before_validation(
        Proc.new do |record|
          fields.each do |field|
            if record.respond_to?("#{field}_html=") && record.respond_to?(field)
              record.send("#{field}_html=", ContentProcessor.process(record.send field))
            end
          end
        end
      )
    end
  end
end
