require "unpwn"

# Validator class for passwords
#
# ==== Examples
#
# Validates that attribute is not pwned, but only in production.
#
#   class User < ActiveRecord::Base
#     validates :password, unpwned: true, if: -> { Rails.env.production? }
#   end
#
# Validates that attribute meets min/max and is not pwned.
#
#   class User < ActiveRecord::Base
#     validates :password, unpwned: { min: 12, max: 128 }
#   end
class UnpwnedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unpwn = Unpwn.new(**options.slice(:min, :max, :request_options))

    if unpwn.min && value.length < unpwn.min
      record.errors.add attribute, "is too short"
    end

    if unpwn.max && value.length > unpwn.max
      record.errors.add attribute, "is too long"
    end

    if unpwn.pwned?(value)
      record.errors.add attribute, options.fetch(:message,
        "is in common password lists, please choose something more unique")
    end
  end
end
