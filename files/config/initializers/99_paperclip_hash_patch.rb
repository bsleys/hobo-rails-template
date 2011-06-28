# Paperclip::Attachment#hash returns a string which is not conforming
# to Kernel#hash standard, so it can not be used as a key in Hash.
#
# This patch renames Paperclip::Attachment#hash to #secure_hash and
# restores original #hash behavior.

module Paperclip
  class Attachment
    alias_method :secure_hash, :hash
    remove_method :hash
  end

  module Interpolations
    def hash attachment, style_name
      attachment.secure_hash(style_name)
    end
  end
end

