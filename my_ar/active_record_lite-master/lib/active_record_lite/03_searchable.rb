require_relative 'db_connection'
require_relative '02_sql_object'

module Searchable
  def where(params)
  	cols = params.keys.map { |n| "#{n} = ?" }.join(" AND ")
  	p cols
  	vals = params.values
    new_instances = DBConnection.execute2(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{cols}

    SQL
    new_instances[1..-1].map { |attributes| self.new(attributes) }
  end
end

class SQLObject
  extend Searchable
end
