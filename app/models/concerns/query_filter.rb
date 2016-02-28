module QueryFilter
  extend ActiveSupport::Concern

  module ClassMethods
    def apply(attrs)
      query = self
      attrs.each do |name, value|
        unless value.empty?
          if self.respond_to? "filter_#{name}"
            query = query.send("filter_#{name}", value)
          elsif name =~ /(\w*?)_(from|to)$/
            column, op = $1, { from: '>=' , to: '<=' }[$2.to_sym]
            query = query.where("#{self.table_name}.#{column} #{op} ?", DateTime.strptime(value, "%m/%d/%Y"))
          elsif name =~ /(\w*?)_(more|less)$/
            column, op = $1, { more: '>=' , less: '<=' }[$2.to_sym]
            query = query.where("#{self.table_name}.#{column} #{op} ?", value)
          elsif value.kind_of?(Array)
            query = query.where("#{self.table_name}.#{name} IN (?)", value)
          elsif value == "0"
            query = query.all
          else
            query = query.where("#{self.table_name}.#{name} LIKE ?", "%#{value}%")
          end
        end
      end
      query
    end
  end
end