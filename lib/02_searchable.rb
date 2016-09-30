require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map { |key| "#{key.to_s} = ?" }.join(" AND ")
    response = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(response)
  end
end

class SQLObject
  extend Searchable
end
