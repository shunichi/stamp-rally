module EnvHelper
  module ExampleMethods
    def set_envs(envvars)
      envvars = envvars.stringify_keys
      prev_envs = envvars.keys.map{|k| [k, ENV[k]] }.to_h
      envvars.each{|k,v| ENV[k] = v}
      yield
      prev_envs.each{|k,v| ENV[k] = v}
    end
  end

  module Macros
    def set_envs_around(envvars)
      around(:each) do |example|
        set_envs(envvars, &example)
      end
    end
  end
end

RSpec.configure do |config|
  config.include EnvHelper::ExampleMethods
  config.extend EnvHelper::Macros
end
