namespace :db do
  desc "Reseting database with drop, create, migrate and seed"
  task restart: %w[db:drop db:create db:migrate db:seed] do
    puts ''
    puts 'Database successfully reseted!'
    puts ''
  end
end
