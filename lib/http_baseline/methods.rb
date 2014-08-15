module HttpBaseline
  module Methods

    def set_headers_by(c_type)
      type = case c_type
               when /json/i
                 'application/json'
               when /form/i
                 'application/x-www-form-urlencoded'
               else
                 c_type
             end
      connection.add_header 'Content-Type', type unless c_type.nil? || c_type.empty?
    end

  end
end