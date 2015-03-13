module HomeHelper
  def home_cache_key_for_haircuts
    count = Haircut.count
    max_updated_at = Haircut.maximum(:updated_at).try(:utc).try(:to_s, :number)
    admin = current_admin.present?
    "haircuts/all-#{count}-#{max_updated_at}-admin-#{admin}"
  end
end
