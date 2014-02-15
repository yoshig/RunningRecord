require_relative 'db_connection'
# require_relative '01_mass_object' <= deprecated
require_relative '00_attr_accessor_object.rb'
require_relative '03_searchable.rb'
require 'active_support/inflector'

class MassObject < AttrAccessorObject

  my_attr_accessor(:table_name, :attributes)

  def self.parse_all(results)
    results.map do |instance|
      self.new(instance)
    end
  end
end

class SQLObject < MassObject
  def self.columns
    query = <<-SQL
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT 1
    SQL
    @columns ||= DBConnection.execute2(query)[0].map { |name| name.to_sym }
    @columns.each { |name| send(:attr_accessor, name) }
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.downcase.pluralize
  end

  def self.all
    query = <<-SQL
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    all_cats = DBConnection.execute2(query)
    all_cats[1..-1].map do |cat|
      Cat.new(cat)
    end
  end

  def self.find(id)
    query = <<-SQL
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = #{id}
    SQL
    self.new(DBConnection.execute(query)[0])
  end

  def attributes(params)
    @attributes = params
  end

  def insert
    insertion = <<-SQL
      INSERT INTO
        #{self.class.table_name} (#{self.class.columns[1..-1].join(", ")})
      VALUES
        (#{attribute_values.to_s[1..-2]})

    SQL
    DBConnection.execute(insertion)
    @id = DBConnection.last_insert_row_id

  end

  def initialize(params = {})
    attributes(params)
    params.each do |name, val|
      unless self.class.columns.include?(name.to_sym)
        raise "unknown atribute #{name}" 
      end
      send("#{name}=", val)
    end
  end

  def save
    id.nil? ? insert : update
  end

  def update
    params = attribute_values[1..-1]
    p params
    DBConnection.execute2(<<-SQL, *params)

      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = #{attribute_values[0]}
    SQL
    
  end

  def attribute_values
    vals =  @attributes.keys.map do |x|
      send(x)
    end
    vals
  end

  def set_line
    self.class.columns[1..-1].map do |col|
      "#{col} = ?"
    end.join(', ')
  end
end

# class Human < SQLObject
# end
# DBConnection.reset
# Human.table_name = "humans"
# Human.find(2)

