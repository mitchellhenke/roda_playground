require 'roda'

class App < Roda
  plugin :environments
  plugin :indifferent_params
  plugin :sinatra_helpers
  route do |r|
    r.root do
      dataset = User.dataset.order(:id.desc)
      users = limit_dataset(dataset)
      users.select_map([:id, :name]).to_s
    end
  end
end

Unreloader.require('app/helpers'){}
Unreloader.record_split_class(__FILE__, 'app/helpers')
