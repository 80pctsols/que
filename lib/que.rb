# frozen_string_literal: true

require 'forwardable'
require 'socket' # For Socket.gethostname
require 'json'

module Que
  CURRENT_HOSTNAME = Socket.gethostname.freeze
  DEFAULT_QUEUE    = 'default'.freeze

  class Error < StandardError; end

  require_relative 'que/assertions'
  require_relative 'que/config'
  require_relative 'que/connection_pool'
  require_relative 'que/helpers'
  require_relative 'que/job'
  require_relative 'que/job_queue'
  require_relative 'que/listener'
  require_relative 'que/locker'
  require_relative 'que/migrations'
  require_relative 'que/poller'
  require_relative 'que/result_queue'
  require_relative 'que/sql'
  require_relative 'que/version'
  require_relative 'que/worker'

  class << self
    extend Forwardable
    include Helpers

    # Copy some commonly-used methods here, for convenience.
    def_delegators :pool, :execute, :checkout, :in_transaction?
    def_delegators Job, :enqueue, :run_synchronously, :run_synchronously=
    def_delegators Migrations, :db_version, :migrate!
  end
end
