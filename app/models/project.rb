class Project < ActiveRecord::Base
	validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  	
	mount_uploader :attachment, AttachmentUploader

  validates_presence_of :attachment
  validates_integrity_of :attachment
  validates_processing_of :attachment

	attr_accessor :remove_attachment_file

	before_save :perform_attachment_removal

	def perform_attachment_removal
  		if remove_attachment_file == '1' && !self.attachment.cached?.present?
  			self.remove_attachment!
  		end
  	end

  	def created_time
        # Time.zone.parse(created_at.strftime("%Y-%m-%d %H:%M:%S"))
        created_at.strftime("%Y-%m-%d %H:%M:%S")
    end

    def updated_time
        # Time.zone.parse(created_at.strftime("%Y-%m-%d %H:%M:%S"))
        updated_at.strftime("%Y-%m-%d %H:%M:%S")
    end
end
