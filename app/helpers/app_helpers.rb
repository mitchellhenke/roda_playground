module AppHelpers
  def page_number
    error_response(400, 'Invalid page number') unless params['page_number'].nil? || params['page_number'].to_i >= 1
    (params['page_number'] || 1).to_i
  end

  def page_size
    error_response(400, 'Invalid page size') unless params['page_size'].nil? || params['page_size'].to_i >= 1
    (params['page_size'] || 100).to_i
  end

  def page_offset
    (page_number - 1) * page_size
  end

  def max_id
    params['max_id'].to_i if params['max_id'].to_i > 0
  end

  def since_id
    params['since_id'].to_i if params['since_id'].to_i > 0
  end

  def limit_dataset(dataset)
    if max_id || since_id
      options = { max_id: max_id, since_id: since_id}
      dataset = dataset.limit_by_id(page_size, options)

    elsif page_number
      dataset = dataset.limit(page_size, page_offset)
    end

    dataset
  end
end

module RodaAppHelpers
  module InstanceMethods
    include AppHelpers
  end
end

Roda.plugin RodaAppHelpers
