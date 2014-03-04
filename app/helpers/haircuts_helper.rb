module HaircutsHelper
  def photo_url(haircut)
    if cookies[:isRetina]
      haircut.photo(:retina)
    else
      haircut.photo(:normal)
    end
  end
end
