require_relative 'test_helper'

class AppTest < Minitest::Test
  include Rack::Test::Methods

  # Stands in for PG::Connection so tests don't need a live database
  class FakeConnection
    attr_reader :closed

    def exec(_sql)
      yield [{ 'now' => '2026-06-05 12:00:00+00' }]
    end

    def close
      @closed = true
    end
  end

  def app
    Sinatra::Application
  end

  def test_ping_returns_pong
    get '/ping'

    assert_predicate last_response, :ok?
    assert_equal 'pong', last_response.body
  end

  def test_current_time_returns_database_time
    conn = FakeConnection.new

    PG.stub(:connect, conn) do
      get '/current_time'
    end

    assert_predicate last_response, :ok?
    assert_equal '2026-06-05 12:00:00+00', last_response.body
  end

  def test_current_time_closes_the_connection
    conn = FakeConnection.new

    PG.stub(:connect, conn) do
      get '/current_time'
    end

    assert conn.closed, 'expected the database connection to be closed'
  end
end
