# encoding: utf-8

module ContentProcessor
  extend ActiveSupport::Concern

  def self.process(text)
    RDiscount.new(expand_image_tag(text || ""), :smart, :filter_html).to_html
  end

  def self.expand_image_tag(text)
    return text.gsub(/image_asset\#(.*){24}/) do |match|
      a = Asset.find(match.split("#").last)
      if a
        "![#{a.title}](#{a.file.url} \"#{a.title}\")"
      else
        ""
      end
    end
  end

  module ClassMethods
    def process_content *fields
      fields.each do |f|
        field "#{f}", type: String
        field "#{f}_processed", type: String
      end

      before_validation(
        Proc.new do |record|
          fields.each do |field|
            record.send("#{field}_processed=", ContentProcessor.process(record.send field))
          end
        end
      )
    end
  end
end
