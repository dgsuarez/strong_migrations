module StrongMigrations
  module SchemaDumper
    def initialize(connection, *args)
      return super unless StrongMigrations.alphabetize_schema

      super(WrappedConnection.new(connection), *args)
    end
  end

  class WrappedConnection
    delegate_missing_to :@connection

    def initialize(connection)
      @connection = connection
    end

    def columns(*args)
      @connection.columns(*args).sort_by(&:name)
    end

    def extensions(*args)
      @connection.extensions(*args).sort
    end
  end
end
