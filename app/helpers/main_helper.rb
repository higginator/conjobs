module MainHelper

	def get_start_value
		1
	end

	def get_end_value
		5
	end

	def get_json_jobs
		url = "http://api.indeed.com/ads/apisearch?publisher=7215096023981984&q=political&l=san+francisco%2C+ca&sort=&radius=&st=&jt=&start=" + get_start_value.to_s + "&limit=" + get_end_value.to_s + "&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2" 
		@job_search_xml = HTTP[:accept => "application/json"].get(url)
		@my_json = Crack::XML.parse(@job_search_xml)
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
		end
		@relevant_job_attributes
	end
end
