namespace :db do
  desc 'Seed database'
  task seed: :settings do
    require 'sequel'
    require 'sequel/extensions/seed'
    require_relative '../../config/environment'
    Sequel.extension :seed

    seeds = File.expand_path('../../db/seeds', __dir__)
    DB = Sequel.connect(Settings.db.url || Settings.db.to_hash)

    Sequel::Seeder.apply(DB, seeds)
  end
end
