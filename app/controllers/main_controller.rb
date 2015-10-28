class MainController < ApplicationController
	include MainHelper
	require "http"
	require "crack"
	require "json"

	def new_jobs
		@json_jobs = get_json_jobs
		@relevant_job_attributes = keep_important_job_attributes(@json_jobs)
		@output_json = {'jobs' => @relevant_job_attributes}
		render json: JSON.pretty_generate(@output_json)
	end

	def all_jobs
		@all_jobs = Job.all
	end

	def reset
		clear_job_database
		reset_index
	end
end
