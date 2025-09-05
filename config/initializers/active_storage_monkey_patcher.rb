Rails.configuration.to_prepare do
    ActiveStorage::Blob.class_eval do
      # Monkey patch key property with prefix.
      def key
        self[:key] ||= "archive/#{self.class.generate_unique_secure_token}"
      end
    end
end