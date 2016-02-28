require 'csv'
module ImportExport
  extend ActiveSupport::Concern

  module ClassMethods
    def import(file)
      begin
        if !(file.nil?) and ([ "text/csv", "application/csv", "application/excel", "application/vnd.ms-excel", "application/vnd.msexcel"].include? file.content_type )
          CSV.parse(file.read.gsub(/\r\n?/,"\n"), headers: true, :row_sep => "\n" ) do |row|
            u = self.new row.to_hash
            u.save!
            unless u.persisted?
              u.errors.to_a
              break
            end
          end
          true
        else
          ['Wystapił bład']
        end
      rescue => e
        [e.message]
      end  
    end
    def to_csv(collection, columns=[],options = {})
      CSV.generate(options) do |csv|
        column_names = columns.empty? ? self.column_names : columns
        csv << column_names
        collection.each do |m|
          csv << column_names.collect{|c| m.send(c)}
        end
      end
    end
  end
end