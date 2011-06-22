# Force views to load at startup instead of rails autoloading so we have a widget list
# UPDATE: sadly, this breaks development mode auto-reloading on each request
#Dir.glob(Rails.root.join('lib/gui/**/*.rb')).each do |f|
#	f.sub! "#{Rails.root}/lib/", ''
#	f.sub! ".rb", ''
#	require f
#end
