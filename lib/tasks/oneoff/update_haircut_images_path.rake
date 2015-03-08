namespace :oneoff do
  task update_haircut_images_path: :environment do
    Haircut.find_each do |haircut|
      unless haircut.photo_file_name.blank?
        filename = "#{Rails.root}/public/system/haircuts/photos/000/000/#{'%03d' % haircut.id}/original/#{haircut.photo_file_name}"

        if File.exists? filename
          puts "Re-saving photo attachment for Haircut: #{haircut.id}"
          image = File.new filename
          haircut.photo = image
          haircut.save
          image.close
          haircut.photo.reprocess!
        end
      end
    end
  end
end
