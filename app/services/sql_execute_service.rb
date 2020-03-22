class SqlExecuteService
  class << self
    def select_all(sql, sanitizing_values={})
      if sanitizing_values.present?
        sql = ActiveRecord::Base.send(:sanitize_sql_array, [sql, sanitizing_values])
      end
      pg = ActiveRecord::Base.connection
      @@type_map ||= PG::BasicTypeMapForResults.new(pg.raw_connection)

      result = pg.execute(sql)
      result.type_map = @@type_map
      result.to_a
    end
  end
end
