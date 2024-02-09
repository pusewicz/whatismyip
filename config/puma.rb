port ENV.fetch('PORT', 3000)

rails_env = ENV.fetch("RACK_ENV", "development")
environment rails_env

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 3 }
threads threads_count, threads_count

if rails_env == "production"
  processors_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 1 })
  if processors_count > 1
    workers worker_count
  else
    preload_app!
  end
end
