module MainHelper

	def get_start_value
		master_index_object = Index.first
		master_index_object.start_index
	end


	def update_index_position
		master_index_object = Index.first
		master_index_object.start_index += 5
		master_index_object.save
	end

	def get_json_jobs
		url = "http://api.indeed.com/ads/apisearch?publisher=7215096023981984&q=political&l=san+francisco%2C+ca&sort=&radius=&st=&jt=&start=" + get_start_value.to_s + "&limit=5&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2"
		@job_search_xml = HTTP[:accept => "application/json"].get(url)
		@my_json = Crack::XML.parse(@job_search_xml) 

		update_index_position
		@json_jobs = @my_json['response']['results']['result']
	end

	def keep_important_job_attributes(json_jobs)
		@relevant_job_attributes = []
		json_jobs.each do |job|
			new_obj = {}
			new_obj['jobtitle'] = job['jobtitle']
			new_obj['company'] = job['company']
			new_obj['formattedLocation'] = job['formattedLocation']
			new_obj['date'] = job['date']
			new_obj['url'] = job['url']
			@relevant_job_attributes.push(new_obj)

			save_job(new_obj)
		end
		@relevant_job_attributes
	end

	def save_job(job)
		Job.create!(:title => job['jobtitle'],
			:company => job['company'],
			:formattedLocation => job['formattedLocation'],
			:date => job['date'],
			:url => job['url'],
			)
	end
end
